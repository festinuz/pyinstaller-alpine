# Official Python base image is needed or some applications will segfault.
ARG PYTHON_VERSION
ARG ALPINE_VERSION

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

# PyInstaller needs zlib-dev, gcc, libc-dev, and musl-dev

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && apk --update --no-cache add \
        bash \
        build-base \
        curl \
        freetype-dev \
        fribidi-dev \
        g++ \
        git \
        harfbuzz-dev \
        jpeg-dev \
        lcms2-dev \
        libc-dev \
        libxml2-dev \
        libxslt-dev \
        libzmq \
        linux-headers \
        musl-dev \
        openjpeg-dev \
        openssl \
        pkgconfig \
        postgresql-dev \
        pwgen \
        py2-pip \
        python-dev \
        sudo \
        tcl-dev \
        tiff-dev \
        tk-dev \
        upx \
        zeromq-dev \
        zlib-dev \
    && pip install --upgrade pip

RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python && \
    source $HOME/.poetry/env && \
    poetry config settings.virtualenvs.create false

VOLUME /src
WORKDIR /src

ADD ./bin /pyinstaller
RUN chmod a+x /pyinstaller/*

# Install requirements
ONBUILD COPY pyproject.* poetry.* requirements.* ./
ONBUILD RUN /pyinstaller/install_requirements.sh

# Install pyinstaller & pycrypto
ONBUILD RUN pip install --no-cache-dir --disable-pip-version-check pyinstaller pycrypto


ENTRYPOINT ["/pyinstaller/pyinstaller.sh"]
