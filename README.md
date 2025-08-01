> [!CAUTION]
> **THIS REPO IS ARCHIVED**
> This Project is not being actively developed anymore.
> No bugs will be fixed from our site, should you resolve a bug, pls open a PR, we will review it and deploy it.
> A replacement for the backend of this software is planned.
---

# README

[![Build image and deploy to registry](https://github.com/FachschaftMathPhysInfo/partyverwaltung/actions/workflows/build_and_deploy.yml/badge.svg?branch=master)](https://github.com/FachschaftMathPhysInfo/partyverwaltung/actions/workflows/build_and_deploy.yml)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

STARTUP RUN  bundle exec rails runner "eval(File.read 'startup.rb')" from root dir
and ignore error...thats from the redirect
