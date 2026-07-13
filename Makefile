# Convenience shortcuts — hooks/CI still call scripts/validate.sh directly.
.PHONY: check bootstrap hooks version

check:
	bash scripts/validate.sh

bootstrap:
	bash scripts/bootstrap.sh

hooks:
	git config core.hooksPath .githooks
	chmod +x .githooks/*

version:
	bash scripts/bump-version.sh
