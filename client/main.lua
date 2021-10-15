ESX = nil
local metalDetector = 0xFDBADCED
local isMetalDetectorActive = false

local sounds = {
    good = {
        name = "Hack_Success",
        dictionary = "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"
    },
    bad = {
        name = "CHECKPOINT_MISSED",
        dictionary = "HUD_MINI_GAME_SOUNDSET"
    },
    notarget = {
        name = "Pin_Bad",
        dictionary = "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS"
    }
}

local function setupESX()
    while ESX == nil do
	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end

local function notifyClient(msg)
    ESX.ShowNotification(msg)
end

local function isTargetPedValid(ped)
    local plyPed = PlayerPedId()
    
    local plyCoords = GetEntityCoords(plyPed)
    local pedCoords = GetEntityCoords(ped)

    local distance = #(plyCoords - pedCoords)

    return ped and ped > 0  and distance < 5.0
end

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 0, 0)

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, 25, true))
    ButtonMessage(getLocalizedText('select_target'))
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, 24, true))
    ButtonMessage(getLocalizedText('scan'))
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

local function markDetectedPed(targetPed)
    Citizen.CreateThread(function() 
        local DETECTION_TIME = 3000 -- ms

        local isDetectionActive = true

        SetTimeout(DETECTION_TIME, function() 
            isDetectionActive = false
        end)

        while isDetectionActive do
            local targetCoords = GetEntityCoords(targetPed)

            targetCoords = targetCoords + vector3(0.0, 0.0, 1.1)
            
            DrawMarker(0, targetCoords, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(0.3, 0.3, 0.2), 255, 150, 0, 100, false, true, 2, false, nil, nil, false)
            
            Citizen.Wait(0)
        end
    end)
end

local function handleMetalDetectorUse()
    local plyPed = PlayerPedId()
    local ply = PlayerId()

    local buttons = setupScaleform("instructional_buttons")

    local digiWeapon = GetSelectedPedWeapon(plyPed)

    local isUsingMetalDetector = true

    while isUsingMetalDetector do
        Citizen.Wait(0)

        DrawScaleformMovieFullscreen(buttons, 255, 255, 255, 255, 0)

        DisableControlAction(0, 24)
        DisableControlAction(0, 257)

        isUsingMetalDetector = GetSelectedPedWeapon(plyPed) == digiWeapon

        if(IsPlayerFreeAiming(ply)) then    
            DisplaySniperScopeThisFrame()

            if(IsDisabledControlJustReleased(0, 24)) then    
                local plyCoords = GetEntityCoords(plyPed)
    
                local isAimingAnyone, targetPed = GetEntityPlayerIsFreeAimingAt(ply)
                
                if(isAimingAnyone and isTargetPedValid(targetPed)) then
                    local targetPlayer = NetworkGetPlayerIndexFromPed(targetPed)
                    local targetPlayerId = GetPlayerServerId(targetPlayer)
    
                    ESX.TriggerServerCallback('metal_detector:checkIfPlayerGetsDetected', function(isTargetDetected)
                        if(isTargetDetected) then
                            PlaySoundFromCoord(-1, sounds.bad.name, plyCoords, sounds.bad.dictionary, 0, 0, 0)
                            notifyClient(getLocalizedText('something_detected'))

                            markDetectedPed(targetPed)
                        else
                            PlaySoundFromCoord(-1, sounds.good.name, plyCoords, sounds.good.dictionary, 0, 0, 0)
                            notifyClient(getLocalizedText('nothing_detected'))
                        end
                    end, targetPlayerId)

                    Citizen.Wait(1500)
                else
                    PlaySoundFromCoord(-1, sounds.notarget.name, plyCoords, sounds.notarget.dictionary, 0, 0, 0)
                    Citizen.Wait(1000)
                end
            end
        end
    end

    RemoveWeaponFromPed(plyPed, metalDetector)

    isMetalDetectorActive = false
end

local function activateMetalDetector()
    if(isMetalDetectorActive) then return end

    isMetalDetectorActive = true
    
    local plyPed = PlayerPedId()
    local ply = PlayerId()

    GiveWeaponToPed(plyPed, metalDetector, 1, true, true)
    SetCurrentPedWeapon(plyPed, metalDetector, true)

    Citizen.CreateThread(handleMetalDetectorUse)
end

RegisterNetEvent('metal_detector:activateDetector')
AddEventHandler('metal_detector:activateDetector', activateMetalDetector)

Citizen.CreateThread(function()
    setupESX()
end)