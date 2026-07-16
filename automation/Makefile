STATE_BRANCH := state
STATE_DIR    := .state

TOFU := tofu
GIT  := git -C $(STATE_DIR)

.PHONY: state-checkout state-commit state-status

.state:
	git worktree add $(STATE_DIR) $(STATE_BRANCH)

.PHONY: plan
plan: .state
	$(GIT)  pull
	$(TOFU) plan

.PHONY: apply
apply: .state
	$(GIT)  pull
	$(TOFU) apply
	$(GIT)  commit --signoff --quiet --message "Update state $$(date -u +%Y-%m-%dT%H:%M:%SZ)"
	$(GIT)  push

state-status: .state
	$(GIT) status
