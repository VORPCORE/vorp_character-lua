-- check translation file to see if your language is available or add it.
Lang = "English"

Config = {}

Config.DevMode = false    -- if true you can restart script without having to restart the server

Config.Align = "top-left" -- menu position

Config.MinAge = 18 -- minimum age required to create a character

--* when player choosing a name  make sure it doesn't contain any of the words in the list below
Config.BannedNames = { "Arthur", "Marshton", "Shit", "Dick" } --* you can add more words

-- allow player to delete character
Config.AllowPlayerDeleteCharacter = true

-- command to reload character
Config.ReloadCharCommand = "rc"

-- Option to enable/disable the initial RDO intro
Config.UseInitialAnimScene = true

-- this will show gold next to money in character selection
Config.ShowGold = false

-- set false to not show character description on selction menu
Config.showchardesc = true


-- after creating character player will spawn here
Config.SpawnCoords = {
    { -- BLW
        position = vector3(-687.3, -1242.249, 43.1),
        heading = 90.58
    },
    { -- RHO
        position = vector3(1227.77, -1304.7, 76.95),
        heading = 140.49
    },
    { -- Emerald
        position = vector3(1526.07, 444.58, 90.73),
        heading = 265.95
    },
    { -- VAL
        position = vector3(-174.3, 621.18, 114.08),
        heading = 240.38
    },
    { -- Flatneck
        position = vector3(-330.5, -350.76, 88.09),
        heading = 20.96
    },
}


-- in here you can add multiple checks from other script to prevent players from using Rc command
Config.CanRunReload = function()
    -- callback ?
    -- statbebag ?
    return true -- dont touch
end

