* acoSPS1.temp -- aco template for SPS in case Default does not exist
* env.shlib -- set environment variables for SMLDAPHOST, SMLDAPPORT, SMLDAPPWD, b4config.sh
* b4config.sh -- create objects required before the first run of Access Gateway
	* configuration wizard
	* It uses the examples/wa to create the base objects and then
	* modify the ACO with further customization
* make.sh -- example script that enables privileged user to access SPS UI
* unmake.sh -- example script that removes the policy configuration from SPS Policy Domain
