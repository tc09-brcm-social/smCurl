* attrhv.temp HeaderName UserAttributeName -- template for user atribute as Header Variable
* exprhv.temp HeaderName Expression -- template for expression as Header Variable
* OnAccessReject.temp AUTHHOST -- redirect to https://$AUTHHOST/public/error/azreject/
* regjwtresponse.temp ResponseName -- template for registered JWT claims as Header Variables
** use the waresponse.temp, jaddattr.sh, and svhv.temp to create this response
* saml2response.temp ResponseName -- template for SAML2 SP related Header Variables
** Persist Authentication Session Variables
* svhv.temp HeaderName SessionVariableName -- template for session variable as Header Variable
* waresponse.temp ResponseName -- template for an empty Web Agent Response
** use the jaddattr.sh and the other templates to add individual responses
