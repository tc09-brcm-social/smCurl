#!/bin/bash
echo "$1" |tr ' ' '+' | sed 's/#/%23/g' | sed 's#/#%2F#g'
