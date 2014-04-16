#!/bin/sh
set -e

brew update
brew install xctool
gem install cocoapods --no-rdoc --no-ri --no-document --quiet
cd Example && pod install && cd $TRAVIS_BUILD_DIR
