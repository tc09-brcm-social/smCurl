* cleanse.sh - clean up a JSON object for create.sh to use
* create.sh UserDirectoryName JSONFileName -- create a user directory attribute mapping using a JSON file
* delete.sh UserDirectoryName AttrMappingName -- delete a user directory attribute mapping
* exist.sh UserDirectoryNameSpec AttrMappingSpec -- check if the user directory attribute mapping exists
** using read.sh, emit same output, and exist 1 if responseType is error
* list.sh UserDirectoryNameSpec AttrMappingNameSpec -- list the existing attribute mappings in JSON array
** prints out empty array if exist.sh fails
* maketemp.sh UserDirectoryName AttrMappingName -- make a template script from an existing user directory attribute mapping
** only policy name is parameterized
* read.sh UserDirectorySpec AttrMappingSpec -- GET the user directory attribute mapping
