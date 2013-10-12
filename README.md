bitly
=====

A simple Lasso 9 wrapper for the bit.ly URL shortener

Bit.ly offers tracking and stats on shortened URLs. Requires a bit.ly account and API key. 

Use the method name as a member tag and the method's arguments as keywords to the tag. 
Be sure to match the case shown in the documentation as the API is case-sensitive. 
Requires [xml_tree] if xml output format specified.

Sample Usage
------------
```lasso
local(bit = bitly(
    -login='xxxxxxx',
    -apiKey='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    )
)
 
// shorten a URL
#bit->shorten( -longUrl='http://code.google.com/p/bitly-api/wiki/ApiDocumentation')
 
// undocumented way to create custom short urls, i.e. this would create http://bit.ly/myshorturl
#bit->shorten( -longUrl='http://code.google.com/p/bitly-api/wiki/ApiDocumentation', -keyword='myshorturl')

// expand a short URL, takes either the full URL or just the hash
#bit->expand( -hash='r3lsS')
#bit->expand( -shortUrl='http://bit.ly/r3lsS')

// get info on a short URL
#bit->info( -hash='r3lsS')

// use a comma separated list of keys to limit the info returned
#bit->info( -shortUrl='http://bit.ly/r3lsS', -keys='thumbnail')

// get stats on a short URL
#bit->stats( -hash='r3lsS')
#bit->stats( -shortUrl='http://bit.ly/r3lsS')

// show a list of error messages and codes
#bit->errors
```

