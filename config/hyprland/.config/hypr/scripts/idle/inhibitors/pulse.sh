#!/bin/bash

pactl list | grep RUNNING &> /dev/null && exit 1 || exit 0
