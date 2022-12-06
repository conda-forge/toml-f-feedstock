#!/usr/bin/env bash

set -ex

meson \
    setup _build \
    ${MESON_ARGS:---prefix=${PREFIX} --libdir=lib} \
    --default-library=shared

meson compile -C _build
meson install -C _build --no-rebuild
