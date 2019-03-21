define USAGE
Super awesome hand-crafted build system ⚙️

Commands:
	init     		Install Python dependencies with pipenv
	test     		Run linters, test db migrations and tests.
	serve    		Run app in dev environment (localhost:3000).
	invoke   		Invoke function with event.json as an input
	new-bucket MY_BUCKET    Create S3 bucket
	package MY_BUCKET   	Package Lambda function and upload to S3
	deploy MY_BUCKET   	Deploy SAM template as a CloudFormation stack
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

new-bucket:
	aws s3 mb s3://$(filter-out $@,$(MAKECMDGOALS))

package:
	sam package \
    --output-template-file packaged.yaml \
    --s3-bucket $(filter-out $@,$(MAKECMDGOALS))

deploy:
	sam deploy \
    --template-file packaged.yaml \
    --stack-name botmakerd \
    --capabilities CAPABILITY_IAM