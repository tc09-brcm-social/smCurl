* cleanse.sh -- clean up a JSON object for create.sh to use
* create.sh JSONFileName -- create an admin  using a JSON file
* delete.sh AdminName -- delete an admin
* exist.sh Admin -- check if the admin exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh AdminNameSpec -- list the existing admins in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingAdminName -- make a template script from an existing admin
** only agent name is parameterized
* read.sh Admin  -- GET the admin
* update.sh AdminName JSONFileName -- update the admin using a JSON file
