location ~ \.(js|css)$
		{
	       root   html/h5;
            if ($request_uri !~ "^(.*)/(.*)\.(js|css)\?ran=") {
            content_by_lua '
            local randomnum =ngx.now();
            local uri=ngx.var.uri;
             ngx.redirect(uri.."?ran=" .. randomnum);
            ';
        }
        
		}
