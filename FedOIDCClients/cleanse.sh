#!/bin/bash
./jq -f jqlib/rmIHD.jq | ./jq 'del(.ClientID, .ClientSecret, .Endpoints)'
