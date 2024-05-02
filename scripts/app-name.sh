#!/usr/bin/env bash

readonly packageSwift="${PWD}/Package.swift"
if [[ ! -f "${packageSwift}" || ! -r "${packageSwift}" ]]; then
  echo "Package.swift file not found. Please checkout the project again." > /dev/stderr
  exit 1
fi

readonly appName="$( \
grep -A 10 'products:' < "${packageSwift}" | \
grep -m 1 'name:' | \
cut -d'"' -f2 | \
tr -d '\n'
)"
# "
if [[ -z "${appName}" ]]; then
  echo "app name is not set. Please check a parameter of [Package > products > executable > name] to exist." > /dev/stderr
  exit 2
fi
