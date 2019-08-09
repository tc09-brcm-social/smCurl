* cleanse.sh -- clean up a JSON object for create.sh to use
* copy.sh ToAgentName FromAgentName -- copy the definition from FromAgentName to ToAgentName
** this retains all existing relatioships
* create.sh JSONFileName -- create an agent  using a JSON file
* delete.sh AgentName -- delete an agent
* exist.sh Agent -- check if the agent exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh AgentNameSpec -- list the existing agents in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingAgentName -- make a template script from an existing agent
** only agent name is parameterized
* read.sh AgentSpec  -- GET the agent
* rename.sh AgentName NewAgentName -- change the agent from AgentName to NewAgentName
** this retains all existing relatioships
* save.sh AgentName -- clone existing agent using name.time as the new name
* update.sh AgentName JSONFileName -- update the agent using a JSON file
