resource "github_organization_ruleset" "require_signatures" {
  name        = "Require signatures"
  target      = "branch"
  enforcement = "evaluate"

  conditions {
    ref_name {
      include = ["~ALL"]
      exclude = []
    }

    repository_name {
      include = ["~ALL"]
      exclude = []
    }
  }

  rules {
    required_signatures     = true

    commit_message_pattern {
      name     = "Commit message must contain a Signed-off-by line"
      operator = "regex"
      pattern  = "(?m)Signed-off-by: .+ <.+@.+>"
    }
  }
}

resource "github_organization_ruleset" "default_release" {
  name        = "Protect default and release branches"
  target      = "branch"
  enforcement = "evaluate"

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
    deletion         = true
    non_fast_forward = true

    pull_request {
      required_approving_review_count = 1
      allowed_merge_methods           = [
        "rebase",
        "squash",
      ]
    }
    
    required_status_checks {
      required_check {
        context        = "DCO"
      }
    }
  }
}
