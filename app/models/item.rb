class Item < ApplicationRecord
  belongs_to :league
  CURRENCY_FRAME_TYPE = 5

  # update this after the temp league is merged
  STANDARD_ITEMS = [
    "Chaos Orb", "Orb of Fusing", "Orb of Alchemy", "Exalted Orb",
    "Orb of Annulment", "Jeweller's Orb", "Chromatic Orb", "Regal Orb",
    "Blessed Orb", "Divine Orb", "Ancient Orb", "Glassblower's Bauble",
    "Gemcutter's Prism", "Orb of Scouring", "Orb of Regret", "Vaal Orb",
    "Cartographer's Chisel", "Orb of Horizons",
    "Apprentice Cartographer's Sextant", "Journeyman Cartographer's Sextant",
    "Master Cartographer's Sextant", "Mirror of Kalandra",
    "Orb of Transmutation", "Orb of Alteration", "Orb of Chance",
    "Orb of Augmentation", "Silver Coin", "Warlord's Exalted Orb",
    "Redeemer's Exalted Orb", "Orb of Dominance", "Hunter's Exalted Orb",
    "Elevated Sextant", "Crusader's Exalted Orb", "Crescent Splinter",
    "Awakener's Orb", "Mirror Shard", "Exalted Shard", "Veiled Chaos Orb",
    "Surveyor's Compass", "Sacred Orb", "Orb of Unmaking", "Lesser Eldritch Ichor",
    "Lesser Eldritch Ember", "Instilling Orb", "Greater Eldritch Ichor",
    "Greater Eldritch Ember", "Grand Eldritch Ichor", "Grand Eldritch Ember",
    "Enkindling Orb", "Eldritch Orb of Annulment", "Eldritch Exalted Orb",
    "Eldritch Chaos Orb"
  ].freeze

  # update this if the current league introduced new currency items
  CURRENT_LEAGUE_ITEMS = [
    "Power Core", "Transforming Power Core", "Amplifying Power Core",
    "Augmenting Power Core", "Armour Recombinator", "Weapon Recombinator",
    "Jewellery Recombinator"
  ]
  CURRENCY = (STANDARD_ITEMS | CURRENT_LEAGUE_ITEMS).freeze
end
