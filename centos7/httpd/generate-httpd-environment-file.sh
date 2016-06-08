#!/bin/bash

cd /etc/profile.d/
rm "./environment"

while IFS='' read -r line || [[ -n "$line" ]]; do
  echo $(echo "${line}" | sed 's/^export //') >> "./environment"
done; < "./environment.sh"