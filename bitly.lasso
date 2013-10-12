define bitly => type {
	/* ================================================
		
		Wrapper for the bit.ly URL shortener API.
		Initially based on Lasso 8.x type by Jason Huck
		Updated and extended for V3 API
		
		- Note: this version uses the deprecated API Key.
		- New version shoudl support oAuth!

	================================================ */
	data
		public login::string 		= '',
		public apiKey::string 		= '',
		public version::string 		= 'v3',
		public format::string		= 'json',
		public history::integer 	= 1,
		
		private formatOptions		= array('json','xml','text'),
		public response::map,
		
		public status_code,
		public status_txt,
		public global_hash,
		public hash,
		public long_url,
		public short_url,
		public new_hash,
		public user_hash,
		public url,
		public created_at,
		public created_by,
		public title

	public oncreate(-login::string,-apikey::string) => {
		.login 		= #login
		.apiKey 	= #apiKey
	}
	public send(-method::string,-params::array=array) => {
		return .send(#method,#params)	
	}
	
	public send(method::string,params::array=array) => {
		#params->insert('login' 	= .login)
		#params->insert('apiKey' 	= .apiKey)
		#params->insert('version' 	= .version)
		#params->insert('format' 	= .format)
		#params->insert('history' 	= .history)
		 
		local(response = string)
		 
		protect => {
			handle_error => {
				return(map('errorCode' = error_code, 'errorMessage' = error_msg))
			}
			#response = include_url(
				'http://api.bitly.com/'+ .version + '/' + #method,
				-getparams = #params
			)
		}
		
		.response = json_deserialize(#response)
		.processResponse
		return
	}
	private processResponse() => {
		protect => { .status_code = integer(.response->find('status_code')) }
		protect => { .status_txt = integer(.response->find('status_txt')) }
		if(.response->keys >> 'data') => {
			if(.response->find('data')->keys >> 'expand') => {
				local(use = .response->find('data')->find('expand')->asCopy)
			else(.response->find('data')->keys >> 'info')
				local(use = .response->find('data')->find('info')->asCopy)
			else
				local(use = .response->find('data')->asCopy)
			}
			
		
			protect => { .global_hash = #use->find('global_hash')->asString }
			protect => { .hash = #use->find('hash')->asString }
			protect => { .long_url = #use->find('long_url')->asString }
			protect => { .short_url = #use->find('short_url')->asString }
			protect => { .new_hash = integer(#use->find('new_hash')) }
			protect => { .user_hash = integer(#use->find('user_hash')) }
			protect => { .url = #use->find('url')->asString }
			protect => { .created_at = #use->find('created_at')->asString }
			protect => { .created_by = #use->find('created_by')->asString }
			protect => { .title = #use->find('title')->asString }
		}				
	}
	
	
	public _unknowntag(...) => {
		local(params = array)
		#rest->isA(::void) ? return
		with i in #rest do => {
			match(#i->type) => {
				case(::pair,::keyword)
					#params->insert(#i->name=#i->value)
				case(::array)
					#params->insertfrom(#i)
				case(::map)
					with key in #i->keys do => {
						#params->insert(
							#key = #i->find(#key)
						)
					}
       			}
			
		}
		return .send(method_name->asString, #params)
	}
}