#!/usr/bin/env bash

mkdir -p site
for file in src/*.md; do
  base=$(basename "$file" .md)
  pandoc -f markdown "src/template/header.md" "$file" "src/template/footer.md" -o "site/${base}.html"
done
