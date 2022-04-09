local cruiseEnabled = false

if Config.Command then
    RegisterNetEvent('pnt_cruiseControl:cruiserCar')
    AddEventHandler('pnt_cruiseControl:cruiserCar', function(cruiserSpeed, cruiserNotification)
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In

        Wait(250)

        if not inVehicle then
            return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_in_vehicle"])
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_driver_seat"])
        end

        SetEntityMaxSpeed(vehicle, cruiserSpeed)
        cruiseEnabled = true
        TriggerEvent('pnt_cruiseControl:Notify', string.format(Strings["cruiser_set_at"], cruiserNotification, Config.Speed))
    end)

    RegisterCommand(Config.OffCruiseCommand, function()
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") -- Get max speed to reset

        Wait(250)

        if not inVehicle then
            return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_in_vehicle"])
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return TriggerEvent('pnt_cruiseControl:Notify', Strings["not_driver_seat"])
        end
        
        SetEntityMaxSpeed(vehicle, maxSpeed)
        cruiseEnabled = false
        TriggerEvent('pnt_cruiseControl:Notify', Strings["no_cruiser"])
    end)
end


if Config.KeyMap then

    RegisterCommand("+activatecruiser", function()
        local ped = PlayerPedId() -- Ped
        local inVehicle = IsPedSittingInAnyVehicle(ped) -- Get if ped is in any vehicle
        local vehicle = GetVehiclePedIsIn(ped, false) -- Get Vehicle In
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") -- Get max speed to reset
        local cruiserSpeed = GetEntitySpeed(vehicle) -- Get the current speed

        Wait(250)

        if not inVehicle then
            return
        end

        if not (GetPedInVehicleSeat(vehicle, -1) == ped ) then
            return
        end

        if not cruiseEnabled then
            SetEntityMaxSpeed(vehicle, cruiserSpeed)
            cruiserNotification = math.floor(cruiserSpeed * 3.6 + 0.5)
            cruiseEnabled = true
            TriggerEvent('pnt_cruiseControl:Notify', string.format(Strings["cruiser_set_at"], cruiserNotification, Config.Speed))
        else
            SetEntityMaxSpeed(vehicle, maxSpeed)
            cruiseEnabled = false
            TriggerEvent('pnt_cruiseControl:Notify', Strings["no_cruiser"])
        end
    end)

    RegisterKeyMapping('+activatecruiser', 'Activate cruiser', 'keyboard', Config.KeyBind)

end

RegisterNetEvent('pnt_cruiseControl:Notify')
AddEventHandler('pnt_cruiseControl:Notify', function(msg)
    SetTextFont(0)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end)
