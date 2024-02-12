#!/usr/bin/env bash

for formula in Formula/*.rb; do
  echo ">>>>>> Processing formula $formula"
  homepage=$(cat $formula | sed -Ene 's/^\s*homepage\s+"(.*)"/\1/p')
  version=$(cat $formula | sed -Ene 's/^\s*version\s+"(.*)"/\1/p')
  url=$(cat $formula | sed -Ene 's/^\s*url\s+"(.*)"/\1/p')
  checksum=$(cat $formula | sed -Ene 's/^\s*sha256\s+"(.*)"/\1/p')
  source="$GOPATH/src/$(sed -e 's/https:\/\///' <<<"$homepage")"
  echo "  Current Version: $version, URL: $url"
  if [[ -d $source/.git ]]; then
    new_version=$(git -C $source tag --list | sort --version-sort | tail -1 | sed -e 's/v//')
    if [[ $new_version != $version ]]; then
      echo "  There is a new version: $new_version"
      sed -Ei "/^\s*version/s/\".*\"/\"$new_version\"/" $formula
      version=$new_version
    fi
    new_url="${homepage}/get/$(git -C $source rev-list -n 1 v$new_version).tar.gz"
    if [[ $new_url != $url ]]; then
      echo "  URL has changed: $new_url"
      sed -Ei "/^\s*url/s/\".*\"/\"${new_url//\//\\/}\"/" $formula
      url=$new_url
    fi
  fi
  new_checksum=$(http --quiet --download GET $url | sha256sum | awk '{print $1}')
  if [[ $new_checksum != $checksum ]]; then
    echo "Checksum does not match, updating"
    sed -Ei "/^\s*sha256/s/\".*\"/\"$new_checksum\"/" $formula
  fi
done
