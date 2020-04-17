# examples/wa
* env.shlib
	* WAHCO: Web Agent HCO Name
	* WAPSHOST: Policy Server to use if WAHCO does not exist
	* WAAGENT: web agent name to use
	* WAACO: Web Agent ACO Name
	* WAACODEF: an existing ACO example used to create the ACO
	* WAACOTEMP: full path template if WAACODEF is not usable
		* WAACOTEMP ACOName WebAgentName
* make.sh -- create an HCO, a Web Agent, and a ACO that are needed before
	* before running the Web Agent Config Wizard
* unmake.sh -- remove the three objects make.sh create.
