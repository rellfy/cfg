#!/bin/bash
set -e
fg_green="\033[0;32m";
fg_reset="\033[0m";
current_branch_name=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD);
echo -e "$fg_green$current_branch_name$fg_reset";

