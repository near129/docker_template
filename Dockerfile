FROM python:3.9
# FROM ubuntu
# FROM rust

USER root
ENV DEBIAN_FRONTEND=noninteractive \
    # PATH="/root/.local/bin:/root/.poetry/bin:$PATH" \
    PYTHONUNBUFFERED=1

RUN apt-get update -y --fix-missing && \
    apt-get -y install \
    curl git

ENV PATH $PATH:/root/.poetry/bin
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3

# RUN mkdir -p /workspace
WORKDIR /workspace
COPY poetry.lock /workspace
COPY pyproject.toml /workspace
RUN poetry install --no-dev

COPY . /workspace

CMD ["poetry", "run", "/bin/bash"]
