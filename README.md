bitly
=====

A simple Lasso 9 wrapper for the bit.ly URL shortener

Bit.ly offers tracking and stats on shortened URLs. Requires a bit.ly account and API key. 

Use the method name as a member tag and the method's arguments as keywords to the tag. 
Be sure to match the case shown in the documentation as the API is case-sensitive. 

Sample Usage
------------
```lasso
	sys_listTypes !>> 'bitly' ? 
		include('bitly.lasso')
	
	local(bit = bitly)
	#bit->login='XXXX'
	#bit->apiKey='XXXXXXXXXXXX'
	
	/* ===================================================== */
	// shorten a URL
	#bit->shorten(-longUrl='http://www.lassoguide.com/language/types.html?highlight=_unknowntag')

		// return the url
		'Shortening "http://www.lassoguide.com/language/types.html?highlight=_unknowntag" == ' + #bit->url

	/* ===================================================== */
	// expand a short URL, takes either the full URL or just the hash
	#bit->expand( -hash='19GQove')

		// return the expanded url
		'<br>Expanding hash "19GQove" == ' + #bit->long_url

	/* ===================================================== */
	// expand a short URL, takes either the full URL or just the hash
	#bit->expand( -shortUrl='http://bit.ly/19GQove')

		// return the expanded url
		'<br>Expanding shortUrl "http://bit.ly/19GQove" == ' + #bit->long_url

	/* ===================================================== */
	// get info on a short URL
	#bit->info( -hash='19GQove')
		// info on a short URL
		'<br><br>Info: on -hash "19GQove"'
		'<br>Info: created_at == ' + #bit->created_at
		'<br>Info: created_by == ' + #bit->created_by
		'<br>Info: global_hash == ' + #bit->global_hash
		'<br>Info: short_url == ' + #bit->short_url
		'<br>Info: title == ' + #bit->title
		'<br>Info: user_hash == ' + #bit->user_hash

	/* ===================================================== */
	// get info on a short URL
	#bit->info( -shortUrl='http://bit.ly/19GQove')
		// info on a short URL
		'<br><br>Info: on short_url "http://bit.ly/19GQove"'
		'<br>Info: created_at == ' + #bit->created_at
		'<br>Info: created_by == ' + #bit->created_by
		'<br>Info: global_hash == ' + #bit->global_hash
		'<br>Info: short_url == ' + #bit->short_url
		'<br>Info: title == ' + #bit->title
		'<br>Info: user_hash == ' + #bit->user_hash
```

