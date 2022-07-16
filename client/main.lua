local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()

   QBCore.Functions.LoadModel(Config.ped.model)
   local ped = CreatePed(0, Config.ped.model, Config.ped.coords.x, Config.ped.coords.y, Config.ped.coords.z, Config.ped.coords.w, false, false)
   FreezeEntityPosition(ped, true)
   SetEntityInvincible(ped, true)
   SetBlockingOfNonTemporaryEvents(ped, true)
   TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', true)

   Wait(500)

   exports['qb-target']:AddBoxZone("policegarage", vector3(Config.ped.coords.x, Config.ped.coords.y, Config.ped.coords.z), Config.ped.length, Config.ped.width, {
    name = "policegarage",
    heading = Config.ped.heading,
    debugPoly = Config.ped.debugPoly,
    minZ = Config.ped.minZ,
    maxZ = Config.ped.maxZ,
    }, {
    options = {
    {
        num = 1,
        type = "client",
        event = "qb-policegarage:client:OpenMenu",
        icon = 'fas fa-warehouse',
        label = 'Police Garage',
        job = 'police',
    }
    },
    distance = 1.5,
})
end)

RegisterNetEvent('qb-policegarage:client:OpenMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "Police Garage 🚓",
            isMenuHeader = true
        },
        {
            header = "<center><p><img src=https://i.imgur.com/blMuA9a.png width=200px></img></p>",
            txt = "ford victoria (All Grades)",
            params = {
                event = "qb-policegarage:client:spawnvehicle",
                args = {
                    vehicle = 'npolvic',
                    CopGrade = {0, 1, 2, 3, 4}
                }
            }
        },
        {
            header = "<center><p><img src=https://i.imgur.com/uxTKcRM.png width=200px></img></p>",
            txt = "Ford Explorer (Grades 1 2 3 4)",
            params = {
                event = "qb-policegarage:client:spawnvehicle",
                args = {
                    vehicle = 'npolexp',
                    CopGrade = {1, 2, 3, 4}
                }
            }
        },
        {
            header = "<center><p><img src=https://i.imgur.com/jKMVgCP.png width=190px></img></p>",
            txt = "Police Bike (Grades 1 2 3 4)",
            params = {
                event = "qb-policegarage:client:spawnvehicle",
                args = {
                    vehicle = 'npolmm',
                    CopGrade = {1, 2, 3, 4}
                }
            }
        },
        {
            header = "<center><p><img src=https://i.imgur.com/dTXbrhf.png width=200px></img></p>",
            txt = "c7 (Grades 3 4)",
            params = {
                event = "qb-policegarage:client:spawnvehicle",
                args = {
                    vehicle = 'npolvette',
                    CopGrade = {3, 4}
                }
            }
        },
        {
            header = "<center><p><img src=https://i.imgur.com/4fEcbEw.png width=200px></img></p>",
            txt = "Ford Mustng (Grades 3 4)",
            params = {
                event = "qb-policegarage:client:spawnvehicle",
                args = {
                    vehicle = 'npolstang',
                    CopGrade = {3, 4}
                }
            }
        },
        {
            header = "<center><p><img src=https://i.imgur.com/gDQUHBa.png width=190px></img></p>",
            txt = "Dodge Challenger (Grades 3 4)",
            params = {
                event = "qb-policegarage:client:spawnvehicle",
                args = {
                    vehicle = 'npolchal',
                    CopGrade = {3, 4}
                }
            }
        },
        {
            header = "<center><p><img src=https://i.imgur.com/lbke6OL.png width=190px></img></p>",
            txt = "Dodge Charger (Grade 4)",
            params = {
                event = "qb-policegarage:client:spawnvehicle",
                args = {
                    vehicle = 'npolchar',
                    CopGrade = {4}
                }
            }
        },
    })
end)

RegisterNetEvent('qb-policegarage:client:spawnvehicle', function(dacca)
    local isused = QBCore.Functions.SpawnClear(Config.vehicle.coords, Config.vehicle.Coordsradius)
    local vehicle = dacca.vehicle
    local Grades = QBCore.Functions.GetPlayerData().job.grade.level
    local CopGrade = dacca.CopGrade

    if isused == true then
    for k, v in pairs(CopGrade) do
        print(v)
    if Grades == v then
        QBCore.Functions.SpawnVehicle(vehicle, function(veh)
            local plate = QBCore.Functions.GetPlate(veh)

            SetEntityHeading(veh, Config.vehicle.heading)
            SetVehicleModKit(veh, 0)
            TriggerEvent("vehiclekeys:client:SetOwner", plate)
            TriggerServerEvent('qb-policegarage:server:SaveVehicle', plate, vehicle)
        end, Config.vehicle.coords, true)
    end
    end
    else
        QBCore.Functions.Notify('There Is Vehicle In The Way', 'error', 5000)
    end
end)