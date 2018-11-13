#!/bin/sh

if [ -f requirements.txt ]; then
    pip install --no-cache-dir --disable-pip-version-check -r requirements.txt
elif [ -f setup.py ]; then
    pip install --no-cache-dir --disable-pip-version-check .
elif [ -f pyproject.toml ]; then
    source $HOME/.poetry/env && poetry install --no-dev --no-interaction
fi
