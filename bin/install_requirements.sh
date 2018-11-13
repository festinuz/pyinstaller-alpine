#!/bin/sh

if [ -f requirements.txt ]; then
    pip install --no-cache-dir --disable-pip-version-check -r requirements.txt
elif [ -f setup.py ]; then
    pip install --no-cache-dir --disable-pip-version-check .
elif [ -f pyproject.toml]; then
    poetry install --no-dev --no-interaction
fi
