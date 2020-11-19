#!/bin/bash

# Check if this is the first time running the container
apk info -vv | grep 'python3'
if [[ $? -eq 1 ]]; then # It is running for the first time! Let's install things..
  # Update repo's!
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" > /etc/apk/repositories
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories

  # Update APK
  apk update

  # Install git
  apk add git

  # Install Chromium + Webdriver
  apk add chromium
  apk add chromium-chromedriver

  # Install Python and selenium
  apk add python3
  apk add py3-pip

  # Download MarktplaatsScraper and install requirements
  git clone https://github.com/jaspercardol/MarktplaatsScraper.git
  cp -u -R MarktplaatsScraper/* /config
  rm -rf MarktplaatsScraper
  cd /config
  pip3 install -r requirements.txt
fi


# Execute it.
exec /init