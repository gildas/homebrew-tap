#!/usr/bin/env bash

if ! command -v gh &>/dev/null; then
  echo "The GitHub CLI (gh) is required, see https://cli.github.com" >&2
  exit 1
fi

for formula in Formula/*.rb; do
  echo ">>>>>> Processing formula $formula"
  homepage=$(cat $formula | sed -Ene 's/^\s*homepage\s+"(.*)"/\1/p')
  version=$(cat $formula | sed -Ene 's/^\s*version\s+"(.*)"/\1/p')
  url=$(cat $formula | sed -Ene 's/^\s*url\s+"(.*)"/\1/p')
  checksum=$(cat $formula | sed -Ene 's/^\s*sha256\s+"(.*)"/\1/p')
  repo=$(sed -Ene 's/^https:\/\/github\.com\/([^/]+\/[^/]+)\/?$/\1/p' <<<"$homepage")
  echo "  Current Version: $version, URL: $url"
  if [[ -n $repo ]]; then
    echo "  Repository: $repo"
    # Only consider release tags (like v1.2.3), not pre-releases (like v1.2.3-rc1)
    new_tag=$(gh api --paginate "repos/$repo/tags" --jq '.[].name' | grep -E '^v?[0-9]+(\.[0-9]+)*$' | sort --version-sort | tail -1)
    if [[ -z $new_tag ]]; then
      echo "  Failed to get the tags of $repo, skipping"
      continue
    fi
    new_version=${new_tag#v}
    if [[ $new_version != $version ]]; then
      echo "  There is a new version: $new_version"
      sed -Ei "/^\s*version/s/\".*\"/\"$new_version\"/" $formula
      version=$new_version
    fi
    new_url="https://github.com/${repo}/archive/refs/tags/${new_tag}.zip"
    if [[ $new_url != $url ]]; then
      echo "  URL has changed: $new_url"
      sed -Ei "/^\s*url/s/\".*\"/\"${new_url//\//\\/}\"/" $formula
      url=$new_url
    fi
  else
    echo "  $homepage is not a GitHub repository, only checking the checksum"
  fi
  new_checksum=$(http --quiet --download GET $url | sha256sum | awk '{print $1}')
  if [[ $new_checksum != $checksum ]]; then
    echo "Checksum does not match, updating"
    sed -Ei "/^\s*sha256/s/\".*\"/\"$new_checksum\"/" $formula
  fi
  echo "  Checksum: $new_checksum"
done
