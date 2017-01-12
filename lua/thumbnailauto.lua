local preName = ngx.var.a
local suffix = ngx.var.e
local command = "gm convert "
local cpcommand="cp " .. ngx.var.image_dir .. preName .. "." ..  suffix .. " " .. ngx.var.image_dir .. preName .. "." ..  suffix .. ".bak"
	os.execute(cpcommand)
	if(string.lower(suffix)=="jpg" or string.lower(suffix)=="jpeg") then
		command = command .. " -quality 30 " .. ngx.var.image_dir .. preName .. "." ..  suffix .. " " .. ngx.var.image_dir .. preName .. "." ..  suffix
		else if(string.lower(suffix)=="png") then
			command = command .. ngx.var.image_dir .. preName .. "." ..  suffix .. " -resize '80%' PNG8:" .. ngx.var.image_dir .. preName .. "." ..  suffix
			else if(string.lower(suffix)=="gif") then
				command = "convert "
				command = command .. ngx.var.image_dir .. preName .. "." ..  suffix .. " -fuzz 8% -layers optimize " .. ngx.var.image_dir .. preName .. "." ..  suffix	
			end
		end
	end
os.execute(command)
os.execute("echo command=" .. command .. " > /usr/local/nginx/lua/luaLog.txt")
ngx.redirect(ngx.var.uri)