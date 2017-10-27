local preName = ngx.var.a
local whParam = ngx.var.b
local qParams = ngx.var.c
local qParam = string.sub(qParams,2)
local suffix = ngx.var.d

local command = "gm convert " .. ngx.var.image_dir .. preName .. "." ..  suffix

if (whParam=="")
    then
    else 
        if(whParam=='water')
            then
            command = "identify -format '%[EXIF:*]' " .. ngx.var.image_dir .. preName .. "." ..  suffix .. "|(grep Orientation || echo 1)|awk -F \"\" '{for(i=1;i<=NF;i++){if ($i ~ /[[:digit:]]/){str=$i;str1=(str1 str)}}print str1}'|awk '{if($NF==6) cmd= \"cp " .. ngx.var.image_dir .. preName .. "." ..  suffix .. " " .. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. ";mogrify -strip -rotate 90  " .. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. ";convert  " .. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. " /usr/local/nginx/lua/water.png -gravity southeast -geometry +5+10 -composite " .. ngx.var.file .. "\";else if($NF==8)cmd= \"cp ".. ngx.var.image_dir .. preName .. "." ..  suffix  .. " " .. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. ";mogrify -strip  -rotate 270  ".. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. ";convert ".. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. " /usr/local/nginx/lua/water.png -gravity southeast -geometry +5+10 -composite " .. ngx.var.file .. "\";else if($NF==3)cmd=\"cp ".. ngx.var.image_dir .. preName .. "." ..  suffix .. " " .. ngx.var.image_dir .. preName .. "_bak." ..  suffix ..";mogrify -strip  -rotate 180  " .. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. ";convert ".. ngx.var.image_dir .. preName .. "_bak." ..  suffix .. " /usr/local/nginx/lua/water.png -gravity southeast -geometry +5+10 -composite " .. ngx.var.file .. "\";else cmd=\"convert ".. ngx.var.image_dir .. preName .. "." ..  suffix .. " /usr/local/nginx/lua/water.png -gravity southeast -geometry +5+10 -composite " .. ngx.var.file .. "\";system(cmd);}' "
        else
            command = command .. " -thumbnail " .. whParam
        end
end

if (qParams=="")
    then
    else 
        if(whParam =='water')
            then
        else
            command = command .. " -quality " .. qParam
        end
end

if(whParam=='water')
    then
else
command = command .. " " .. ngx.var.file
end
-- os.execute(whParam .. "echo command=" .. command .. whParam" > /usr/local/nginx/lua/luaLog.txt")

if (whParam=="")
    then
    else
    -- os.execute("echo preName=" .. preName .. " > /usr/local/nginx/lua/luaLog.txt")
    -- os.execute("echo whParam=" .. whParam .. " > /usr/local/nginx/lua/luaLog.txt")
    -- os.execute("echo qParams=" .. qParams .. " > /usr/local/nginx/lua/luaLog.txt")
    -- os.execute("echo qParam=" .. qParam .. " > /usr/local/nginx/lua/luaLog.txt")
    -- os.execute("echo suffix=" .. suffix .. " > /usr/local/nginx/lua/luaLog.txt")
    os.execute("echo command=" .. command .. " > /usr/local/nginx/lua/luaLog.txt")

    os.execute(command)
    ngx.redirect(ngx.var.uri)
   end
