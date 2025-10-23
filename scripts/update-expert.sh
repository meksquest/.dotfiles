#!/bin/sh

path="$HOME/.local/bin/expert"

rm "$path"

gh release download nightly --pattern 'expert_darwin_arm64' --repo elixir-lang/expert -O "$path"

chmod +x "$path"

# command to verify that the version was updated
# ls -l (which expert)
