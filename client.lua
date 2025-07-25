RegisterNetEvent("missingicons:copyToClipboard", function(text)
    print("Copying missing icons to clipboard.")
    SendNUIMessage({
        action = "copy",
        payload = text
    })
end)
