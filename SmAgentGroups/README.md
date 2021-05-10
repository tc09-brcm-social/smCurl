* addagent.sh AgentGroupName AgentName -- add an agent to an agent group
* addAgent2Group.sh AgentGroupName AgentName -- add an agent to an agent group
	* This is the same as addagent.sh
* addgroup.sh AgentGroupName GroupName -- add an agent group to an agent group
* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an Agent Group using a JSON file
* delete.sh AgntGroupName -- delete the Agent Group
* exist.sh AgentGroupName -- check if the Agent Group exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh AgentGroupNameSpec -- list the existing Agent Groups in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingAGName -- make a template script from an existing Agent Group
** only Agent Group name is parameterized
* read.sh AgentGroupSpec  -- GET the Agent Group
* update.sh AgentGroupName JSONFileName -- update the Agent Group using a JSON file
** this retains all existing relatioships
