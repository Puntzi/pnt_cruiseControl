if Config.Speed == "km" then
    Config.Speed = 3.6
else
    Config.Speed = 2.237
end

if Config.Command then
    RegisterCommand(Config.CruiseCommand, function(source, args)
        if tonumber(args[1]) then
            local cruiser = math.floor((args[1]) / Config.Speed) + 0.5
            TriggerClientEvent('pnt_cruiseControl:cruiserCar', source, cruiser, args[1])
        else
            TriggerClientEvent('pnt_cruiseControl:Notify', source, Strings["args_invalid"])
        end
    end)
end


