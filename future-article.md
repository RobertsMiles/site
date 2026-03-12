## Designing a Website, the Easy Way! <br><sup><sup>Posted: 19 September 2025</sup></sup><br><sup><sup>Updated: 19 September 2025</sup></sup>

This quick guide will demonstrate how to write a simple website without ever touching an html file!

<details>

<summary>Read More</summary>

### Intro

A brief disclaimer: I know nothing about web design! This very well may be a horrible way of doing things, but it works for me right now, so I thought I'd share.

Also, I am assuming that you already have a domain pulling html files from somewhere.

## Instructions

I do not like looking at raw HTML! The obvious solution: write everything in markdown! It turns out it is quite trivial to convert markdown files to html. Here I have written a little bash script that converts the markdown files under `src` into html files under `site`. Eventually I will replace this with a makefile.

    #!/bin/bash

    mkdir -p site
    for file in src/*.md; do
        base=$(basename "$file" .md)
        pandoc -f markdown "$file" -o "site/${base}.html"
    done

When markdown doesn't support a feature

</details>

