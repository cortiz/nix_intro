.PHONY: all prepare-dev
.SILENT: run
SHELL=/bin/bash

VENV_NAME?=.venv
VENV_BIN=$(shell pwd)/${VENV_NAME}/bin
VENV_ACTIVATE=${VENV_BIN}/activate

PYTHON=${VENV_BIN}/python3

all:
	@echo "make prepare-dev"
	@echo -e "\tCreates and install all development dependencies"
	@echo "make clean"
	@echo -e "\tClean all dependencmaes and virtual enviroment"
	@echo "make viewlog"
	@echo -e "\tDisplays pip install log"
	@echo "make update"
	@echo -e "\tUpdates and installs  new version"
	@echo -e "make deploy"
	@echo -e "\tDeploy current build site to GH-Pages "
	@echo -e "make build"
	@echo -e "\tBuild documentation localy "
	@echo -e "make serve"
	@echo -e "\tRuns documentation in local server (http://localhost:8000/"
prepare-dev: create-venv

man:

create-venv:
	@echo -e "\e[35mChecking If env Exists\e[0m"
	@if [[ ! -d ${VENV_NAME} ]]; then \
		echo -e "\e[34mCreating Virtual enviroment\e[0m"; \
		python3 -m venv ${VENV_NAME}; \
		chmod +x ${VENV_ACTIVATE}; \
		echo -e "\e[34mActivating venv\e[0m"; \
		source ${VENV_ACTIVATE}; \
		echo -e "\e[34mInstalling dependencies (check .pip.log for output)\e[0m"; \
		pip install --upgrade pip setuptools > .pip.log; \
		pip install -r requirements.txt >> .pip.log; \
		echo -e  "\e[32mUse 'source .venv/bin/activate'\e[0m"; \
	fi
clean:
	echo -e "\e[31mCleaning Enviroment\e[0m"
	@find . -name '*.pyc'       -delete
	@find . -name '__pycache__' -delete
	@rm -rf $(VENV_NAME) *.eggs *.egg-info dist build docs/_build .cache site
update:
	git pull origin develop
	make clean 
deploy:
	mkdocs gh-deploy
build:
	mkdocs gh-deploy
serve:
	mkdocs serve
