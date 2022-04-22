#!/usr/bin/env bash

# Rscript -e "source('./scripts/data_refresh.R')"
Rscript -e "rmarkdown::render_site()"


if [[ "$(git status --porcelain)" != "" ]]; then
    git config --global user.name ''
    git config --global user.email ''
    git add -A
    git commit -m "Auto refresh dashboard on $(date)"
    git push origin
else
    echo "Nothing to commit..."
fi