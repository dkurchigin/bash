BEGIN {
	FS="<title>|</title>"
}

/title/ { print $2 }
