.PHONY: test test-docker verify-github-token

test:
	poetry run pytest -x -s

IDEAS_GITHUB_TOKEN_FILE=.ideas-github-token

verify-github-token:
	@echo "Verifying GitHub token"
ifneq ($(shell test -f ${IDEAS_GITHUB_TOKEN_FILE} && echo yes),yes)
	$(error The GitHub token file ${IDEAS_GITHUB_TOKEN_FILE} does not exist)
endif

test-docker: verify-github-token
	@echo "Testing function caller in a docker container..."
	@-rm -rf ../ideas-toolbox-my-toolbox
	@-rm -rf ./ideas-toolbox-my-toolbox
	@cookiecutter . --no-input
	@mkdir ../ideas-toolbox-my-toolbox
	@mv ./ideas-toolbox-my-toolbox/* ../ideas-toolbox-my-toolbox/
	@-rm -rf ./ideas-toolbox-my-toolbox
	@cp .ideas-github-token ../ideas-toolbox-my-toolbox/
	@cp tests/inputs/example_tool__test_func_1.sh ../ideas-toolbox-my-toolbox/inputs/
	@cp tests/toolbox_info.json ../ideas-toolbox-my-toolbox/info/toolbox_info.json
	@cp tests/commands/example_tool__test_func_1.sh ../ideas-toolbox-my-toolbox/commands/
	@chmod a+x ../ideas-toolbox-my-toolbox/commands/example_tool__test_func_1.sh 
	@echo "Going to toolbox folder and running command..."
	cd ../ideas-toolbox-my-toolbox/; git init; git add -A .; git commit -m "initial commit"; make run TOOL="example_tool__test_func_1"
	