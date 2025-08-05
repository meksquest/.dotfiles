#!/bin/bash

case "$1" in
    download|d)
        exercism download --track=gleam --exercise="$2"
        cd "$HOME/Exercism/gleam/$2" 2>/dev/null || echo "Could not cd to exercise directory"
        ;;
    submit|s)
        src_file=$(find src -name "*.gleam" -not -name "*_test.gleam" | head -1)
        if [ -n "$src_file" ]; then
            echo "Submitting: $src_file"
            exercism submit "$src_file"
        else
            echo "No source file found"
        fi
        ;;
esac
