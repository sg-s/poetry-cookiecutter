


.PHONY: test coverage-report jupyter

jupyter:
	@echo "Installing kernel <{{ cookiecutter.package_name}}> in jupyter"
	-yes | jupyter kernelspec uninstall {{ cookiecutter.package_name}}
	poetry run python -m ipykernel install --user --name {{ cookiecutter.package_name}}




test:
	poetry run coverage run -m pytest -sx --failed-first
	-rm coverage.svg
	poetry run coverage-badge -o coverage.svg

coverage-report: .coverage
	poetry run coverage html --omit="*/test*"
	open htmlcov/index.html

