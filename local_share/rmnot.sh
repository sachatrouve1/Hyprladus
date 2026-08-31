#!/usr/bin/env bash

find . -type f -not -name "$1" -print0 | xargs -0 rm --
