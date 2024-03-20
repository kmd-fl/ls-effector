#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# set current working directory to script directory to run script from everywhere
cd "$(dirname "$0")"

# This script builds all subprojects and puts all created Wasm modules in one dir
fluence module build ./effector --no-input

mkdir -p cid/artifacts
ipfs add --offline -Q --only-hash --cid-version 1 --hash sha2-256 --chunker=size-262144 target/wasm32-wasi/release/ls_effector.wasm > cid/artifacts/cidv1

cargo build --release
