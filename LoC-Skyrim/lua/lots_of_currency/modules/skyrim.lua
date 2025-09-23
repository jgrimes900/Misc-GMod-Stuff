-- no workhsop items, comes as an example

local generic_collect = {"ths/sell1.wav", "ths/sell2.wav", "ths/sell3.wav", "ths/sell4.wav"}

-- TODO: make the shells resize based on their sprite dimensions
LotsOfCurrency.RegisterDenomination(
  "skyrim_septims",
  {
    ents = {"skyrim_large","skyrim_med","skyrim_small","skyrim_coin"},
    values = {100,50,25,1},
  },
  {
	skyrim_coin = {
      PrintName = "Septim",
      Worth = 1,
      Model = "models/props_clutter/coin.mdl",
      CollectNoises	= generic_collect,
    },
	skyrim_small = {
      PrintName = "Small Purse",
      Worth = 25,
      Model = "models/props_clutter/coin_mag_small.mdl",
      CollectNoises	= generic_collect,
    },
	skyrim_med = {
      PrintName = "Medium Purse",
      Worth = 50,
      Model = "models/props_clutter/coin_bag_mid.mdl",
      CollectNoises	= generic_collect,
    },
	skyrim_large = {
      PrintName = "Large Purse",
      Worth = 100,
      Model = "models/props_clutter/coin_bag_large.mdl",
      CollectNoises	= generic_collect,
    },
  }
)
