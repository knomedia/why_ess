# why_ess

get Yelp business listings via local cache (with expiry) or via API


### Getting Started

Standard local docker setup for a rails app. See `docker-compose.yml`. Create an override to any any local secrets. From within the container (`docker-compose run --rm web sh`):

```sh
bundle install
bin/rake db:create
bin/rake db:migrate
```

### Running specs

```sh
bin/launch_env test
bin/rspec spec/
```

### API

Only a single endpoint `/api/v1/businesses/:uuid`. Pass it a unique identifier (either `id`, or `alias` from Yelp), get back either a cached business listing, or a refreshed listing if cache has expired.

API requires an `Account` record. Accounts automatically get a `token` populated. Pass the token in on each API call using a standard `Authorization` header:

```sh
Authorization: Bearer <your-token>
```
