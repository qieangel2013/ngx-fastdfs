local preName = ngx.var.a
local whParam = ngx.var.b
local qParams = ngx.var.c
local qParam = string.sub(qParams,2)
local suffix = ngx.var.d

local command = "gm convert " .. ngx.var.image_dir .. preName .. "." ..  suffix

if (whParam=="")
    then
    else
        command = command .. " -thumbnail " .. whParam
end

if (qParams=="")
    then
    else
        command = command .. " -quality " .. qParam
end

command = command .. " " .. ngx.var.file

os.execute("echo preName=" .. preName .. " > /usr/local/nginx/lua/luaLog.txt")
os.execute("echo whParam=" .. whParam .. " > /usr/local/nginx/lua/luaLog.txt")
os.execute("echo qParams=" .. qParams .. " > /usr/local/nginx/lua/luaLog.txt")
os.execute("echo qParam=" .. qParam .. " > /usr/local/nginx/lua/luaLog.txt")
os.execute("echo suffix=" .. suffix .. " > /usr/local/nginx/lua/luaLog.txt")
os.execute("echo command=" .. command .. " > /usr/local/nginx/lua/luaLog.txt")

os.execute(command)
ngx.redirect(ngx.var.uri)
