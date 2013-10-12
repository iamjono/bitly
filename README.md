bitly
=====

A simple Lasso 9 wrapper for the bit.ly URL shortener

Bit.ly offers tracking and stats on shortened URLs. Requires a bit.ly account and API key. 

Use the method name as a member tag and the method's arguments as keywords to the tag. 
Be sure to match the case shown in the documentation as the API is case-sensitive. 

Links
------------

API Docs: http://dev.bitly.com/links.html

Lasso 9 Download: http://www.lassosoft.com/Lasso-9-Server-Download

Data Members
------------
These data members will be populated after common link calls:

`status_code`: HTTP Response Status Code

`status_txt`: describes the nature of any error encountered

`global_hash`: the bitly aggregate identifier

`hash`: a bitly identifier for long_url which is unique to the given account.

`long_url`: the longUrl parameter. This may not always be equal to the URL requested, as some URL normalization may occur (e.g., due to encoding differences, or case differences in the domain). This long_url will always be functionally identical the the request parameter. 

`short_url`: refers to bitly link

`new_hash`: designates if this is the first time this long_url was shortened by this user. The return value will equal 1 the first time a long_url is shortened. It will also then be added to the user history.

`user_hash`: bitly user identifier

`url`: the actual link that should be used, and is a unique value for the given bitly account.

`created_at`: the epoch timestamp when this bitly link was created.

`created_by`: the bitly username that originally shortened this link, if the link is public. Otherwise, null.

`title`: the HTML page title for the destination page (when available)

***		
NOTE:

See http://dev.bitly.com/formats.html for detailed descriptions of Error Codes

See http://dev.bitly.com/links.html for detailed descriptions of Link API responses

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

