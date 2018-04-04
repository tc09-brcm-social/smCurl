#!/bin/bash
./jq 'del(.AuthSchemeLink.id, .AuthSchemeLink.href, .AuthSchemeLink.desc)'
