define USAGE
Super awesome hand-crafted build system ⚙️

Commands:
	init      Install Python dependencies with pipenv
	test      Coming Soon (Run linters, test db migrations and tests.)
	serve     Run app in dev environment (localhost:3000).
endef

export USAGE

PIPENV := pipenv

help:
	@echo "$$USAGE"

install-pipenv:
	pip3 install pipenv --user


check-pipenv:
	$(foreach bin,$(PIPENV),\
    	$(if $(shell command -v $(bin) 2> /dev/null),$(info Found `$(bin)`),$(error Install `$(bin)` or add in PATH)))

init: install-pipenv check-pipenv
	pipenv run pip3 install boto3 pytest pytest-mock

test: check-pipenv
	pipenv run python -m pytest tests/ -v

serve: check-pipenv
	pipenv run sam local start-api

invoke: check-pipenv
	pipenv run sam local invoke WebHookFunction --event event.json