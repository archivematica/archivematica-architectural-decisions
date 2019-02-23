.DEFAULT_GOAL := check

install:
	yarn global add adr-log

index: install
	adr-log -i README.md

check:
	pre-commit run --all-files
