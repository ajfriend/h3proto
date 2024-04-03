init: purge
	python -m venv env
	env/bin/pip install --upgrade pip wheel setuptools
	env/bin/pip install -r requirements.txt
	make proto
	make lab
	
lab:
	env/bin/jupyter lab

clear:
	-@rm -rf MANIFEST
	-@rm -rf annotations
	-@rm -rf .pytest_cache _skbuild dist .coverage build
	-@find . -type d -name '__pycache__' | xargs rm -r
	-@find . -type d -name '*.egg-info' | xargs rm -r
	-@find . -type f -name '*.pyc' | xargs rm -r
	-@find . -type f -name '*.so' | xargs rm -r
	-@find . -type d -name '*.ipynb_checkpoints' | xargs rm -r
	-@find ./tests -type f -name '*.c' | xargs rm -r
	-@find . -type f -name '*_pb2.py' | xargs rm -r

purge: clear
	-@rm -rf env

proto:
	protoc --python_out=. h3_test.proto