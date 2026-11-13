#!/usr/bin/env bash

sudo perf record -a \
        -e amdgpu_dm:amdgpu_dm_ism_commit \
        -e amdgpu_dm:amdgpu_dm_ism_event \
        -o "$XDG_RUNTIME_DIR/psr-idle.data" \
        -- sleep 30
