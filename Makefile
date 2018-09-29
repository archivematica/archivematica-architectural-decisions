.DEFAULT_GOAL := build

install:
	yarn global add adr-log

build: install
	adr-log -i README.md
