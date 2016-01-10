#!/usr/bin/bash
ip a | grep -E 'wifi|wlan' | grep state | awk '{print $2 $9}'
