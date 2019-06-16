FROM python:3.7.3-alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache --update \
    build-base \
    gcc \
    curl \
    netcat-openbsd \
    postgresql-dev \
    libffi-dev \
    && rm -rf /var/cache/apk/*

RUN addgroup -S user && adduser -S user -G user

RUN mkdir -p /opt/app
RUN chown -R user:user /opt/app

USER user

# install poetry
RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python

# add executables to path
ENV PATH "/home/user/.poetry/bin:${PATH}"
ENV PATH "/home/user/.local/bin:${PATH}"

WORKDIR /opt/app

# add and install python requirements
COPY pyproject.toml .
COPY poetry.lock .
RUN poetry install

# bake code in
COPY --chown=user:user . /opt/app

ENTRYPOINT ["poetry", "run"]

CMD ["python", "app.py"]
