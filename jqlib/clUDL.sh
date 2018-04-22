#!/bin/bash
./jq 'del(.UserDirectoriesLink[].id, .UserDirectoriesLink[].href, .UserDirectoriesLink[].desc)'
