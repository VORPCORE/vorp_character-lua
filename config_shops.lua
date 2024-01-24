ConfigShops                   = {}

ConfigShops.UseShops          = true  -- if you want to use the shops set to true if not set to false

ConfigShops.SecondChancePrice = 15000 -- if store is second chance then this is the price they need to pay to use it

--[[ types of stores]]
-- clothing
-- hair
-- makeup
-- face
-- secondchance -- this enables all

-- DrawLight = { -- if need light add this to config
--   pos = vector3(-766.35, -1294.86, 43.85),
--
-- },

ConfigShops.Locations = {
    {                                                  -- valentine
        Prompt = {
            Position = vec3(-761.61, -1291.98, 43.85), -- prompt location
            Label = "Clothing Store",                  -- prompt label
        },
        Npc = {
            Enable = true,
            Model = "CS_FRANCIS_SINCLAIR",
            Position = vector4(-761.31, -1293.64, 43.84, 6.33),
        },
        Blip = {
            Enable = true,
            Sprite = 1195729388,
            Name = "Clothing Store",
        },
        EditCharacter = { -- where the player will be teleported to edit character
            Position = vector4(-767.98, -1294.88, 43.83, 263.09),
        },
        SpawnBack = { -- where the player will be teleported to after editing character
            Position = vector4(-766.53, -1293.13, 43.84, 357.64),
        },
        CameraPosition = { -- camera position for the character editor
            Position = vec3(-765.86, -1295.02, 44.14),
            Heading = 92.42,
            MaxUp = 44.85,
            MaxDown = 42.95,
        },
        TypeOfShop = "face", -- means all will be avaialble with a price to be paid to enter

    },
}


ConfigShops.Prices = {
    clothing = {
        CoatClosed = {
            price = 10,                                       -- if extra is enabled it will look for that and assignt hat price  instead
            extra = {
                { comp = 33333333, price = 20, currency = 0 } -- example of making some clothing to have a different prices
                --add more  if you want
            }
        },
        Hat = { price = 10 },
        EyeWear = { price = 10 },
        Mask = { price = 10 },
        NeckWear = { price = 10 },
        NeckTies = { price = 10 },
        Shirt = { price = 10 },
        Vest = { price = 10 },
        Coat = { price = 10 },
        Poncho = { price = 10 },
        Cloak = { price = 10 },
        Glove = { price = 10 },
        Bracelet = { price = 10 },
        Buckle = { price = 10 },
        Pant = { price = 10 },
        Skirt = { price = 10 },
        Chap = { price = 10 },
        Boots = { price = 10 },
        Spurs = { price = 10 },
        Spats = { price = 10 },
        GunbeltAccs = { price = 10 },
        Gauntlets = { price = 10 },
        Loadouts = { price = 10 },
        Accessories = { price = 10 },
        Satchels = { price = 10 },
        Dress = { price = 10 },
        Belt = { price = 10 },
        Holster = { price = 10 },
        Suspender = { price = 10 },
        armor = { price = 10 },
        Gunbelt = { price = 10 },
    },
    hair = {
        eyebrows = {
            price = 10,
        },
        Hair = {
            price = 10,
        },
        Beard = {
            price = 10,
        },
        Bow = { -- females only
            price = 10,
        },
        beardstabble = { -- shaved beard
            price = 10,
        },
        hair = { -- shaved head
            price = 10,
        },


    },
    makeup = {
        lipsticks = {
            price = 10,
        },
        blush = {
            price = 10,
        },
        shadows = {
            price = 10,
        },
        eyeliners = {
            price = 10,
        },
        grime = {
            price = 10,
        },
        foundation = {
            price = 10,
        },
        paintedmasks = {
            price = 10,
        },
    },
    face = {
        Theeth = {
            price = 10,
        },
        head = {
            price = 10,
        },
        eyesandbrows = {
            price = 10,
        },
        ears = {
            price = 10,
        },
        cheek = {
            price = 10,
        },
        jaw = {
            price = 10,
        },
        chin = {
            price = 10,
        },
        nose = {
            price = 10,
        },
        mouthandlips = {
            price = 10,
        },
        upperbody = {
            price = 10,
        },
        lowerbody = {
            price = 10,
        },
    }
}
