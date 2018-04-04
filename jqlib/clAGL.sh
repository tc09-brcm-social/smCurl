#!/bin/bash
./jq 'del(.AgentGroupLink.id, .AgentGroupLink.href, .AgentGroupLink.desc)'
