FROM python:3.9.7-buster
ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=1.1.13
RUN pip install --upgrade pip && pip install "poetry==$POETRY_VERSION"
WORKDIR /app
COPY poetry.lock pyproject.toml ./
RUN poetry add flask_restful
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi
COPY app.py ./
CMD ["poetry", "run", "python", "app.py"]

