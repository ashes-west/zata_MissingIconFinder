local MySQL = exports.oxmysql

Config = {}
Config.InventoryResource = "vorp_inventory"

local VORP
TriggerEvent("getCore", function(core)
    VORP = core
end)

local function fileExists(item)
    if not item then return false end
    local path = "html/img/items/" .. item .. ".png"
    local handle = LoadResourceFile(Config.InventoryResource, path)
    return handle ~= nil
end

local function CheckImageDirectory()
    local anyFound = false
    local testItems = {"water", "meat"}  -- vorp includes those

    for _, item in ipairs(testItems) do
        if fileExists(item) then
            anyFound = true
            break
        end
    end

    if not anyFound then
        local err = "[MissingIcons] Keine bekannten .png-Icons im Verzeichnis gefunden."
        print(err)
        error(err)
    end
end

local function CheckMissingIcons(callback)
    MySQL:query("SELECT item FROM items", {}, function(rows)
        CheckImageDirectory()

        local missing = {}
        for _, row in ipairs(rows) do
            if not fileExists(row.item) then
                table.insert(missing, row.item)
            end
        end

        -- Call callback if given, else print to server console
        if callback then
            callback(missing)
        else
            local total = #missing
            local showLimit = 5

            print("[MissingIcons] Missing icons for items:")

            for i = 1, math.min(showLimit, total) do
                print(" - " .. missing[i])
            end

            if total > showLimit then
                print(" ... and " .. (total - showLimit) .. " more.")
            end

            print("[MissingIcons] Total of " .. total .. " missing icons.")
        end
    end)
end

AddEventHandler("onResourceStart", function(resName)
    if resName == GetCurrentResourceName() then
        print("[MissingIcons] Starting icon check...")
        CheckMissingIcons()
    end
end)

RegisterCommand("copymissingicons", function(source)
    if source == 0 then
        print("Only callable from ingame client. Returning.")
        return
    end

    local user = VORP.getUser(source)
    if not user or user.getGroup ~= "admin" then
        TriggerClientEvent("vorp:TipBottom", source, "Command only available to vorp admin users.", 4000)
        return
    end

    CheckMissingIcons(function(missing)
        TriggerClientEvent("missingicons:copyToClipboard", source, table.concat(missing, "\n"))
        print("[MissingIcons] Sent list to player " .. source .. ".")
    end)
end)
