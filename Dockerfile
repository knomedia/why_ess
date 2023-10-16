FROM ruby:3.1-alpine3.15
LABEL maintainer="knomedia@gmail.com"

ENV PATH /root/.yarn/bin:$PATH

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                npm \
                                tzdata \
                                gcompat \
                                curl

RUN curl -o- -L https://yarnpkg.com/install.sh | sh

ENV APP_PATH /usr/src/why_ess

# Different layer for gems installation
WORKDIR $APP_PATH

COPY ["Gemfile", "Gemfile.lock", "/usr/src/why_ess/"]

# Fix these paths for various libs that require it
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    CA_FILE=/etc/ssl/certs/ca-certificates.crt \
    CA_PATH=/etc/ssl/certs

RUN gem install bundler \
    && bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3



# Copy the application into the container
COPY . $APP_PATH

EXPOSE 3000
CMD ["bin/start.sh"]
