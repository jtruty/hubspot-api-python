VENV_NAME?=venv

venv: $(VENV_NAME)/bin/activate

$(VENV_NAME)/bin/activate: setup.py
	pip install --upgrade pip virtualenv
	@test -d $(VENV_NAME) || python -m virtualenv --clear $(VENV_NAME)
	${VENV_NAME}/bin/python -m pip install -e .[dev]
	@touch $(VENV_NAME)/bin/activate

test: venv
	@${VENV_NAME}/bin/python -m pytest

fmt: venv
	@${VENV_NAME}/bin/python -m black ./

clean:
	@rm -rf $(VENV_NAME) build/ dist/

.PHONY: venv test clean
