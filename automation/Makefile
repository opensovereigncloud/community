STATE_BRANCH := state
STATE_DIR    := .state

.PHONY: state-checkout state-commit state-status

state-checkout:
	@if [ -d "$(STATE_DIR)" ]; then \
		echo "State worktree already exists at '$(STATE_DIR)'."; \
	else \
		git worktree add $(STATE_DIR) $(STATE_BRANCH) && \
		echo "State worktree created at '$(STATE_DIR)'."; \
	fi

state-commit:
	@git -C $(STATE_DIR) add terraform.tfstate && \
	if git -C $(STATE_DIR) diff --cached --quiet; then \
		echo "No state changes to commit."; \
	else \
		git -C $(STATE_DIR) commit -s -q -m "Update state $$(date -u +%Y-%m-%dT%H:%M:%SZ)" && \
		echo "State committed on '$(STATE_BRANCH)' branch."; \
	fi

state-status:
	@git -C $(STATE_DIR) status
