#!/bin/bash
./jq 'del(.ValidationMappingLink.id, .ValidationMappingLink.href, .ValidationMappingLink.desc)'
