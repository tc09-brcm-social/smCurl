* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an agent  using a JSON file
* delete.sh AgentName -- delete an agent
* exist.sh Agent -- check if the agent exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh AgentNameSpec -- list the existing agents in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingAgentName -- make a template script from an existing agent
** only agent name is parameterized
* read.sh AgentSpec  -- GET the agent
* update.sh AgentName JSONFileName -- update the agent using a JSON file
