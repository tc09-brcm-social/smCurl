* These are designed for the Custom JWT Auth Scheme
* headers/ contains sample Web scripts for testing purposes
* we relied on Layer7 Access Gateway to create jwt for the testing
* make.sh is the initial attempt to automate policy creation.
* make2.sh shows how to create sample policies for testing
* .temp are examples of the custom auth schemes used by make2.sh
* forms.txt is a sample form that can be post into the custom JWT Auth Scheme
* protected resources using curl command
curl -v -X POST --header "Host: cassosps.casecurecloud.info" --header "Content-Type: application/x-www-form-urlencoded" -d @form.txt https://cassosps.casecurecloud.info/siteminderagent/forms/jwtlogin.fcc
