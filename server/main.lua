local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-policegarage:server:SaveVehicle', function(plate, vehicle)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cid = Player.PlayerData.citizenid
    local vehicle = vehicle
    local plate = plate

    MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.license,
        cid,
        vehicle,
        GetHashKey(vehicle),
        '{}',
        plate,
        0
    })
    TriggerClientEvent('QBCore:Notify', src, 'You Bought ' .. vehicle, 'success')
end)
