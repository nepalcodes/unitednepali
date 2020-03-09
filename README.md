# United Nepali
![End-to-end tests](https://github.com/nepalcodes/unitednepali/workflows/End-to-end%20tests/badge.svg?branch=master)

:wave: Welcome to United Nepali!

This project is about building a platform to make it easier for Nepali organizations and individuals to collaborate with each other!

If you would like to join us please reach out on [SLACK](https://join.slack.com/t/nepalcodes/shared_invite/enQtNjYzMjE5MjY3MDI4LWI5NWEyNDljZDgzNzExOWQ0NjRhNDU4NDdmZGYzNmE1MDM4NDA3NjRmMWNkZDljMWU1NDhlMjk0NGZmMTU4MjQ) or send us an email at: team@nepalcodes.com!

# Getting started

After a clone, in the root level of this repo run: 

```bash
# Install all the dependencies
npm install

# Call bootstrap scirpt to bootstrap the monorepo
npm run bootstrap

# Starting the application
npm run start
```

UI runs on http://localhost:8080 and server runs on http://localhost:3000

## Running e2e tests

Project uses cypress for end-to-end testing, to run the tests:

```bash
# to run and open cypress
npm run test

# To just run the e2e tests
npm run test-run
```