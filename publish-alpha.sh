#!/bin/bash

circleci config pack src > orb.yml
circleci orb publish orb.yml "$1@dev:alpha"
rm -rf orb.yml
