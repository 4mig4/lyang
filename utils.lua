-- Miscellaneous utils
local utils = {
    not_yet_matched = '__lyang_NYM'
}

function utils.trim(s) -- trim5 of lua-users
    return s:match'^%s*(.*%S)' or ''
end

function utils.getwords(s)
    local words = {}
    for w in s:gmatch('%S+') do
        table.insert(words, w)
    end
    return words
end

function utils.strip_quote(s)
    if not s then return end
    local a = s:gsub('"','')
    a = a:gsub("'", '')
    return a
end

function utils.jcat(acc, s) -- concat Java like string (with + operators)
    -- Lets sanitize str before use, not here
    return acc..s
end

function string:split(sep)
    local sep, fields = sep or ':', {}
    local pattern = string.format('([^%s]+)', sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

function utils.basename(p)
    local t = p:split('/')
    if not utils.basedir then -- FIXME hack (use -P path)
        local dir = ''
        for i=1,(#t-1) do dir = dir..t[i] end
        utils.basedir = dir
    end
    return t[#t]
end

function utils.dirname(p)
    local t   = p:split('/')
    local dir = ''
    for i=1,(#t-1) do dir = dir..t[i] end
    if p:match('^/') then dir = '/' .. dir end
    return ( dir == '' and '.' or dir )
end

function utils.find_file(mod)
    return utils.basedir .. '/' .. mod .. '.yang' --FIXME  hack use path
end

return utils
