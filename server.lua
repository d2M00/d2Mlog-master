-- d2Mlog Simple Server Discord Log by d2M#0002

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- FOR PLAYER CONNECT
RegisterNetEvent("esx:d2Mlog")
AddEventHandler("esx:d2Mlog", function()
local xPlayer = ESX.GetPlayerFromId(source)
local name = xPlayer.getName()
local grup = xPlayer.getGroup()
local money = xPlayer.getMoney()
local moneyb = xPlayer.getAccount('bank').money
local ip = GetPlayerEndpoint(source)
local ids = ExtractIdentifiers(source)
if Config.steamID then _steamID ="\n**Steam ID:  ** " ..ids.steam.."" else _steamID = "" end
if Config.discordID then _discordID ="\n**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
if Config.licenseID then _licenseID ="\n**License ID:  ** " ..ids.license.."" else _licenseID = "" end
if Config.steamURL then _steamURL ="\n\n **Steam Url  **https://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
renterdiscord('**Connected to the server:**' ..name.. '\n ' .._steamID.. ' ' .._steamURL.. '\n' .._discordID.. '\n'.._licenseID.. '\n\n**IP:**' ..ip.. '\n\n**Group:**' ..grup..'\n\n**Money: **' ..money..'\n\n**Money Bank: **' ..moneyb..'')
end) 




function renterdiscord(message)
	local content = {
        {
        	["color"] = '3863105',  -- change side color
            ["title"] = "d2M Logs", -- change title
            ["description"] = message,
            ["footer"] = {
                ["text"] = "© d2M - "..os.date("%x %X %p")
            }, 
        }
    }
        
  	PerformHttpRequest( "YOUR URL WEBHOOK" , function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end


-- FOR PLAYER DISCONNECT
AddEventHandler("playerDropped", function()
local xPlayer = ESX.GetPlayerFromId(source)
local name = xPlayer.getName()
local grup = xPlayer.getGroup()
local money = xPlayer.getMoney()
local moneyb = xPlayer.getAccount('bank').money
local ip = GetPlayerEndpoint(source)
local ids = ExtractIdentifiers(source)
if Config.steamID then _steamID ="\n**Steam ID:  ** " ..ids.steam.."" else _steamID = "" end
if Config.discordID then _discordID ="\n**Discord ID:  ** <@" ..ids.discord:gsub("discord:", "")..">" else _discordID = "" end
if Config.licenseID then _licenseID ="\n**License ID:  ** " ..ids.license.."" else _licenseID = "" end
if Config.steamURL then _steamURL ="\n\n **Steam Url  **https://steamcommunity.com/profiles/" ..tonumber(ids.steam:gsub("steam:", ""),16).."" else _steamURL = "" end
rexitdiscord('**It has disconnected from the server:  **' ..name.. '\n ' .._steamID.. ' ' .._steamURL.. '\n' .._discordID.. '\n'.._licenseID.. '\n\n**IP:  **' ..ip.. '\n\n**Group:  **' ..grup..'\n\n**Money:  **' ..money..'\n\n**Money Bank: **' ..moneyb..'')
end) 

function rexitdiscord(message)
	local content = {
        {
        	["color"] = '15874618', -- change side color
            ["title"] = "d2M Logs", -- change title
            ["description"] = message,
            ["footer"] = {
                ["text"] = "© d2M - "..os.date("%x %X %p")
                
            }, 
        }
    }
        
  	PerformHttpRequest( "YOUR URL WEBHOOK" , function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end
RegisterServerEvent('ClientDiscord')
AddEventHandler('ClientDiscord', function(message, color, channel)
   discordLog(message, color,  channel)
end)


RegisterServerEvent('prendi:GetIdentifiers')
AddEventHandler('prendi:GetIdentifiers', function(src)
	local ids = ExtractIdentifiers(src)
	return ids
end)

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        end
    end

    return identifiers
end
