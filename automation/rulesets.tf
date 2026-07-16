resource "github_organization_ruleset" "default_release" {
  name        = "Protect default and release branches"
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = [
        "~DEFAULT_BRANCH",
        "refs/heads/release-*",
      ]
      exclude = []
    }

    repository_property {
      include {
        name            = "visibility"
        property_values = ["public"]
        source          = "system"
      }
    }
  }

  rules {
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true

    pull_request {
      required_approving_review_count = 1
      allowed_merge_methods = [
        "rebase",
        "squash",
      ]
    }

    required_status_checks {
      required_check {
        context        = "DCO"
        integration_id = data.github_app.apps["dco"].id
      }
    }

    required_workflows {
      do_not_enforce_on_create = false

      required_workflow {
        repository_id = module.repositories["community"].repo_id
        ref           = "main"
        path          = ".github/workflows/reuse.yml"
      }
    }

    commit_message_pattern {
      name     = "Commit message must contain a Signed-off-by line"
      operator = "regex"
      pattern  = "(?m)Signed-off-by: [^<]+ <[^@]+@[^>]+>"
    }
  }
}