-- * PLAYER SELECTION MENU * --
-- loactions will be random each restart
-- max characters in vorp core will have to match the number of positions in here
Config.SpawnPosition = {
    -- Vanhorn
    {
        options = {
            timecycle = { name = "teaser_trainShot", strength = 1.0 },                                         -- you can find more in RDR3 discoveries github
            music = "REHR_START",                                                                              -- you can find more in RDR3 discoveries github
            weather = { type = "sunny", transition = 10, snow = false },                                       -- weather to choose
            time = { hour = 12, transition = 10 },                                                             -- time to choose
            playerpos = vector3(2967.38, 488.73, 47.21),                                                       -- player spawn for textures to load in
            mainCam = { x = 2967.38, y = 488.73, z = 47.21, rotx = 0.0, roty = 0.0, rotz = 105.0, fov = 60.0 } -- main
        },
        positions = {
            {
                spawn = vector4(2959.76, 483.66, 47.39, 282.33),                                                 --location of ped
                camera = { x = 2963.62, y = 484.0, z = 47.87, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 }, --camera to look at ped
                scenario = {
                    -- animations will be random every time you join will choose one from the list
                    mp_female = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    }
                }
            },
            {
                spawn = vector4(2960.83, 486.49, 46.82, 286.13),
                camera = { x = 2964.67, y = 487.25, z = 46.74, rotx = 0.0, roty = 0.0, rotz = 100.0, fov = 40.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(2958.35, 487.81, 47.35, 283.9),
                camera = { x = 2962.18, y = 488.70, z = 46.90, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                    mp_male = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                }
            },
            {
                spawn = vector4(2960.69, 489.96, 46.59, 275.78),
                camera = { x = 2964.19, y = 490.46, z = 46.20, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                    mp_male = {
                        "WORLD_HUMAN_SIT_GROUND_COFFEE_DRINK",
                        "MP_LOBBY_CROUCHING_B",
                        "WORLD_HUMAN_SIT_DRINK",
                        "WORLD_HUMAN_SIT_GROUND_READ_NEWSPAPER"
                    },
                }
            },
            {
                spawn = vector4(2957.17, 490.24, 47.34, 257.62),                                                  --location of ped
                camera = { x = 2961.37, y = 490.16, z = 47.37, rotx = 0.0, roty = 0.0, rotz = 90.0, fov = 60.0 }, --camera to look at ped
                scenario = {
                    -- animations will be random every time you join will choose one from the list
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "WORLD_HUMAN_SMOKE_CARRYING",
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "WORLD_HUMAN_SMOKE_CARRYING",
                    }
                }
            },
        }
    },
    --Vanhorn 2
    {
        options = {
            timecycle = { name = "Finale1_outrohighhon_bidging2", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(2963.14, 561.10, 44.68),
            mainCam   = { x = 2964.07, y = 558.95, z = 44.42, rotx = 1.76, roty = 0.00, rotz = -169.00, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(2964.51953125, 556.38671875, 44.45668792724609, 0.0),
                camera   = { x = 2963.80, y = 557.96, z = 44.82, rotx = -2.53, roty = 0.00, rotz = -154.64, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(2964.10107421875, 555.77001953125, 44.48249816894531, 45.93),
                camera   = { x = 2962.81, y = 557.48, z = 44.82, rotx = -4.29, roty = 0.00, rotz = -143.99, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(2963.728759765625, 554.9774169921875, 44.50360107421875, 40.43),
                camera   = { x = 2962.59, y = 556.35, z = 44.82, rotx = -2.53, roty = 0.00, rotz = -140.34, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(2965.1533203125, 555.9634399414062, 44.42756271362305, -51.0),
                camera   = { x = 2965.16, y = 557.78, z = 44.82, rotx = -3.09, roty = 0.00, rotz = -179.39, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(2965.91064453125, 555.1605834960938, 44.42335510253906, -56.0),
                camera   = { x = 2966.17, y = 557.13, z = 44.82, rotx = -3.28, roty = 0.00, rotz = 172.17, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Saloon of Armadillo
    {
        options = {
            timecycle = { name = "teaser_trainShot", strength = 1.0 },                                             -- you can find more in RDR3 discoveries github
            music = "REHR_START",                                                                                  -- you can find more in RDR3 discoveries github
            weather = { type = "sunny", transition = 10, snow = false },                                           -- weather to choose
            time = { hour = 12, transition = 10 },                                                                 -- time to choose
            playerpos = vector3(-3703.26, -2602.17, -13.27),                                                       -- where invisible player needs to spawn for textures to load in location
            mainCam = { x = -3707.83, y = -2599.98, z = -12.80, rotx = 5.0, roty = 0.0, rotz = -20.0, fov = 40.0 } -- main camera position
        },
        positions = {
            {
                spawn = vector4(-3706.8, -2589.74, -13.27, 204.89),                                                    --location of ped
                camera = { x = -3706.97, y = -2594.06, z = -12.90, rotx = -5.0, roty = 0.0, rotz = -3.0, fov = 30.0 }, --camera to look at ped
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    }, -- animations still animation ,select ,spawn for females
                    mp_male = {
                        "WORLD_HUMAN_SMOKE_CARRYING",
                        "MP_LOBBY_SCENARIO_08",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3701.46, -2592.47, -13.27, 139.94),
                camera = { x = -3703.89, y = -2596.37, z = -12.60, rotx = -10.0, roty = 0.0, rotz = -30.0, fov = 35.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3702.79, -2587.09, -10.24, 176.87),
                camera = { x = -3702.87, y = -2589.9, z = -9.66, rotx = -15.0, roty = 0.0, rotz = 5.0, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3702.5, -2589.02, -13.32, 160.76),
                camera = { x = -3702.7, y = -2592.5, z = -12.8, rotx = -15.0, roty = 0.0, rotz = 5.0, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
            {
                spawn = vector4(-3698.99, -2589.17, -10.29, 85.26),
                camera = { x = -3700.80, y = -2590.87, z = -9.59, rotx = -15.0, roty = 0.0, rotz = -50.0, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                    mp_male = {
                        "MP_LOBBY_SCENARIO_02",
                        "MP_LOBBY_SCENARIO_04",
                        "MP_LOBBY_SCENARIO_07",
                        "WORLD_HUMAN_SMOKE_CARRYING"
                    },
                }
            },
        }
    },
    -- Cotorra Springs
    {
        options = {
            timecycle = { name = "finale2_campMoonPos", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(240.46421813964844, 1968.3095703125, 206.56849670410156),
            mainCam   = { x = 241.50, y = 1966.36, z = 205.82, rotx = 0.13, roty = 0.00, rotz = 177.52, fov = 55.0 },
        },
        positions = {
            {
                spawn    = vector4(241.28634643554688, 1963.6492919921875, 205.7147674560547, -13.41),
                camera   = { x = 241.03, y = 1965.26, z = 205.98, rotx = 2.47, roty = 0.00, rotz = -170.29, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    }
                }
            },
            {
                spawn    = vector4(240.3826904296875, 1962.885986328125, 205.5716094970703, 0.90),
                camera   = { x = 239.81, y = 1964.61, z = 205.92, rotx = 0.27, roty = 0.00, rotz = -160.84, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                }
            },
            {
                spawn    = vector4(239.3123321533203, 1962.4949951171875, 205.47006225585938, -1.40),
                camera   = { x = 239.01, y = 1964.32, z = 205.58, rotx = 2.46, roty = 0.00, rotz = -168.28, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                }
            },
            {
                spawn    = vector4(242.06687927246094, 1962.82861328125, 205.6053924560547, -47.0),
                camera   = { x = 243.38, y = 1964.55, z = 206.35, rotx = -9.77, roty = 0.00, rotz = 145.23, fov = 60.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                }
            },
            {
                spawn    = vector4(242.54800415039062, 1961.7637939453125, 205.44102478027344, -44.0),
                camera   = { x = 243.38, y = 1963.29, z = 205.83, rotx = -1.75, roty = 0.00, rotz = 152.17, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SMOKE",
                    },
                    mp_male = {
                        "WORLD_HUMAN_SMOKE",
                    }
                }
            },
        }
    },
    -- Donner Falls
    {
        options = {
            timecycle = { name = "trailer2_shot1", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(394.7771301269531, 1672.5684814453125, 127.14893341064453),
            mainCam   = { x = 397.08, y = 1672.30, z = 128.27, rotx = 4.64, roty = 0.00, rotz = -45.14, fov = 55.0 },
        },
        positions = {
            {
                spawn    = vector4(399.0948791503906, 1674.13623046875, 128.34893798828125, 121.97),
                camera   = { x = 397.62, y = 1672.29, z = 129.09, rotx = -12.06, roty = 0.00, rotz = -33.24, fov = 65.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    }
                }
            },
            {
                spawn    = vector4(400.1960144042969, 1674.1185302734375, 128.2821807861328, 165.66),
                camera   = { x = 399.36, y = 1672.33, z = 128.59, rotx = -1.39, roty = 0.00, rotz = -24.70, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D",
                    },
                }
            },
            {
                spawn    = vector4(401.34051513671875, 1674.3046875, 128.2012939453125, -158.24),
                camera   = { x = 402.13, y = 1672.52, z = 128.80, rotx = -5.41, roty = 0.00, rotz = 22.56, fov = 60.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A",
                    },
                }
            },
            {
                spawn    = vector4(399.1690979003906, 1675.1075439453125, 128.34046936035156, 78.19),
                camera   = { x = 397.07, y = 1674.74, z = 129.14, rotx = -16.21, roty = 0.00, rotz = -72.96, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C",
                    },
                }
            },
            {
                spawn    = vector4(399.4101867675781, 1676.465087890625, 128.29788208007812, 97.04),
                camera   = { x = 397.11, y = 1675.48, z = 128.54, rotx = 3.55, roty = 0.00, rotz = -60.97, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "WORLD_HUMAN_SMOKE",
                    },
                    mp_male = {
                        "WORLD_HUMAN_SMOKE",
                    }
                }
            },
        }
    },
    -- The HeartLands 1
    {
        options = {
            timecycle = { name = "martson1_intromod2", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(178.41, 121.52, 105.28),
            mainCam   = { x = 180.76, y = 125.44, z = 104.26, rotx = 4.06, roty = 0.00, rotz = -61.33, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(182.7963409423828, 126.51189422607422, 104.46258544921875, 122.99),
                camera   = { x = 181.80, y = 125.43, z = 104.80, rotx = -5.57, roty = 0.00, rotz = -38.77, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(183.80235290527344, 126.40680694580078, 104.3888931274414, 170.61),
                camera   = { x = 182.81, y = 125.27, z = 104.80, rotx = -8.41, roty = 0.00, rotz = -41.17, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                }
            },
            {
                spawn    = vector4(184.9395294189453, 126.3748779296875, 104.34683990478516, 178.99),
                camera   = { x = 183.94, y = 125.05, z = 104.80, rotx = -6.33, roty = 0.00, rotz = -37.45, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(182.57081604003906, 127.40278625488281, 104.57352447509766, 103.93),
                camera   = { x = 180.71, y = 127.62, z = 105.43, rotx = -11.55, roty = 0.00, rotz = -95.67, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(183.69700622558594, 128.34262084960938, 104.5129165649414, 85.22),
                camera   = { x = 182.57, y = 129.46, z = 104.80, rotx = -1.98, roty = 0.00, rotz = -134.39, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- The HeartLands 2
    {
        options = {
            timecycle = { name = "FINALE2_campMoonPos", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(484.17, -288.31, 144.68),
            mainCam   = { x = 486.16, y = -289.88, z = 144.19, rotx = 1.67, roty = 0.00, rotz = -145.28, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(487.70672607421875, -292.080322265625, 144.1527862548828, 22.96),
                camera   = { x = 486.31, y = -291.28, z = 144.68, rotx = -8.15, roty = 0.00, rotz = -119.39, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(487.6447448730469, -293.106689453125, 144.15354919433594, 65.84),
                camera   = { x = 486.35, y = -292.62, z = 144.68, rotx = -8.22, roty = 0.00, rotz = -110.88, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(487.7176208496094, -294.1673278808594, 144.1559295654297, 61.68),
                camera   = { x = 486.46, y = -293.72, z = 144.68, rotx = -9.48, roty = 0.00, rotz = -110.00, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(488.6108093261719, -292.263916015625, 144.1641082763672, -12.58),
                camera   = { x = 488.30, y = -290.89, z = 144.68, rotx = -11.11, roty = 0.00, rotz = -168.96, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(489.6289367675781, -292.4676208496094, 144.17864990234375, -17.24),
                camera   = { x = 489.19, y = -290.84, z = 144.68, rotx = -8.53, roty = 0.00, rotz = -165.81, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Swamps 1
    {
        options = {
            timecycle = { name = "Finale1_outrohighhon_bidging2", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(2152.28, -609.59, 41.96),
            mainCam   = { x = 2153.71, y = -611.14, z = 41.40, rotx = 5.92, roty = 0.00, rotz = -135.36, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(2155.578125, -613.0398559570312, 41.54308700561523, 25.46),
                camera   = { x = 2154.30, y = -612.19, z = 41.86, rotx = -1.01, roty = 0.00, rotz = -123.52, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(2155.3779296875, -613.9125366210938, 41.54896926879883, 80.25),
                camera   = { x = 2153.90, y = -613.56, z = 41.86, rotx = -0.63, roty = 0.00, rotz = -103.11, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(2155.763427734375, -615.0479125976562, 41.55394744873047, 70.41),
                camera   = { x = 2154.14, y = -614.62, z = 41.86, rotx = 1.32, roty = 0.00, rotz = -104.81, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(2156.56884765625, -612.965576171875, 41.54000473022461, -9.0),
                camera   = { x = 2156.57, y = -611.24, z = 41.95, rotx = -4.41, roty = 0.00, rotz = -178.63, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(2157.820068359375, -613.3458862304688, 41.55184936523437, 5.29),
                camera   = { x = 2157.74, y = -611.58, z = 41.95, rotx = -3.15, roty = 0.00, rotz = -177.56, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Colter
    {
        options = {
            timecycle = { name = "mod5_int_lessfog", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(-1325.81, 2474.81, 309.75),
            mainCam   = { x = -1326.78, y = 2472.99, z = 309.75, rotx = 2.17, roty = 0.00, rotz = -165.38, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(-1326.1461181640625, 2470.50244140625, 309.5157165527344, 3.5),
                camera   = { x = -1327.04, y = 2472.75, z = 309.78, rotx = 2.67, roty = 0.00, rotz = -151.38, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(-1326.5155029296875, 2469.6474609375, 309.48480224609375, 27.79),
                camera   = { x = -1327.49, y = 2471.00, z = 309.93, rotx = -9.42, roty = 0.00, rotz = -143.21, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"

                    },
                }
            },
            {
                spawn    = vector4(-1326.728759765625, 2468.68310546875, 309.46185302734375, 46.91),
                camera   = { x = -1327.83, y = 2469.80, z = 309.93, rotx = -4.94, roty = 0.00, rotz = -136.53, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(-1325.2999267578125, 2469.999755859375, 309.5245361328125, -17.53),
                camera   = { x = -1324.98, y = 2471.68, z = 309.93, rotx = -8.09, roty = 0.00, rotz = 168.98, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(-1324.438232421875, 2469.408447265625, 309.5310974121094, -30.19),
                camera   = { x = -1323.99, y = 2470.97, z = 309.93, rotx = -4.63, roty = 0.00, rotz = 164.38, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Manzanita Post
    {
        options = {
            timecycle = { name = "winter4_ride_sunstrength2", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(-1957.59, -1612.63, 115.69),
            mainCam   = { x = -1959.05, y = -1613.00, z = 115.69, rotx = 10.32, roty = 0.00, rotz = 103.69, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(-1961.74462890625, -1613.662353515625, 115.97038269042969, -91.2),
                camera   = { x = -1960.22, y = -1612.66, z = 116.28, rotx = 0.87, roty = 0.00, rotz = 124.16, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(-1962.37548828125, -1613.1929931640625, 116.01429748535156, -37.79),
                camera   = { x = -1961.40, y = -1611.68, z = 116.28, rotx = -1.33, roty = 0.00, rotz = 148.73, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                }
            },
            {
                spawn    = vector4(-1963.42822265625, -1612.8199462890625, 116.08049011230469, -34.0),
                camera   = { x = -1962.37, y = -1611.23, z = 116.28, rotx = 1.31, roty = 0.00, rotz = 146.08, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },

            {
                spawn    = vector4(-1962.11572265625, -1614.4964599609375, 116.00640869140625, -133.0),
                camera   = { x = -1960.49, y = -1614.82, z = 116.28, rotx = -1.33, roty = 0.00, rotz = 77.92, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(-1962.7508544921875, -1615.2008056640625, 116.0385513305664, -148.0),
                camera   = { x = -1961.18, y = -1615.87, z = 116.28, rotx = 1.12, roty = 0.00, rotz = 68.41, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
    -- Armadillo Cemetery
    {
        options = {
            timecycle = { name = "finale2_campmoonpos", strength = 1.0 },
            music     = "",
            weather   = { type = "sunny", transition = 10, snow = false },
            time      = { hour = 10, transition = 10 },
            playerpos = vector3(-3317.17, -2824.74, -6.07),
            mainCam   = { x = -3320.76, y = -2823.50, z = -6.07, rotx = 3.21, roty = 0.00, rotz = -175.24, fov = 50.0 },
        },
        positions = {
            {
                spawn    = vector4(-3320.525634765625, -2826.189697265625, -6.14256906509399, -12.0),
                camera   = { x = -3320.64, y = -2824.37, z = -5.77, rotx = -8.66, roty = 0.00, rotz = -170.33, fov = 60.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    }
                }
            },
            {
                spawn    = vector4(-3320.9775390625, -2826.91162109375, -6.20029354095459, 38.11),
                camera   = { x = -3321.85, y = -2825.28, z = -5.77, rotx = -3.72, roty = 0.00, rotz = -152.49, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                }
            },
            {
                spawn    = vector4(-3321.275146484375, -2827.922607421875, -6.22911691665649, 39.59),
                camera   = { x = -3322.58, y = -2826.46, z = -5.77, rotx = -6.05, roty = 0.00, rotz = -139.45, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_A"
                    },
                }
            },
            {
                spawn    = vector4(-3319.898681640625, -2826.728271484375, -6.10577821731567, -50.86),
                camera   = { x = -3319.01, y = -2825.16, z = -5.77, rotx = -4.29, roty = 0.00, rotz = 151.13, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_C"
                    },
                }
            },
            {
                spawn    = vector4(-3319.260498046875, -2827.394775390625, -6.08130264282226, -66.57),
                camera   = { x = -3317.02, y = -2826.74, z = -5.11, rotx = -17.32, roty = 0.00, rotz = 105.93, fov = 50.0 },
                scenario = {
                    mp_female = {
                        "MP_COOP_LOBBY_STANDING_D"
                    },
                    mp_male = {
                        "MP_COOP_LOBBY_STANDING_D"
                    }
                }
            },
        }
    },
}

-- Keyboards
Config.keys = {
    prompt_create = { key = 0x9959A6F0 },                           -- [ C ]
    prompt_delete = { key = 0x3F4DC0EF },                           -- [ DELETE ]
    prompt_swap = { key = 0xA65EBAB4 },                             -- [ LEFT ARROW ]
    prompt_select = { key = 0xCEFD9220 },                           -- [ NUM ENTER ]
    prompt_choose_gender_M = { key = 0xA65EBAB4 },                  -- [ LEFT ARROW  ]
    prompt_choose_gender_F = { key = 0xDEB34313 },                  -- [ RIGHT ARROW ]
    prompt_select_gender = { key = 0xD9D0E1C0 },                    -- [ SPACE ]
    prompt_camera_ws = { key = 0x8FD015D8, key2 = 0xD27782E3 },     -- [ W ] and [ S ]
    prompt_camera_rotate = { key = 0x7065027D, key2 = 0xB4E465B4 }, -- [ A ] and [ D ]
    prompt_zoom = { key = 0x8BDE7443, key2 = 0x62800C92 },          -- [ MOUSE SCROLL DOWN ] and [ MOUSE SCROLL UP ]
    prompt_Back = { key = 0x156F7119 }                              -- [ BACKSPACE ]
}

Config.commands = {
    CoatClosed = { command = "ccoat" },
    Hat = { command = "hat" },
    EyeWear = { command = "eyewear" },
    Mask = { command = "mask" },
    NeckWear = { command = "neckwear" },
    NeckTies = { command = "tie" },
    Shirt = { command = "shirt" },
    Vest = { command = "vest" },
    Coat = { command = "coat" },
    Poncho = { command = "poncho" },
    Cloak = { command = "cloak" },
    Glove = { command = "glove" },
    Bracelet = { command = "bracelet" },
    Buckle = { command = "buckle" },
    Pant = { command = "pant" },
    Skirt = { command = "skirt" },
    Chap = { command = "chap" },
    Boots = { command = "boots" },
    Spurs = { command = "spurs" },
    Spats = { command = "spats" },
    GunbeltAccs = { command = "gunbeltaccs" },
    Gauntlets = { command = "gauntlets" },
    Loadouts = { command = "loadouts" },
    Accessories = { command = "accessories" },
    Satchels = { command = "satchels" },
    Dress = { command = "dresses" },
    Belt = { command = "belt" },
    Holster = { command = "holster" },
    Suspender = { command = "suspender" },
    Armor = { command = "armor" },
    Gunbelt = { command = "gunbelt" },
}


Config.DefaultChar = {
    {
        label = "White",    -- change label only
        imgColor = "skin1", -- change img only
        Heads = {
            "CLOTHING_ITEM_%s_HEAD_001_V_001",
            "CLOTHING_ITEM_%s_HEAD_002_V_001",
            "CLOTHING_ITEM_%s_HEAD_003_V_001",
            "CLOTHING_ITEM_%s_HEAD_004_V_001",
            "CLOTHING_ITEM_%s_HEAD_005_V_001",
            "CLOTHING_ITEM_%s_HEAD_006_V_001",
            "CLOTHING_ITEM_%s_HEAD_007_V_001",
            "CLOTHING_ITEM_%s_HEAD_008_V_001",
            "CLOTHING_ITEM_%s_HEAD_009_V_001",
            "CLOTHING_ITEM_%s_HEAD_010_V_001",
            "CLOTHING_ITEM_%s_HEAD_011_V_001",
            "CLOTHING_ITEM_%s_HEAD_012_V_001",
            "CLOTHING_ITEM_%s_HEAD_013_V_001",
            "CLOTHING_ITEM_%s_HEAD_014_V_001",
            "CLOTHING_ITEM_%s_HEAD_015_V_001",
            "CLOTHING_ITEM_%s_HEAD_018_V_001",
            "CLOTHING_ITEM_%s_HEAD_021_V_001",
            "CLOTHING_ITEM_%s_HEAD_022_V_001",
            "CLOTHING_ITEM_%s_HEAD_025_V_001",
            "CLOTHING_ITEM_%s_HEAD_028_V_001"
        },
        Body = {
            "CLOTHING_ITEM_%s_BODIES_UPPER_001_V_001",
            "CLOTHING_ITEM_%s_BODIES_UPPER_002_V_001",
            "CLOTHING_ITEM_%s_BODIES_UPPER_003_V_001",
            "CLOTHING_ITEM_%s_BODIES_UPPER_004_V_001",
            "CLOTHING_ITEM_%s_BODIES_UPPER_005_V_001",
            "CLOTHING_ITEM_%s_BODIES_UPPER_006_V_001"
        },
        Legs = {
            "CLOTHING_ITEM_%s_BODIES_LOWER_001_V_001",
            "CLOTHING_ITEM_%s_BODIES_LOWER_002_V_001",
            "CLOTHING_ITEM_%s_BODIES_LOWER_003_V_001",
            "CLOTHING_ITEM_%s_BODIES_LOWER_004_V_001",
            "CLOTHING_ITEM_%s_BODIES_LOWER_005_V_001",
            "CLOTHING_ITEM_%s_BODIES_LOWER_006_V_001"
        },

        Albedo = {
            "MP_HEAD_%sR1_SC08_C0_000_AB"
        },
    },
    {
        label = "Native Dark",
        imgColor = "skin2",
        Heads = {
            "CLOTHING_ITEM_%s_HEAD_001_V_002",
            "CLOTHING_ITEM_%s_HEAD_002_V_002",
            "CLOTHING_ITEM_%s_HEAD_003_V_002",
            "CLOTHING_ITEM_%s_HEAD_004_V_002",
            "CLOTHING_ITEM_%s_HEAD_005_V_002",
            "CLOTHING_ITEM_%s_HEAD_006_V_002",
            "CLOTHING_ITEM_%s_HEAD_007_V_002",
            "CLOTHING_ITEM_%s_HEAD_008_V_002",
            "CLOTHING_ITEM_%s_HEAD_009_V_002",
            "CLOTHING_ITEM_%s_HEAD_010_V_002",
            "CLOTHING_ITEM_%s_HEAD_011_V_002",
            "CLOTHING_ITEM_%s_HEAD_012_V_002",
            "CLOTHING_ITEM_%s_HEAD_013_V_002",
            "CLOTHING_ITEM_%s_HEAD_014_V_002",
            "CLOTHING_ITEM_%s_HEAD_015_V_002",
            "CLOTHING_ITEM_%s_HEAD_018_V_002",
            "CLOTHING_ITEM_%s_HEAD_021_V_002",
            "CLOTHING_ITEM_%s_HEAD_022_V_002",
            "CLOTHING_ITEM_%s_HEAD_025_V_002",
            "CLOTHING_ITEM_%s_HEAD_028_V_002",
        },
        Body = {
            "CLOTHING_ITEM_%s_BODIES_UPPER_001_V_002",
            "CLOTHING_ITEM_%s_BODIES_UPPER_002_V_002",
            "CLOTHING_ITEM_%s_BODIES_UPPER_003_V_002",
            "CLOTHING_ITEM_%s_BODIES_UPPER_004_V_002",
            "CLOTHING_ITEM_%s_BODIES_UPPER_005_V_002",
            "CLOTHING_ITEM_%s_BODIES_UPPER_006_V_002",
        },
        Legs = {
            "CLOTHING_ITEM_%s_BODIES_LOWER_001_V_002",
            "CLOTHING_ITEM_%s_BODIES_LOWER_002_V_002",
            "CLOTHING_ITEM_%s_BODIES_LOWER_003_V_002",
            "CLOTHING_ITEM_%s_BODIES_LOWER_004_V_002",
            "CLOTHING_ITEM_%s_BODIES_LOWER_005_V_002",
            "CLOTHING_ITEM_%s_BODIES_LOWER_006_V_002",
        },

        Albedo = { "MP_HEAD_%sR1_SC01_C0_000_AB" },
    },
    {

        label = "Mexican",
        imgColor = "skin3",
        Heads = {
            "CLOTHING_ITEM_%s_HEAD_001_V_003",
            "CLOTHING_ITEM_%s_HEAD_002_V_003",
            "CLOTHING_ITEM_%s_HEAD_003_V_003",
            "CLOTHING_ITEM_%s_HEAD_004_V_003",
            "CLOTHING_ITEM_%s_HEAD_005_V_003",
            "CLOTHING_ITEM_%s_HEAD_006_V_003",
            "CLOTHING_ITEM_%s_HEAD_007_V_003",
            "CLOTHING_ITEM_%s_HEAD_008_V_003",
            "CLOTHING_ITEM_%s_HEAD_009_V_003",
            "CLOTHING_ITEM_%s_HEAD_010_V_003",
            "CLOTHING_ITEM_%s_HEAD_011_V_003",
            "CLOTHING_ITEM_%s_HEAD_012_V_003",
            "CLOTHING_ITEM_%s_HEAD_013_V_003",
            "CLOTHING_ITEM_%s_HEAD_014_V_003",
            "CLOTHING_ITEM_%s_HEAD_015_V_003",
            "CLOTHING_ITEM_%s_HEAD_018_V_003",
            "CLOTHING_ITEM_%s_HEAD_021_V_003",
            "CLOTHING_ITEM_%s_HEAD_022_V_003",
            "CLOTHING_ITEM_%s_HEAD_025_V_003",
            "CLOTHING_ITEM_%s_HEAD_028_V_003",
        },
        Body = {
            "CLOTHING_ITEM_%s_BODIES_UPPER_001_V_003",
            "CLOTHING_ITEM_%s_BODIES_UPPER_002_V_003",
            "CLOTHING_ITEM_%s_BODIES_UPPER_003_V_003",
            "CLOTHING_ITEM_%s_BODIES_UPPER_004_V_003",
            "CLOTHING_ITEM_%s_BODIES_UPPER_005_V_003",
            "CLOTHING_ITEM_%s_BODIES_UPPER_006_V_003",
        },
        Legs = {
            "CLOTHING_ITEM_%s_BODIES_LOWER_001_V_003",
            "CLOTHING_ITEM_%s_BODIES_LOWER_002_V_003",
            "CLOTHING_ITEM_%s_BODIES_LOWER_003_V_003",
            "CLOTHING_ITEM_%s_BODIES_LOWER_004_V_003",
            "CLOTHING_ITEM_%s_BODIES_LOWER_005_V_003",
            "CLOTHING_ITEM_%s_BODIES_LOWER_006_V_003",
        },

        Albedo = { "MP_HEAD_%sR1_SC02_C0_000_AB" },
    },
    {

        label = "Asian",
        imgColor = "skin4",
        Heads = {
            "CLOTHING_ITEM_%s_HEAD_001_V_004",
            "CLOTHING_ITEM_%s_HEAD_002_V_004",
            "CLOTHING_ITEM_%s_HEAD_003_V_004",
            "CLOTHING_ITEM_%s_HEAD_004_V_004",
            "CLOTHING_ITEM_%s_HEAD_005_V_004",
            "CLOTHING_ITEM_%s_HEAD_006_V_004",
            "CLOTHING_ITEM_%s_HEAD_007_V_004",
            "CLOTHING_ITEM_%s_HEAD_008_V_004",
            "CLOTHING_ITEM_%s_HEAD_009_V_004",
            "CLOTHING_ITEM_%s_HEAD_010_V_004",
            "CLOTHING_ITEM_%s_HEAD_011_V_004",
            "CLOTHING_ITEM_%s_HEAD_012_V_004",
            "CLOTHING_ITEM_%s_HEAD_013_V_004",
            "CLOTHING_ITEM_%s_HEAD_014_V_004",
            "CLOTHING_ITEM_%s_HEAD_015_V_004",
            "CLOTHING_ITEM_%s_HEAD_018_V_004",
            "CLOTHING_ITEM_%s_HEAD_021_V_004",
            "CLOTHING_ITEM_%s_HEAD_022_V_004",
            "CLOTHING_ITEM_%s_HEAD_025_V_004",
            "CLOTHING_ITEM_%s_HEAD_028_V_004",
        },
        Body = {
            "CLOTHING_ITEM_%s_BODIES_UPPER_001_V_004",
            "CLOTHING_ITEM_%s_BODIES_UPPER_002_V_004",
            "CLOTHING_ITEM_%s_BODIES_UPPER_003_V_004",
            "CLOTHING_ITEM_%s_BODIES_UPPER_004_V_004",
            "CLOTHING_ITEM_%s_BODIES_UPPER_005_V_004",
            "CLOTHING_ITEM_%s_BODIES_UPPER_006_V_004",
        },
        Legs = {
            "CLOTHING_ITEM_%s_BODIES_LOWER_001_V_004",
            "CLOTHING_ITEM_%s_BODIES_LOWER_002_V_004",
            "CLOTHING_ITEM_%s_BODIES_LOWER_003_V_004",
            "CLOTHING_ITEM_%s_BODIES_LOWER_004_V_004",
            "CLOTHING_ITEM_%s_BODIES_LOWER_005_V_004",
            "CLOTHING_ITEM_%s_BODIES_LOWER_006_V_004",
        },

        Albedo = { "MP_HEAD_%sR1_SC03_C0_000_AB" },
    },
    {
        label = "Native",
        imgColor = "skin5",
        Heads = {
            "CLOTHING_ITEM_%s_HEAD_001_V_005",
            "CLOTHING_ITEM_%s_HEAD_002_V_005",
            "CLOTHING_ITEM_%s_HEAD_003_V_005",
            "CLOTHING_ITEM_%s_HEAD_004_V_005",
            "CLOTHING_ITEM_%s_HEAD_005_V_005",
            "CLOTHING_ITEM_%s_HEAD_006_V_005",
            "CLOTHING_ITEM_%s_HEAD_007_V_005",
            "CLOTHING_ITEM_%s_HEAD_008_V_005",
            "CLOTHING_ITEM_%s_HEAD_009_V_005",
            "CLOTHING_ITEM_%s_HEAD_010_V_005",
            "CLOTHING_ITEM_%s_HEAD_011_V_005",
            "CLOTHING_ITEM_%s_HEAD_012_V_005",
            "CLOTHING_ITEM_%s_HEAD_013_V_005",
            "CLOTHING_ITEM_%s_HEAD_014_V_005",
            "CLOTHING_ITEM_%s_HEAD_015_V_005",
            "CLOTHING_ITEM_%s_HEAD_018_V_005",
            "CLOTHING_ITEM_%s_HEAD_021_V_005",
            "CLOTHING_ITEM_%s_HEAD_022_V_005",
            "CLOTHING_ITEM_%s_HEAD_025_V_005",
            "CLOTHING_ITEM_%s_HEAD_028_V_005",
        },
        Body = {
            "CLOTHING_ITEM_%s_BODIES_UPPER_001_V_005",
            "CLOTHING_ITEM_%s_BODIES_UPPER_002_V_005",
            "CLOTHING_ITEM_%s_BODIES_UPPER_003_V_005",
            "CLOTHING_ITEM_%s_BODIES_UPPER_004_V_005",
            "CLOTHING_ITEM_%s_BODIES_UPPER_005_V_005",
            "CLOTHING_ITEM_%s_BODIES_UPPER_006_V_005",
        },
        Legs = {
            "CLOTHING_ITEM_%s_BODIES_LOWER_001_V_005",
            "CLOTHING_ITEM_%s_BODIES_LOWER_002_V_005",
            "CLOTHING_ITEM_%s_BODIES_LOWER_003_V_005",
            "CLOTHING_ITEM_%s_BODIES_LOWER_004_V_005",
            "CLOTHING_ITEM_%s_BODIES_LOWER_005_V_005",
            "CLOTHING_ITEM_%s_BODIES_LOWER_006_V_005",
        },

        Albedo = { "MP_HEAD_%sR1_SC04_C0_000_AB" },
    },
    {
        label = "African",
        imgColor = "skin6",
        Heads = {
            "CLOTHING_ITEM_%s_HEAD_001_V_006",
            "CLOTHING_ITEM_%s_HEAD_002_V_006",
            "CLOTHING_ITEM_%s_HEAD_003_V_006",
            "CLOTHING_ITEM_%s_HEAD_004_V_006",
            "CLOTHING_ITEM_%s_HEAD_005_V_006",
            "CLOTHING_ITEM_%s_HEAD_006_V_006",
            "CLOTHING_ITEM_%s_HEAD_007_V_006",
            "CLOTHING_ITEM_%s_HEAD_008_V_006",
            "CLOTHING_ITEM_%s_HEAD_009_V_006",
            "CLOTHING_ITEM_%s_HEAD_010_V_006",
            "CLOTHING_ITEM_%s_HEAD_011_V_006",
            "CLOTHING_ITEM_%s_HEAD_012_V_006",
            "CLOTHING_ITEM_%s_HEAD_013_V_006",
            "CLOTHING_ITEM_%s_HEAD_014_V_006",
            "CLOTHING_ITEM_%s_HEAD_015_V_006",
            "CLOTHING_ITEM_%s_HEAD_018_V_006",
            "CLOTHING_ITEM_%s_HEAD_021_V_006",
            "CLOTHING_ITEM_%s_HEAD_022_V_006",
            "CLOTHING_ITEM_%s_HEAD_025_V_006",
            "CLOTHING_ITEM_%s_HEAD_028_V_006",
        },
        Body = {
            "CLOTHING_ITEM_%s_BODIES_UPPER_001_V_006",
            "CLOTHING_ITEM_%s_BODIES_UPPER_002_V_006",
            "CLOTHING_ITEM_%s_BODIES_UPPER_003_V_006",
            "CLOTHING_ITEM_%s_BODIES_UPPER_004_V_006",
            "CLOTHING_ITEM_%s_BODIES_UPPER_005_V_006",
            "CLOTHING_ITEM_%s_BODIES_UPPER_006_V_006",
        },
        Legs = {
            "CLOTHING_ITEM_%s_BODIES_LOWER_001_V_006",
            "CLOTHING_ITEM_%s_BODIES_LOWER_002_V_006",
            "CLOTHING_ITEM_%s_BODIES_LOWER_003_V_006",
            "CLOTHING_ITEM_%s_BODIES_LOWER_004_V_006",
            "CLOTHING_ITEM_%s_BODIES_LOWER_005_V_006",
            "CLOTHING_ITEM_%s_BODIES_LOWER_006_V_006",
        },

        Albedo = { "MP_HEAD_%sR1_SC05_C0_000_AB" },
    },


}

--[[ ALBEDOS

      NORMALS
      --male
      GetHashKey('mp_head_mr1_008_nm'), // 0
      GetHashKey('mp_head_mr1_001_nm'), // 1
      GetHashKey('mp_head_mr1_002_nm'), // 2
      GetHashKey('mp_head_mr1_003_nm'), // 3
      GetHashKey('mp_head_mr1_004_nm'), // 4
      GetHashKey('mp_head_mr1_005_nm'), // 5

      --female
      GetHashKey('mp_head_fr1_008_nm'), // 0
      GetHashKey('mp_head_fr1_001_nm'), // 1
      GetHashKey('mp_head_fr1_002_nm'), // 2
      GetHashKey('mp_head_fr1_003_nm'), // 3
      GetHashKey('mp_head_fr1_004_nm'), // 4
      GetHashKey('mp_head_fr1_005_nm'), // 5

]]

Config.texture_types = {
    Male = {
        albedo = joaat("mp_head_mr1_sc08_c0_000_ab"),
        normal = joaat("mp_head_mr1_008_nm"),
        material = joaat("mp_head_mr1_000_m"),
        color_type = 1,
        texture_opacity = 1.0,
        unk_arg = 0,
    },
    Female = {
        albedo = joaat("mp_head_fr1_sc08_c0_000_ab"),
        normal = joaat("mp_head_fr1_008_nm"),
        material = joaat("mp_head_fr1_000_m"),
        color_type = 1,
        texture_opacity = 1.0,
        unk_arg = 0,
    }
}

local palettes = {
    joaat("METAPED_TINT_MAKEUP"),
    joaat("METAPED_TINT_SKIRT_CLEAN"),
    joaat("METAPED_TINT_HAT_WORN"),
    joaat("METAPED_TINT_SWATCH_002"),
    joaat("METAPED_TINT_HAT_CLEAN"),
    joaat("METAPED_TINT_SWATCH_003"),
    joaat("METAPED_TINT_GENERIC_CLEAN"),
    joaat("METAPED_TINT_HAT_WEATHERED"),
    joaat("METAPED_TINT_COMBINED"),
    joaat("METAPED_TINT_HORSE_LEATHER"),
    joaat("METAPED_TINT_ANIMAL"),
    joaat("METAPED_TINT_SWATCH_001"),
    joaat("METAPED_TINT_HORSE"),
    joaat("METAPED_TINT_EYE"),
    joaat("METAPED_TINT_GENERIC_CLEAN"),
    joaat("METAPED_TINT_GENERIC_WORN"),
    joaat("METAPED_TINT_SKIRT_WEATHERED"),
    joaat("METAPED_TINT_SWATCH_000"),
    joaat("METAPED_TINT_LEATHER"),
    joaat("METAPED_TINT_MPADV"),
    joaat("METAPED_TINT_SKIRT_WORN"),
    joaat("METAPED_TINT_HAIR"),
    joaat("METAPED_TINT_COMBINED_LEATHER"),
    joaat("METAPED_TINT_GENERIC_WEATHERED"),
    joaat("METAPED_TINT_HAT"),
    joaat("WEAPON_TINT_WOOD"),
    joaat("WEAPON_TINT_WOOD_WORKING"),
}

Config.color_palettes = {
    eyebrows = palettes,

    -- you can choose the color you want people to use by removing it from each category for example grime you dont want people to use pink
    grime = {
        0x3F6E70FF, -- black
        0x4101ED87, -- brown medium
        0xBBF43EF8, -- light brown
        0xDFB1F64C, -- brown

    },
    beardstabble = palettes,
    hair = palettes,
    scars = palettes,
    shadows = palettes,
    lipsticks = palettes,
    eyeliners = palettes,
    blush = palettes,
    foundation = palettes,
    paintedmasks = palettes,
}

Config.overlay_all_layers = {
    {
        name = "eyebrows", -- dont change
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 0.0,
    },
    {
        name = "scars",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "eyeliners",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "lipsticks",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "acne",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "shadows",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "beardstabble",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "hair",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "paintedmasks",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "ageing",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 0.0,
    },
    {
        name = "blush",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "complex",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "disc",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "foundation",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "freckles",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "grime",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "hair",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "moles",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
    {
        name = "spots",
        visibility = 0,
        tx_id = 1,
        tx_normal = 0,
        tx_material = 0,
        tx_color_type = 0,
        tx_opacity = 1.0,
        tx_unk = 0,
        palette = 0,
        palette_color_primary = 0,
        palette_color_secondary = 0,
        palette_color_tertiary = 0,
        var = 0,
        opacity = 1.0,
    },
}

Config.overlays_info = {
    eyebrows     = {
        { id = 0x07844317, albedo = 0xF81B2E66, normal = 0x7BC4288B, ma = 0x202674A1, },
        { id = 0x0A83CA6E, albedo = 0x8FA4286B, normal = 0xBD811948, ma = 0xB82C8FBB, },
        { id = 0x139A5CA3, albedo = 0x487ABE5A, normal = 0x22A9DDF9, ma = 0x78AA9401, },
        { id = 0x1832E474, albedo = 0x96FBB931, normal = 0x32FA2683, ma = 0xA1775B18, },
        { id = 0x216EF84C, albedo = 0x269CD8F8, normal = 0x2F54C727, ma = 0xCCBD1939, },
        { id = 0x2594304D, albedo = 0xA5A23CD1, normal = 0x8611B42C, ma = 0x0238302B, },
        { id = 0x33C39BC5, albedo = 0xF928E29B, normal = 0x46C268BD, ma = 0x4B92F13E, },
        { id = 0x443E3CBA, albedo = 0x6C83B571, normal = 0x2B191070, ma = 0xD551E623, },
        { id = 0x4F5052DE, albedo = 0x827EEF46, normal = 0x70E8C702, ma = 0xD97518F9, },
        { id = 0x5C049D35, albedo = 0x41E90506, normal = 0x7E47D163, ma = 0x54100288, },
        { id = 0x77A1546E, albedo = 0x43C4AE44, normal = 0x290FC7F7, ma = 0xD8FC26A9, },
        { id = 0x8A4B79C2, albedo = 0xAE6ED4E6, normal = 0x89B29E5A, ma = 0xFA0476E4, },
        { id = 0x9728137B, albedo = 0x23E65D35, normal = 0xEE39073F, ma = 0x218DD4C8, },
        { id = 0xA6DE8325, albedo = 0x7A93F649, normal = 0x22B33B65, ma = 0xEE6CCF11, },
        { id = 0xA8CCB6C4, albedo = 0x29AD8BF9, normal = 0x34ABB09D, ma = 0xCF206860, },
        { id = 0xB3F74D19, albedo = 0x3E2F71B1, normal = 0xD4809D11, ma = 0x9ABFA640, },
        { id = 0xBD38AFD9, albedo = 0x058A698E, normal = 0x9A732F86, ma = 0x2EF1D769, },
        { id = 0xCD0A4F7C, albedo = 0xED46998E, normal = 0xB5B73A38, ma = 0x15C5FB78, },
        { id = 0xD0EC86FF, albedo = 0x81B462A2, normal = 0x894F8744, ma = 0x51551810, },
        { id = 0xEB088A20, albedo = 0x0C6CDBDC, normal = 0x91A2496E, ma = 0xE639F138, },
        { id = 0xF0CA96FC, albedo = 0xAC3BCA3F, normal = 0x667FEFF8, ma = 0xDD8E5EFF, },
        { id = 0xF3351BD9, albedo = 0xC3286EA4, normal = 0x8BB9158A, ma = 0xFBBAE4D8, },
        { id = 0xF9052779, albedo = 0x8AEADE78, normal = 0x21BB2D97, ma = 0x75A0B928, },
        { id = 0xFE183197, albedo = 0x92B508CD, normal = 0x6AA92A3E, ma = 0xB4A436DB, },
    },
    scars        = {
        { id = 0xC8E45B5B, albedo = 0x6245579F, normal = 0xD53A336F, },
        { id = 0x90D86B44, albedo = 0xA1538E6F, normal = 0xDFCB1159, },
        { id = 0x23190FC3, albedo = 0x39683ECE, normal = 0x249C1A0A, },
        { id = 0x7574B47D, albedo = 0x3AB2A0BB, normal = 0x7A70886A, },
        { id = 0x7FE8C965, albedo = 0xB81C8D16, normal = 0x7210971B, },
        { id = 0x083059FE, albedo = 0xC332710C, normal = 0x860EE45E, },
        { id = 0x19E9FD71, albedo = 0x40895310, normal = 0xB753C5C7, },
        { id = 0x4CAF62FB, albedo = 0xD80F2F64, normal = 0x00BBF225, },
        { id = 0xDE650668, albedo = 0x85F6BF71, normal = 0x3DD0B0AE, },
        { id = 0xC648562B, albedo = 0x6397E4D9, normal = 0x2B59CDA1, },
        { id = 0x484BAEF8, albedo = 0xBF2946DE, normal = 0xD3F2F2F6, },
        { id = 0x190F5080, albedo = 0xCBBDB741, normal = 0x9518FA34, },
        { id = 0x2B5DF51D, albedo = 0x0E05C415, normal = 0x8B8C57AC, },
        { id = 0xE490E784, albedo = 0x50853115, normal = 0xDA7F2A1E, },
        { id = 0x0ED23C06, albedo = 0xAEA45D76, normal = 0x364DAAA6, },
        { id = 0x5712CCB6, albedo = 0x9318AF61, normal = 0x98104C8C, },
    },
    eyeliners    = {
        { id = 0x29A2E58F, albedo = 0xA952BF75, ma = 0xDD55AF2A, },
    },
    lipsticks    = {
        { id = 0x887E11E0, albedo = 0x96A5E4FB, normal = 0x1C77591C, ma = 0x4255A5F4, },
    },
    acne         = {
        { id = 0x96DD8F42, albedo = 0x1BA4244B, normal = 0xBA46CE92, },
    },
    shadows      = {
        { id = 0x47BD7289, albedo = 0x5C5C98FC, ma = 0xE20345CC, },
    },
    beardstabble = {
        { id = 0x375D4807, albedo = 0xB5827817, normal = 0x5041B648, ma = 0x83F42340, },
    },
    paintedmasks = {
        { id = 0x5995AA6F, albedo = 0x99BCB03F, },
    },
    ageing       = {
        { id = 0x96DD8F42, albedo = 0x1BA4244B, normal = 0xBA46CE92, },
        { id = 0x6D9DC405, albedo = 0xAFE82F0C, normal = 0x5CF8808E, },
        { id = 0x2761B792, albedo = 0x4105C6B3, normal = 0x8607CC56, },
        { id = 0x19009AD0, albedo = 0xEBC18618, normal = 0x9087AF96, },
        { id = 0xC29F6E07, albedo = 0xF9887FA7, normal = 0x1331C3C9, },
        { id = 0xA45F3187, albedo = 0x1C30961A, normal = 0x3CA2F3AE, },
        { id = 0x5E21250C, albedo = 0x01E35044, normal = 0x5A965FF0, },
        { id = 0x4FFE08C6, albedo = 0xA65757F2, normal = 0xC46CC005, },
        { id = 0x2DAD4485, albedo = 0x358DEFDA, normal = 0x55D317B4, },
        { id = 0x3F70680B, albedo = 0x7073A58F, normal = 0x33E73C5F, },
        { id = 0xD3310F8E, albedo = 0xD9E8A605, normal = 0x22297EA5, },
        { id = 0xF27A4C84, albedo = 0xE0F0971B, normal = 0x9F0E6718, },
        { id = 0x0044E819, albedo = 0xFD844ADF, normal = 0x315A6D56, },
        { id = 0xA648348D, albedo = 0xC329F765, normal = 0xE8CD7F20, },
        { id = 0x94F991F0, albedo = 0x8586D19B, normal = 0xCA334396, },
        { id = 0xCAACFD56, albedo = 0xD2D0BF4F, normal = 0xE0203BDA, },
        { id = 0xB9675ACB, albedo = 0x2387AF71, normal = 0x90A80AE1, },
        { id = 0x3C2CE03C, albedo = 0xC6DCBCCA, normal = 0x609B7EBD, },
        { id = 0xF2D64D90, albedo = 0xC6DCBCCA, normal = 0x609B7EBD, },
        { id = 0xE389AEF7, albedo = 0xDF591FF2, normal = 0x11D92A14, },
        { id = 0x89317A44, albedo = 0xB4640D19, normal = 0x2F56FDA5, },
        { id = 0x64B3347C, albedo = 0xFF2E8F96, normal = 0x45EE7B10, },
        { id = 0x9FFDAB10, albedo = 0x8F2950D9, normal = 0x85BDD7E8, },
        { id = 0x91D40EBD, albedo = 0x5DCD1D4E, normal = 0xA1B5F71F, },
        { id = 0x6B94C23F, albedo = 0xF17FE41C, normal = 0x0C480977, },
    },
    blush        = {
        { id = 0x6DB440FA, albedo = 0x43B1AACA, },
        { id = 0x47617455, albedo = 0x9CAD2EF0, },
        { id = 0x114D082D, albedo = 0xA52E3B98, },
        { id = 0xEC6F3E72, albedo = 0xB5CED4CB, },
    },
    complex      = {
        { id = 0xF679EDE7, albedo = 0xFAAE9FF0, },
        { id = 0x3FFB80ED, albedo = 0x1FDFD4A1, },
        { id = 0x31C0E478, albedo = 0xC72D0698, },
        { id = 0x2457C9A6, albedo = 0x98F1C76F, },
        { id = 0x16262D43, albedo = 0xE0D03293, },
        { id = 0x88F312DB, albedo = 0x2ECCC670, },
        { id = 0x785C71AE, albedo = 0xAE1C329F, },
        { id = 0x6D7D5BF0, albedo = 0x23201E55, },
        { id = 0x5F2FBF55, albedo = 0x94503F97, },
        { id = 0xBF38FF6A, albedo = 0x5F62F986, },
        { id = 0xF5656C26, albedo = 0x83417009, },
        { id = 0x03A408A3, albedo = 0x1BCC4185, },
        { id = 0x293453C3, albedo = 0x6C556574, },
        { id = 0x43150800, albedo = 0x1E486F85, },
    },
    disc         = {
        { id = 0xD44A5ABA, albedo = 0x2D3AEB2F, },
        { id = 0xE2CF77C4, albedo = 0xB8945AC0, },
        { id = 0xCF57D0E9, albedo = 0xB15E4E47, },
        { id = 0xE0A8738A, albedo = 0x25A711DD, },
        { id = 0xABD109DC, albedo = 0xCEBED6D9, },
        { id = 0xB91C2472, albedo = 0xFDD6C9AB, },
        { id = 0x894844B7, albedo = 0x7E89B165, },
        { id = 0x96FAE01C, albedo = 0x458799CD, },
        { id = 0x86D3BFCE, albedo = 0x8F2F2826, },
        { id = 0x5488DB39, albedo = 0xB49A0275, },
        { id = 0x7DA5A5AE, albedo = 0x8200F51D, },
        { id = 0xE73778DC, albedo = 0x8D35AC90, },
        { id = 0xD83EDADF, albedo = 0x96B619CD, },
        { id = 0xE380F163, albedo = 0xAB7309F7, },
        { id = 0xB4611324, albedo = 0x26FEBDD4, },
        { id = 0xC6ABB7B9, albedo = 0xC162C835, },
    },
    foundation   = {
        { id = 0xEF5AB280, albedo = 0xD9264247, ma = 0x1535C7C9, },
    },
    freckles     = {
        { id = 0x1B794C51, albedo = 0x59B8159A, },
        { id = 0x29BFE8DE, albedo = 0x03FCF67B, },
        { id = 0x0EF6B34C, albedo = 0x21E2FD82, },
        { id = 0x64925E7E, albedo = 0x3FD45844, },
        { id = 0xF5F280FC, albedo = 0xE372E00E, },
        { id = 0x33B0FC78, albedo = 0x288810E0, },
        { id = 0x25675FE5, albedo = 0xEB8C0B1D, },
        { id = 0xD10F3736, albedo = 0x3885AC2A, },
        { id = 0x5126B75F, albedo = 0xB061C984, },
        { id = 0x6B8EEC2F, albedo = 0xE1D1113E, },
        { id = 0x0A9A26F7, albedo = 0xA1EC1AEA, },
        { id = 0xFDE40D8B, albedo = 0x6DBC9203, },
        { id = 0x7E338E44, albedo = 0x097D1D0A, },
        { id = 0x70F273C2, albedo = 0x81A25BCE, },
        { id = 0x61C7D56D, albedo = 0x197A1335, },
    },
    grime        = {
        { id = 0xA2F30923, albedo = 0x16CDD724, normal = 0x136165B3, ma = 0xF3DFA7AC, },
        { id = 0xD5B1EEA0, albedo = 0x0E599D69, normal = 0x5C67FB68, ma = 0x40FEC59E, },
        { id = 0x7EC740CC, albedo = 0x0FAE8DC6, normal = 0x9E7A4B63, ma = 0xB48BF65A, },
        { id = 0xB08F245B, albedo = 0x98358521, normal = 0x1FAA4A84, ma = 0x81428E8F, },
        { id = 0x1A5E77F8, albedo = 0x8D3D2563, normal = 0x1FAA4A84, ma = 0x81428E8F, },
        { id = 0xE81B9373, albedo = 0xAE43378D, normal = 0x0CBEEF9B, ma = 0x92097B22, },
        { id = 0x3CFA3D2F, albedo = 0x7499570E, normal = 0xA27FF667, ma = 0x24B49749, },
        { id = 0x0B865A48, albedo = 0xB80F6B12, normal = 0x377319E3, ma = 0x3CDC25A9, },
        { id = 0x506DE416, albedo = 0x537BA522, normal = 0x006AF092, ma = 0x5CCEA9F8, },
        { id = 0x1F250185, albedo = 0x51BE975D, normal = 0x3F718027, ma = 0x5527ACCF, },
        { id = 0xE71930B0, albedo = 0x595D09A3, normal = 0xF4E08D43, ma = 0x60B91CE7, },
        { id = 0xDE571F2C, albedo = 0xE7FAFDFA, normal = 0xE6A18BBF, ma = 0xCB315A57, },
        { id = 0x0CA6FBCB, albedo = 0x0E27372E, normal = 0xD4894921, ma = 0xBF339D56, },
        { id = 0x21F62669, albedo = 0x693623F0, normal = 0xDB95176C, ma = 0xEA27B375, },
        { id = 0xFB09D881, albedo = 0xC4A40DA0, normal = 0xADD1DC3D, ma = 0xFD797A87, },
        { id = 0x11530513, albedo = 0x67C6D30F, normal = 0x26AA38C3, ma = 0x89C2FFE3, },
    },
    hair         = {
        { id = 0x39051515, albedo = 0x60A4A360, normal = 0x8D65EFF2, ma = 0x62759D82, },
        { id = 0x5E71DFEE, albedo = 0x71147B90, ma = 0xD8EB57BC, },
        { id = 0xDD735DEF, albedo = 0x493214E4, ma = 0x6613D121, },
        { id = 0x69622EAD, albedo = 0xA6E819C4, ma = 0xE581D851, },
    },
    moles        = {
        { id = 0x821FD077, albedo = 0xDFDA0798, normal = 0xE4E90C92, },
        { id = 0xCD38E6A8, albedo = 0xE9CF623E, normal = 0x43FAEA4B, },
        { id = 0x9F9D8B72, albedo = 0x27450B2F, normal = 0x0808DBFB, },
        { id = 0xE7179A39, albedo = 0x38638E0B, normal = 0x99346057, },
        { id = 0xBB094249, albedo = 0x763F8624, normal = 0x6975D6F9, },
        { id = 0x03AC5362, albedo = 0xEF158115, normal = 0xBA297751, },
        { id = 0x154FF6A9, albedo = 0xEE28E6F7, normal = 0xB7548307, },
        { id = 0x1E23084F, albedo = 0x566ACE2F, normal = 0x361237C6, },
        { id = 0x31DBAFC0, albedo = 0x0AB0CC2B, normal = 0xDBF55701, },
        { id = 0x3AC5C194, albedo = 0xC940CC25, normal = 0x41CB48FC, },
        { id = 0x4500D516, albedo = 0x3A1EEDB1, normal = 0x17BC19B0, },
        { id = 0x3695B840, albedo = 0x1D30222E, normal = 0xDA5FDF7E, },
        { id = 0x286C1BED, albedo = 0x4F0B4FA8, normal = 0x40333534, },
        { id = 0x934BF1AF, albedo = 0x4540A8D7, normal = 0x933ACF76, },
        { id = 0x84F55502, albedo = 0x47BE6D32, normal = 0xDCF7108E, },
        { id = 0xBD9A464B, albedo = 0x9DABB1B9, normal = 0x4A3B1739, },
    },
    spots        = {
        { id = 0x5BBFF5F7, albedo = 0x24968425, normal = 0xA5D532AD, },
        { id = 0x65EC0A4F, albedo = 0x326A7845, normal = 0xC09B2354, },
        { id = 0x3F143CA0, albedo = 0x91D7E39E, normal = 0xD607DF75, },
        { id = 0x49675146, albedo = 0x2E6C3769, normal = 0xE6A21CD5, },
        { id = 0x07504D2D, albedo = 0x39F16CE6, normal = 0x5CB32D5C, },
        { id = 0xF161214F, albedo = 0x47C60FBA, normal = 0x19424C77, },
        { id = 0xE43286F2, albedo = 0xA7E86379, normal = 0x7C07E0B0, },
        { id = 0xDDDC7A46, albedo = 0x26D3DA64, normal = 0x5A69A9BB, },
        { id = 0xD086DF9B, albedo = 0x7D6FF58C, normal = 0x5A0D99C8, },
        { id = 0xBA51B331, albedo = 0xCB23CA55, normal = 0xA7720C6A, },
        { id = 0xE4CF097B, albedo = 0x51D0FBDA, normal = 0xB01F5202, },
        { id = 0xF70CADF6, albedo = 0xD0858DFC, normal = 0x7E067837, },
        { id = 0xC07F40DC, albedo = 0x3BAF1008, normal = 0x75030E1B, },
        { id = 0xD3B1E741, albedo = 0x97091388, normal = 0xA191AA56, },
        { id = 0xB494A903, albedo = 0x18025AE1, normal = 0x86F51AD1, },
        { id = 0xC6EE4DB6, albedo = 0xC9F3EBA4, normal = 0xE819AD33, },
    },
}

Config.EyesColor = {
    "color1",
    "color2",
    "color3",
    "color4",
    "color5",
    "color6",
    "color7",
    "color8",
    "color9",
    "color10",
    "color11",
    "color12",
    "color13",
    "color14",
}

Config.Eyes = {

    "CLOTHING_ITEM_%s_EYES_001_TINT_001",
    "CLOTHING_ITEM_%s_EYES_001_TINT_002",
    "CLOTHING_ITEM_%s_EYES_001_TINT_003",
    "CLOTHING_ITEM_%s_EYES_001_TINT_004",
    "CLOTHING_ITEM_%s_EYES_001_TINT_005",
    "CLOTHING_ITEM_%s_EYES_001_TINT_006",
    "CLOTHING_ITEM_%s_EYES_001_TINT_007",
    "CLOTHING_ITEM_%s_EYES_001_TINT_008",
    "CLOTHING_ITEM_%s_EYES_001_TINT_009",
    "CLOTHING_ITEM_%s_EYES_001_TINT_010",
    "CLOTHING_ITEM_%s_EYES_001_TINT_011",
    "CLOTHING_ITEM_%s_EYES_001_TINT_012",
    "CLOTHING_ITEM_%s_EYES_001_TINT_013",
    "CLOTHING_ITEM_%s_EYES_001_TINT_014",

}


Config.BodyType = {
    Body = {
        61606861,
        -1241887289,
        -369348190,
        32611963,
        -20262001,
        -369348190
    },
    Waist = {
        -2045421226,
        -1745814259,
        -325933489,
        -1065791927,
        -844699484,
        -1273449080,
        927185840,
        149872391,
        399015098,
        -644349862,
        1745919061,
        1004225511,
        1278600348,
        502499352,
        -2093198664,
        -1837436619,
        1736416063,
        2040610690,
        -1173634986,
        -867801909,
        1960266524,
    }
}

Config.Teeth = {

    "CLOTHING_ITEM_%s_TEETH_000",
    "CLOTHING_ITEM_%s_TEETH_001",
    "CLOTHING_ITEM_%s_TEETH_002",
    "CLOTHING_ITEM_%s_TEETH_003",
    "CLOTHING_ITEM_%s_TEETH_004",
    "CLOTHING_ITEM_%s_TEETH_005",
    "CLOTHING_ITEM_%s_TEETH_006",
}

-- *TRANSLATE ["inside here"] below to your language*
Config.FaceFeatures = {
    head = {
        ["Head Width"] = { hash = 0x84D6, comp = "HeadSize" },
        ["Face Width"] = { hash = 41396, comp = "FaceW" },
        ["Face Depth"] = { hash = 12281, comp = "FaceD" },
        ["Forehead Size"] = { hash = 13059, comp = "FaceS" },
        ["Neck Width"] = { hash = 36277, comp = "NeckW" },
        ["Neck Depth"] = { hash = 60890, comp = "NeckD" },
    },

    eyesandbrows = {
        ["Brows Height"] = { hash = 0x3303, comp = "EyeBrowH" },
        ["Brows Width"] = { hash = 0x2FF9, comp = "EyeBrowW" },
        ["Brows Depth"] = { hash = 0x4AD1, comp = "EyeBrowD" },
        ["Eyes Depth"] = { hash = 0xEE44, comp = "EyeD" },
        ["Eyes Angle"] = { hash = 0xD266, comp = "EyeAng" },
        ["Eyes Distance"] = { hash = 0xA54E, comp = "EyeDis" },
        ["Eyes Height"] = { hash = 0xDDFB, comp = "EyeH" },
        ["Eyelid Height"] = { hash = 0x8B2B, comp = "EyeLidH" },
        ["Eyelid Width"] = { hash = 0x1B6B, comp = "EyeLidW" },
        ["Eyelid Left O/Close"] = { hash = 52902, comp = "EyeLidL" },
        ["Eyelid Right O/Close"] = { hash = 22421, comp = "EyeLidR" },
    },

    ears = {
        ["Ears Width"] = { hash = 0xC04F, comp = "EarsW" },
        ["Ears Angle"] = { hash = 0xB6CE, comp = "EarsA" },
        ["Ears Height"] = { hash = 0x2844, comp = "EarsH" },
        ["Ears Depth"] = { hash = 0xED30, comp = "EarsD" },
    },
    cheek = {
        ["CheekBone Height"] = { hash = 0x6A0B, comp = "CheekBonesH" },
        ["CheekBone Width"] = { hash = 0xABCF, comp = "CheekBonesW" },
        ["CheekBone Depth"] = { hash = 0x358D, comp = "CheekBonesD" },
    },
    jaw = {
        ["Jaw Height"] = { hash = 0x8D0A, comp = "JawH" },
        ["Jaw Width"] = { hash = 0xEBAE, comp = "JawW" },
        ["Jaw Depth"] = { hash = 0x1DF6, comp = "JawD" },
    },
    chin = {
        ["Chin Height"] = { hash = 0x3C0F, comp = "ChinH" },
        ["Chin Width"] = { hash = 0xC3B2, comp = "ChinW" },
        ["Chin Depth"] = { hash = 0xE323, comp = "ChinD" },
    },
    nose = {
        ["Nose Width"] = { hash = 0x6E7F, comp = "NoseW" },
        ["Nose Size"] = { hash = 0x3471, comp = "NoseS" },
        ["Nose Height"] = { hash = 0x03F5, comp = "NoseH" },
        ["Nose Angle"] = { hash = 0x34B1, comp = "NoseAng" },
        ["Nose Curvature"] = { hash = 0xF156, comp = "NoseC" },
        ["Nose Distance"] = { hash = 0x561E, comp = "NoseDis" },
    },
    mouthandlips = {
        ["Mouth Width"] = { hash = 0xF065, comp = "MouthW" },
        ["Mouth Depth"] = { hash = 0xAA69, comp = "MouthD" },
        ["Mouth DistanceX"] = { hash = 0x7AC3, comp = "MouthX" },
        ["Mouth DistanceY"] = { hash = 0x410D, comp = "MouthY" },
        ["Lip Upper Height"] = { hash = 0x1A00, comp = "ULiphH" },
        ["Lip Upper Width"] = { hash = 0x91C1, comp = "ULiphW" },
        ["Lip Upper Depth"] = { hash = 0xC375, comp = "ULiphD" },
        ["Lip Lower Height"] = { hash = 0xBB4D, comp = "LLiphH" },
        ["Lip Lower Width"] = { hash = 0xB0B0, comp = "LLiphW" },
        ["Lip Lower Depth"] = { hash = 0x5D16, comp = "LLiphD" },
        ["Mouth Corner Left Withd"] = { hash = 57350, comp = "MouthCLW" },
        ["Mouth Corner Right Withd"] = { hash = 60292, comp = "MouthCRW" },
        ["Mouth Corner Left Depth"] = { hash = 40950, comp = "MouthCLD" },
        ["Mouth Corner Right Depth"] = { hash = 49299, comp = "MouthCRD" },
        ["Mouth Corner Left Height"] = { hash = 46661, comp = "MouthCLH" },
        ["Mouth Corner Right Height"] = { hash = 55718, comp = "MouthCRH" },
        ["Mouth Corner Left Lips Distance"] = { hash = 22344, comp = "MouthCLLD" },
        ["Mouth Corner Right Lips Distance"] = { hash = 9423, comp = "MouthCRLD" },
    },
    upperbody = {
        ["Arms Size"] = { hash = 46032, comp = "ArmsS" },
        ["Upper Shoulders Size"] = { hash = 50039, comp = "ShouldersS" },
        ["Back Shoulders Thickness"] = { hash = 7010, comp = "ShouldersT" },
        ["Back Muscles"] = { hash = 18046, comp = "ShouldersM" }, -- shoulder blades / back muscles
        ["Chest Size"] = { hash = 27779, comp = "ChestS" },
        ["Waist Width"] = { hash = 50460, comp = "WaistW" },
        ["Hips Size"] = { hash = 49787, comp = "HipsS" }, -- hip width / stomach size
    },

    lowerbody = {
        ["Tights Size"] = { hash = 64834, comp = "LegsS" },
        ["Calves Size"] = { hash = 42067, comp = "CalvesS" },
    },

}


Config.ComponentCategories = {
    BeardsMustache      = `BEARDS_MUSTACHE`,
    Blouses             = `BLOUSES`,
    TalismanHolster     = `TALISMAN_HOLSTER`,
    Scarves             = `SCARVES`,
    TalismanBelt        = `TALISMAN_BELT`,
    EyeBrows            = `EYEBROWS`,
    ShirtsFullOverpants = `SHIRTS_FULL_OVERPANTS`,
    Eyes                = `EYES`,
    CoatsHeavy          = `COATS_HEAVY`,
    TalismanWrist       = `TALISMAN_WRIST`,
    Stockings           = `STOCKINGS`,
    Heads               = `HEADS`,
    BodiesUpper         = `BODIES_UPPER`,
    BodiesLower         = `BODIES_LOWER`,
    MaskLarge           = `MASKS_LARGE`,
    Apron               = `APRONS`,
    Gunbelt             = `GUNBELTS`,
    AmmoPistol          = `AMMO_PISTOLS`,
    AmmoRifle           = `AMMO_RIFLES`,
    Mask                = `MASKS`,
    Holster             = `HOLSTERS_LEFT`,
    Loadouts            = `LOADOUTS`,
    Coat                = `COATS`,
    Cloak               = `CLOAKS`,
    EyeWear             = `EYEWEAR`,
    Bracelet            = `JEWELRY_BRACELETS`,
    Skirt               = `SKIRTS`,
    Poncho              = `PONCHOS`,
    Spats               = `SPATS`,
    NeckTies            = `NECKTIES`,
    Pant                = `PANTS`,
    Suspender           = `SUSPENDERS`,
    Glove               = `GLOVES`,
    Satchels            = `SATCHELS`,
    GunbeltAccs         = `GUNBELT_ACCS`,
    CoatClosed          = `COATS_CLOSED`,
    Buckle              = `BELT_BUCKLES`,
    RingRh              = `JEWELRY_RINGS_RIGHT`,
    Belt                = `BELTS`,
    Accessories         = `ACCESSORIES`,
    Shirt               = `SHIRTS_FULL`,
    Gauntlets           = `GAUNTLETS`,
    Chap                = `CHAPS`,
    NeckWear            = `NECKWEAR`,
    Boots               = `BOOTS`,
    Spurs               = `BOOT_ACCESSORIES`,
    Vest                = `VESTS`,
    RingLh              = `JEWELRY_RINGS_LEFT`,
    Hat                 = `HATS`,
    Dress               = `DRESSES`,
    Badge               = `BADGES`,
    Armor               = `ARMOR`,
    Hair                = `HAIR`,
    Beard               = `BEARDS_COMPLETE`,
    Bow                 = `HAIR_ACCESSORIES`,
    Teeth               = `TEETH`,
}


Config.ComponentCategoriesExclude = {
    Hair = Config.ComponentCategories.Hair,
    Beard = Config.ComponentCategories.Beard,
    BeardsMustache = Config.ComponentCategories.BeardsMustache,
    Teeth = Config.ComponentCategories.Teeth,
    Heads = Config.ComponentCategories.Heads,
    BodiesUpper = Config.ComponentCategories.BodiesUpper,
    BodiesLower = Config.ComponentCategories.BodiesLower,
    Eyes = Config.ComponentCategories.Eyes,
    EyeBrows = Config.ComponentCategories.EyeBrows,
}

Config.clothesPalettes = {
    1090645383, 1064202495, -783849117, 864404955, 1669565057, -1952348042
}
