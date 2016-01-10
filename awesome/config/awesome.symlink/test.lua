-- {{{ Functions
function os.system(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

function get_active_wifi()
    retval = os.system('bash ~/.config/awesome/wifi_cards.sh')
    interfaces = {}
    for i in string.gmatch(retval, '%S+') do
        table.insert(interfaces, i)
    end
    for idx, i in pairs(interfaces) do
        interface = {}
        for j in string.gmatch(i, '(%w+)') do
            print(j)
            table.insert(interface, j)
        end
        if interface[2] == 'UP' then
            return interface[1]
        end
    end
end

-- retval = os.system('bash ~/.config/awesome/wifi_cards.sh')
retval = get_active_wifi()
print(retval)
