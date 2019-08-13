* cleanse.sh -- clean up a JSON object for create.sh to use
* copy.sh ToUDName FromUDName -- copy the definition from FromUDName to ToUDName
* create.sh JSONFileName -- create a User Directory  using a JSON file
* delete.sh DirectoryName -- delete a User Directory
* exist.sh DirectoryName -- check if the User Directory exists
** using read.sh, emit same output, and exist 1 if responseType is error
* id2path.sh -- uses ../objects/tid2path.sh convert an ID to a path
* list.sh DirectoryNameSpec -- list the existing User Directories in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh ExistingUDName -- make a template script from an existing User Directory
** only user directory name is parameterized
* read.sh UDSpec  -- GET the User Directory
* rename.sh UDName NewUDName -- change the User Directory from UDName to NewUDName
** this retains all existing relatioships
* save.sh DirectoryName -- clone existing User Directory  using name.time as the new name
* update.sh DireectoryName JSONFileName -- update the User Directory using a JSON file
** this retains all existing relatioships
*SUPPORT: User Directory: Attribute Mapping List setting is not supported
