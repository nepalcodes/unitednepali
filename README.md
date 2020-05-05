# United Nepali
[![Netlify Status](https://api.netlify.com/api/v1/badges/77944c6d-f2ee-4f3e-8666-d3814761330b/deploy-status)](https://app.netlify.com/sites/unitednepali/deploys)
![End-to-end tests](https://github.com/nepalcodes/unitednepali/workflows/End-to-end%20tests/badge.svg?branch=master)

:wave: Welcome to United Nepali!

This project is about building a platform to make it easier for Nepali organizations and individuals to collaborate with each other!

If you would like to join us please reach out on [SLACK](https://join.slack.com/t/nepalcodes/shared_invite/enQtNjYzMjE5MjY3MDI4LWI5NWEyNDljZDgzNzExOWQ0NjRhNDU4NDdmZGYzNmE1MDM4NDA3NjRmMWNkZDljMWU1NDhlMjk0NGZmMTU4MjQ) or send us an email at: team@nepalcodes.com!

# Getting started

After a clone, in the root level of this repo run: 

```bash
# Install all the dependencies
npm install

# Call bootstrap script to bootstrap the monorepo
npm run bootstrap

# Starting the application
npm run start
```

UI runs on http://localhost:8080 and server runs on http://localhost:3000

# Docker Workflow

The project is also configured for a containerized workflow, currently there are 4 services:

* `unitednepali-server` (express server): this is the backend service for the web application
* `unitednepali-client` (react frontend): this is the react frontend
* `unitednepali-db` (postgres db): postgres database 
* `unitednepali-nginx` (nginx): nginx webserver, which can also be used as a reverse proxy

Each service is built and deployed through Docker, see corresponding service's `Dockerfile` for details.
We use `docker-compose` to orchestrate all the services together. See Docker [site](https://docs.docker.com/compose/install/) for OS specific installation instructions.

## Building and running locally
Supplied is a `docker-compose.yml` file, this defines the orchestration of all the containers.

```bash
# build, (re)creates, start and attaches to containers
docker-compose up --build

# teardown all containers
docker-compose down
```

Once containers are built and running, you can check if the app is running on your browser at http://localhost,
unitednepali api is correspondingly running on http://localhost/api/.

See docker [documentation](https://docs.docker.com/compose/reference/) for full usage of `docker-compose` commands.

## Running e2e tests

Project uses cypress for end-to-end testing, to run the tests:

```bash
# to run and open cypress
npm run test

# To just run the e2e tests
npm run test-run
```

# FAQ

**I'm getting an error when I try to run an npm command**
Make sure you've run `npm install` and `npm run bootstrap`

**How to add a new npm package to the client or server package**
We use lerna to maintain the npm packages:
```bash
# we current manage 2 packages with lerna united-nepali-client and united-nepali-server
lern add [npm-package-name] --scope united-nepali-client
```

**Running eslint to analyze the javascript source code**
```bash
# to just run eslint on .js and .jsx files
npm run lint

# to run lint and fix the flagged violations
npm run lint-fix

# to run eslint and see a html report, output will be in .test/eslint-report.html
npm run lint-report
```