RegisterNetEvent('pnt_cruiseControl:cruiserCar')
AddEventHandler('pnt_cruiseControl:cruiserCar', function(cruiserSpeed)
    local ped = PlayerPedId() -- Ped
    local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
    local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In

    Wait(500)

    if not inVehicle then
        return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_in_vehicle"])
    end

    if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
        return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_driver_seat"])
    end

    SetEntityMaxSpeed(vehicle, cruiserSpeed)
end)

RegisterCommand(Config.OffCruiseCommand, function()
    local ped = PlayerPedId() -- Ped
    local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
    local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
    local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") -- Get max speed to reset

    Wait(500)

    if not inVehicle then
        return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_in_vehicle"])
    end

    if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
        return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_driver_seat"])
    end
    
    SetEntityMaxSpeed(vehicle, maxSpeed)
end)

RegisterNetEvent('pnt_cruiseControl:Notify')
AddEventHandler('pnt_cruiseControl:Notify', function(msg)
    SetTextFont(0)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end)