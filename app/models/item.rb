class Item < ApplicationRecord
  belongs_to :league

  CURRENCY_FRAME_TYPE = 5

  # Items below are too common, not worth tracking
  IGNORED_ITEMS = [
    "Portal Scroll", "Scroll of Wisdom",
    "Alchemy Shard", "Alteration Shard", "Ancient Shard", "Annulment Shard",
    "Binding Shard", "Chaos Shard", "Engineer's Shard", "Exalted Shard",
    "Harbinger's Shard", "Horizon Shard", "Regal Shard", "Transmutation Shard",
    "Scroll Fragment", "Blacksmith's Whetstone", "Armourer's Scrap"
  ]
end
