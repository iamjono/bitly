define bitly => type {
	/* ================================================
		Wrapper for the bit.ly URL shortener API.
		Based on Lasso 8.x type by Jason Huck
	
		format options: json, xml, text

	================================================ */
	data
		public login::string 		= '',
		public apiKey::string 		= '',
		public version::string 		= '2.0.1',
		public format::string		= 'json',
		public history::integer 	= 1,
		private formatOptions		= array('json','xml','text')

	public oncreate() => {}
	public oncreate(-login::string='',-apikey::string='',-format::string='json',-history::integer=1) => {
        .login 		= #login
        .apiKey 	= #apiKey
        .formatOptions >> #format ? .format = #format
		.history = #history
	}
	public send(-method::string,-params::array=array) => {
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
                'http://api.bit.ly/' + #method,
                -getparams=#params,
                -connecttimeout=15,
                -timeout=15
            )
             
        }
         
		.format == 'json' ? 
			#response = json_deserialize(#response) | 
			#response = xml_tree(#response)
        return #response
	}
}