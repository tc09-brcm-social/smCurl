!/"[a-z][a-z0-9]*:.*":/	{ print $0; }
/"[a-z][a-z0-9]*:.*":/	{
			  printf "\"%s %s\n", substr($1,index($1, ":") + 1),
				substr($0, index($0, $1) + length($1));
			}
