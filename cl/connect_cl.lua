
local ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	connexionanim()
end)

function yodaconnexionmenu()
    local yleplussage_connect = RageUI.CreateMenu(
    Config.ServerName,
    "Connecté en tant que : ( ~y~" .. GetPlayerName(PlayerId()) .. "~s~ )"
    )

    yleplussage_connect:SetRectangleBanner(
    255, 
    255,
    255, 
    70
    )

    yleplussage_connect.Closable = false

    local isjoining = false
    local loading = 0.0
    RageUI.Visible(yleplussage_connect, not RageUI.Visible(yleplussage_connect))

    while yleplussage_connect do

    Citizen.Wait(0)

        RageUI.IsVisible(
            yleplussage_connect,
            true,
            true,
            true,
            function()
                RageUI.Separator("Id : [~b~" .. GetPlayerServerId(PlayerId()).. "~s~]" ) 
                RageUI.Separator("Nombre de Citoyens en Ville : ~b~" .. #GetActivePlayers() .."~s~/".. Config.Slots )
                RageUI.ButtonWithStyle("Rejoindre ~b~" .. Config.ServerName .. "~s~", nil, {RightLabel = ">>"}, not isjoining, function(Hovered, Active, Selected)
                    if Selected then
                        isjoining = true
                    end
                end)
                if isjoining then
                    RageUI.PercentagePanel(loading, "Connection en Cours..  "..math.floor(loading*100).."%", "", "", function(Hovered, Active, Percent)        
                        if loading < 1.0 then
                            loading = loading + 0.004
                        else
                            DoScreenFadeOut(1500)
                            Wait(2000)
                            RenderScriptCams(false, false, 0, true, true)
                            Wait(1000)
                            FreezeEntityPosition(PlayerPedId(), false)
                            SetEntityVisible(PlayerPedId(), true, 0)
                            RageUI.CloseAll()
                            isMenuOpen = false
                            DoScreenFadeIn(2000)
                            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, 0)
                            Wait(4000)
                            ClearPedTasks(PlayerPedId())
                            ESX.ShowAdvancedNotification(Config.ServerName, "~g~Information :", "Bienvenue en Ville", 'CHAR_MP_FM_CONTACT', 1)
                            DisplayRadar(true)
                        end
                    end)
                end
            end
         )
         if not RageUI.Visible(yleplussage_connect) then
            yleplussage_connect = RMenu:DeleteType(yleplussage_connect, true) 
        end
    end

end

function connexionanim()
    DoScreenFadeOut(1500)
    Wait(1500)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityVisible(PlayerPedId(), false, 0)
    CameraConnect = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
    SetCamCoord(CameraConnect, 606.99, 847.44, 357.91)
    SetCamRot(CameraConnect, 0.0, 0.0, 340.22)
    SetCamFov(CameraConnect, 45.97)
    ShakeCam(CameraConnect, "HAND_SHAKE", 0.2)
    SetCamActive(CameraConnect, true)
    RenderScriptCams(true, false, 2000, true, true)
    DisplayRadar(false)
    yodaconnexionmenu()
end