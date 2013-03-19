
NAME="$0:t"

die ()
{
	echo "$NAME: $@"
	return 1
}



fetch_curl () {

		[[ "$#" != "1" ]]	&& die "$NAME: takes one argument, an URL."

			# put the argument into a variable we can use and refer to later
		URL="$@"

			# Since we are reading web pages, we can 'safely' read the contents of the web page into
			# a variable instead of using a temp file. That's my preference, when possible.
 			#
			# note that the `curl` command will include the HEADER information from the server. This
			# is so we can check the HTTP status which was returned as well. `--dump-header -` will
			# include that in STDOUT
 			#
			# Also note that the `tr -d` line will get rid of the ^M control characters which will
			# screw things up if you aren't careful. Other than that, I prefer not to change the
			# HTML that we receive at this point. We can do that easily enough later.
			#
			# send `curl` through `cat -v` to see the ^Ms
			#
		CURL=$(curl --silent --location --dump-header - "${URL}" 2>/dev/null | tr -d '\r')

			# Now you can check the HTTP headers to make sure that you received a valid response. I
			# prefer to check for as specific of a match as possible. For most servers, that will
			# mean checking for "HTTP/1.1 200 OK". But since we are using --location we might get a
			# few HTTP responses. So we can't just check the first line of $CURL.
			#
			# At this point someone could rightly point out that it would be better to
			# `--dump-header` to a separate file and test that file instead of `$CURL`. That's true,
			# but for my purposes this is sufficient.
			#
			#	note that `egrep` is checking only for lines which match exactly. It has to start
			#	with HTTP and end with OK (here's one place where those ^M characters would screw
			#	you up. If there was one after 'OK' then this `egrep` would fail.)
		STATUS=$(echo $CURL| egrep '^HTTP/1.1 200 OK$')

		if [ "$STATUS" != "HTTP/1.1 200 OK" ]
		then
				die "Did not receive status 200 on URL: $URL"
		fi

}


#
#EOF

