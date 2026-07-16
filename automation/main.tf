
locals {
  teams        = yamldecode(file("${path.module}/../teams.yaml"))
  repositories = yamldecode(file("${path.module}/../repositories.yaml"))

  org_user_map = { for user in data.github_organization.org.users : user.login => user }

  # List of app slugs used by required_status_checks in repositories. Used to fetch app IDs.
  app_slugs = toset(concat(
    ["dco"], # The dco slug is needed for the 'require_signatures' org-wide ruleset
    flatten([for repo in local.repositories : keys(try(repo.required_status_checks, {}))]),
  ))
}

data "github_organization" "org" {
  name = var.github_owner
}

data "github_app" "apps" {
  for_each = local.app_slugs
  slug     = each.key
}

module "teams" {
  source   = "./modules/github_team"
  for_each = { for team in local.teams : team.name => team }

  name        = each.value.name
  description = each.value.description
  members = [for member in each.value.members : {
    username = member
    role     = local.org_user_map[member].role == "ADMIN" ? "maintainer" : "member"
  }]
}

module "repositories" {
  source   = "./modules/github_repository"
  for_each = { for repo in local.repositories : repo.name => repo }

  name = each.value.name

  collaborator_teams = try(each.value.collaborators.teams, null)

  # If repos have required status checks, build a ruleset for them.
  rulesets = length(try(each.value.required_status_checks, {})) == 0 ? [] : [
    {
      name        = "Required status checks"
      target      = "branch"
      enforcement = "evaluate"
      conditions = {
        ref_name = {
          include = ["~DEFAULT_BRANCH", "refs/heads/release-*"]
          exclude = []
        }
      }
      rules = {
        required_status_checks = {
          required_check = flatten([
            for app_slug, contexts in each.value.required_status_checks : [
              for context in contexts : {
                context        = context
                integration_id = data.github_app.apps[app_slug].id
              }
            ]
          ])
        }
      }
    }
  ]
}
