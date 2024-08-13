local cudituglameslek = 1
Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local player = PlayerPedId()
        local playercoords = GetEntityCoords(player)
        local dst2 = GetDistanceBetweenCoords(playercoords, Config.CudiTuglaToplama[cudituglameslek].x, Config.CudiTuglaToplama[cudituglameslek].y, Config.CudiTuglaToplama[cudituglameslek].z, true)
        if dst2 < 4 then
            sleep = 2
            DrawText3Ds(Config.CudiTuglaToplama[cudituglameslek].x, Config.CudiTuglaToplama[cudituglameslek].y, Config.CudiTuglaToplama[cudituglameslek].z + 0.3, '[E] Tuğla Topla')
            if dst2 < 1 then
                if IsControlJustReleased(0, 38) then
                    cudituglameslek = math.random(1, #Config.CudiTuglaToplama)
                    cuditopla()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function cuditopla()
    if not cudituglatopladimi then
        cudituglatopladimi = true
        exports['progressbar']:Progress({
            name = "cudituglatopla",
            duration = 1000,
            label = 'TOPLUYORSUN',
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "pickup_object",
                anim = "pickup_low",
                flags = 49,
            },
        }, function(cancelled)
            if not cancelled then
                TriggerServerEvent('cuditugla')
                cudituglatopladimi = false
            else
            end
        end)
    end
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 75)
end