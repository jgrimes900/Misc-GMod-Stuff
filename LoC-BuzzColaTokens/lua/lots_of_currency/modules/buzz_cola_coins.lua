-- no workhsop items, comes as an example

local generic_collect = {"simpsons_hitrun/coin_collect_01b.wav", "simpsons_hitrun/coin_collect_03b.wav", "simpsons_hitrun/coin_collect_07b.wav"}

-- TODO: make the shells resize based on their sprite dimensions
LotsOfCurrency.RegisterDenomination(
  "buzz_cola_coins",
  {
    ents = {"bc_coin"},
    values = {1},
  },
  {
	bc_coin = {
      PrintName = "Buzz-Cola Token",
      Worth = 1,
      SpriteMaterial = "sprites/simpsons_hitrun/bc_coin",
      CollectNoises	= generic_collect,
	  HullSize = 25,
    },
  }
)
