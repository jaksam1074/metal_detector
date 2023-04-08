-- If you are using ESX 1.8.5+ leave the script as it is, if lower, uncomment the lines 2, 4-9 and 50
--ESX = nil

--local function setupESX()
--    while ESX == nil do
--	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--        Citizen.Wait(0)
--    end
--end

local function setupESXstuff()
    ESX.RegisterUsableItem(config.metalDetectorItem, function(playerId)
        TriggerClientEvent('metal_detector:activateDetector', playerId)
    end)

    ESX.RegisterServerCallback('metal_detector:checkIfPlayerGetsDetected', function(playerId, cb, targetId)
        local xPlayer = ESX.GetPlayerFromId(playerId)

        local metalDetectorItem = xPlayer.getInventoryItem(config.metalDetectorItem)

        if(metalDetectorItem and metalDetectorItem.count > 0) then
            local xTarget = ESX.GetPlayerFromId(targetId)
            
            if(xTarget) then
                if(config.detectWeapons) then
                    for k, weapon in pairs(xTarget.getLoadout()) do
                        if(config.detectableWeapons[weapon.name]) then
                            cb(true)
                            return
                        end
                    end
                end

                if(config.detectItems) then
                    for k, item in pairs(xTarget.getInventory()) do
                        if(item.count > 0 and config.detectableItemList[item.name]) then
                            cb(true)
                            return
                        end
                    end
                end
            end
        end

        cb(false)
    end)
end

Citizen.CreateThread(function() 
--    setupESX()
    setupESXstuff()
end)