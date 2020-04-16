# utils/metadata
* metadata.shlib -- shell utilities library used by importmetadata.sh
	* in additional to some internal procedures:
	* toJson: convert XML file to JSON
	* doNameIDFormats: NameIDFormats processing
	* doCerts: Certficiates processing
	* doRemoteServices: RemoteServices (Endpoints) processing
	* doAttributes: IdP Attributes processing
* rmns.awk -- AWK script to remove XML namespace from tags
* xml2json.sh -- a sample script that uses metadata.shlib to conver xml to json
