#!/bin/bash

COLCON_WS="../../../.."

colcon build
source "$COLCON_WS/install/setup.bash"
