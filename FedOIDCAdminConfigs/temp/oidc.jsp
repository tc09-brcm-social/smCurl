<!--
/******************************************************************************
 *
 * Copyright (c) 2012 CA. All rights reserved.
 *
 * This software and all information contained therein is confidential and
 * proprietary and shall not be duplicated, used, disclosed or disseminated in
 * any way except as authorized by the applicable license agreement, without the
 * express written permission of CA. All authorized reproductions must be marked
 * with this language.
 *
 * EXCEPT AS SET FORTH IN THE APPLICABLE LICENSE AGREEMENT, TO THE EXTENT
 * PERMITTED BY APPLICABLE LAW, CA PROVIDES THIS SOFTWARE WITHOUT WARRANTY OF ANY
 * KIND, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTIES OF MERCHANTABILITY
 * OR FITNESS FOR A PARTICULAR PURPOSE.  IN NO EVENT WILL CA BE LIABLE TO THE END
 * USER OR ANY THIRD PARTY FOR ANY LOSS OR DAMAGE, DIRECT OR INDIRECT, FROM THE
 * USE OF THIS SOFTWARE, INCLUDING WITHOUT LIMITATION, LOST PROFITS, BUSINESS
 * INTERRUPTION, GOODWILL, OR LOST DATA, EVEN IF CA IS EXPRESSLY ADVISED OF SUCH
 * LOSS OR DAMAGE.
 *
 *******************************************************************************
 */

///////////////////////////////////////////////////////////////////

This page works as a CGI script to redirect the user back a URL
specified by redirectURL query parameter. This page needs to be secured
by the PS so that the user gets authenticated when he redirected to 
this page by web agent.
-->
<html>
<head>
<script>
function redirectParentWindow(rurl){
if(window.parent != 'undefined')
	window.parent.location.href=rurl;
else 
	location.href=rurl;
}
</script>
</head>
<body>
<%@ page import="java.util.Enumeration" session="false" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="java.net.URLDecoder" %>

<%! 
    private final String SSOURL = "SMPORTALURL";
    private final String PARAMETER_DELIMITER = "&";
    private final String NAME_VALUE_DELIMITER = "=";
%>

<% 
response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.addHeader("Pragma", "no-cache"); // HTTP 1.0
response.addHeader("Expires", "Thu, 01 Jan 1970 00:00:00 GMT");
%>

<%
// If this page was accessed directly, then there is nothing to do.
if((null == request.getQueryString()) || request.getQueryString().trim().length() == 0)
{
	response.sendError(response.SC_BAD_REQUEST, "<H2> Bad Request </H2><BR><BR> "
			+ "This page should not be accessed directly");
}
else
{
	String referer = request.getParameter(SSOURL);
	
	// If referer is found to be null or blank, show a "Bad Request" error to the user
	if(referer == null || referer == "")
	{
		response.sendError(response.SC_BAD_REQUEST, "<H2> Bad Request </H2><BR><BR> " 
			+ "The redirect URL could not be found.");
		return;	
	}

	//Debug info. Writes to the ServletExec log file
	//out.println(request.getQueryString()+"<BR>");	
	StringTokenizer tokenizer = new StringTokenizer(request.getQueryString(), PARAMETER_DELIMITER, false);

	String queryString = "";
	String nameValuePair = "";
	String name = "";

	//Enumeration paramNames = request.getParameterNames();
	while(tokenizer.hasMoreTokens())
	{
		nameValuePair = tokenizer.nextToken();
		name = nameValuePair.substring(0, nameValuePair.indexOf(NAME_VALUE_DELIMITER));
	
		//return back all the params except the SSO URL
		if (!SSOURL.equals(name))
		{
			queryString += "&" + nameValuePair;	
		}
	}

	//Debug info. Writes to the ServletExec log file
	//out.println(referer + "?" + queryString+"<BR>");

	//redirect the user back to SSO URL with all the query params
		if(!referer.contains("?")){
			queryString = "?"+queryString;
		}
	String redirectURL = URLDecoder.decode(referer, "UTF-8") + queryString;
	String isIFrame = request.getParameter("iframe");
	if(isIFrame != null) {
%>
	<B>Please wait... redirection is in progress </B>
	<script>
	redirectParentWindow('<%=redirectURL%>');
	</script>
<%
	} else {
		response.sendRedirect(URLDecoder.decode(referer, "UTF-8") + queryString);
	}
}
%>
</body>
</html>
