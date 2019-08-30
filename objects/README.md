* exist.sh ObjectID -- check if the object exists
** use read.sh, emit same output, and exist 1 if responseType is error
* id2path.sh ID - convert id to path in an array
* nid2path.sh NamingAttrName ID 
** convert id to path in an array using a supplied attribute name
** as a start to support FedCertificates which uses Alias
* read.sh ObjectSpec  -- GET the object
* tid2path.sh TypesName ID 
** convert id to path in an array using a supplied type
** as a start to support SmUserDirectories/id2path.sh
