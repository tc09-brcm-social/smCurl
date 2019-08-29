#!/bin/bash
echo "$1" |tr ' ' '+' | sed 's/#/%23/'
