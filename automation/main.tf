
locals {
  teams        = yamldecode(file("${path.module}/../teams.yaml"))

  org_user_map = {for user in data.github_organization.org.users : user.login => user}
}

data "github_organization" "org" {
  name = var.github_owner
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
