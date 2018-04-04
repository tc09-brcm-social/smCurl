#!/bin/bash
./jq 'del(.AgentTypeLink.id, .AgentTypeLink.href, .AgentTypeLink.desc)'
