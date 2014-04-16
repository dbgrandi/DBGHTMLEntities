#!/bin/sh

brew update
brew install xctool
gem install cocoapods --no-rdoc --no-ri --no-document --quiet
cd DBGHTMLEntityExample && pod install && cd $TRAVIS_BUILD_DIR
