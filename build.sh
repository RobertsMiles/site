#!/bin/bash

mkdir -p site
for file in src/*.md; do
  base=$(basename "$file" .md)
  pandoc -f markdown "$file" -o "site/${base}.html"
done
