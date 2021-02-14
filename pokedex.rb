# rubocop:disable all
module Pokedex
  POKEMONS = {
    "Bulbasaur" => {
      species: "Bulbasaur",
      type: %i[grass poison],
      base_exp: 64,
      effort_points: { type: :special_attack, amount: 1 },
      growth_rate: :medium_slow,
      base_stats: { hp: 45, attack: 49, defense: 49, special_attack: 65, special_defense: 65, speed: 45 },
      moves: %w[tackle vine\ whip]
    },
    "Charmander" => {
      species: "Charmander",
      type: %i[fire],
      base_exp: 62,
      effort_points: { type: :speed, amount: 1 },
      growth_rate: :medium_slow,
      base_stats: { hp: 39, attack: 52, defense: 43, special_attack: 60, special_defense: 50, speed: 65 },
      moves: %w[scratch ember]
    },
    "Squirtle" => {
      species: "Squirtle",
      type: %i[water],
      base_exp: 63,
      effort_points: { type: :defense, amount: 1 },
      growth_rate: :medium_slow,
      base_stats: { hp: 44, attack: 48, defense: 65, special_attack: 50, special_defense: 64, speed: 43 },
      moves: %w[tackle bubble]
    },
    "Ratata" => {
      species: "Ratata",
      type: %i[normal],
      base_exp: 51,
      effort_points: { type: :speed, amount: 1 },
      growth_rate: :medium_fast,
      base_stats: { hp: 30, attack: 56, defense: 35, special_attack: 25, special_defense: 35, speed: 72 },
      moves: %w[tackle quick\ attack]
    },
    "Spearow" => {
      species: "Spearow",
      type: %i[normal flying],
      base_exp: 52,
      effort_points: { type: :speed, amount: 1 },
      growth_rate: :medium_fast,
      base_stats: { hp: 40, attack: 60, defense: 30, special_attack: 31, special_defense: 31, speed: 70 },
      moves: %w[peck persuit]
    },
    "Pikachu" => {
      species: "Pikachu",
      type: %i[electric],
      base_exp: 112,
      effort_points: { type: :speed, amount: 2 },
      growth_rate: :medium_fast,
      base_stats: { hp: 35, attack: 55, defense: 40, special_attack: 50, special_defense: 50, speed: 90 },
      moves: %w[thunder\ shock quick\ attack]
    },
    "Onix" => {
      species: "Onix",
      type: %i[rock ground],
      base_exp: 77,
      effort_points: { type: :defense, amount: 1 },
      growth_rate: :medium_fast,
      base_stats: { hp: 35, attack: 45, defense: 160, special_attack: 30, special_defense: 45, speed: 70 },
      moves: %w[tackle rock\ throw]
    }
  }.freeze

  MOVES = {
    "tackle" => {
      name: "tackle",
      type: :normal,
      power: 40,
      accuracy: 100,
      priority: 0
    },
    "vine whip" => {
      name: "vine whip",
      type: :grass,
      power: 45,
      accuracy: 100,
      priority: 0
    },
    "scratch" => {
      name: "scratch",
      type: :normal,
      power: 40,
      accuracy: 100,
      priority: 0
    },
    "ember" => {
      name: "ember",
      type: :fire,
      power: 40,
      accuracy: 100,
      priority: 0
    },
    "bubble" => {
      name: "bubble",
      type: :water,
      power: 40,
      accuracy: 100,
      priority: 0
    },
    "quick attack" => {
      name: "quick attack",
      type: :normal,
      power: 40,
      accuracy: 100,
      priority: 1
    },
    "peck" => {
      name: "peck",
      type: :flying,
      power: 35,
      accuracy: 100,
      priority: 0
    },
    "persuit" => {
      name: "persuit",
      type: :dark,
      power: 40,
      accuracy: 100,
      priority: 0
    },
    "thunder shock" => {
      name: "thunder shock",
      type: :electric,
      power: 40,
      accuracy: 100,
      priority: 0
    },
    "rock throw" => {
      name: "rock throw",
      type: :rock,
      power: 50,
      accuracy: 90,
      priority: 0
    }
  }.freeze

  # We used this constant to store all the required experience for each level on each growth rate.
  # You can use it or create your own methods to do it
  # LEVEL_TABLES = {
  #   slow: (1..100).map { |level| ((5 * level**3) / 4.0).floor },
  #   medium_slow: (1..100).map { |level| (6 / 5.0 * level**3 - 15 * level**2 + 100 * level - 140).floor },
  #   medium_fast: (1..100).map { |level| (level**3).floor },
  #   fast: (1..100).map { |level| (4 * level**3 / 5.0).floor }
  # }.freeze

  # If the move's type is in this list, the move is special
  SPECIAL_MOVE_TYPE = %i[water grass fire ice electric psychic dragon dark].freeze

  TYPE_MULTIPLIER = [
    { user: :normal, target: :rock, multiplier: 0.5 },
    { user: :normal, target: :ghost, multiplier: 0 },
    { user: :normal, target: :steel, multiplier: 0.5 },

    { user: :fire, target: :fire, multiplier: 0.5 },
    { user: :fire, target: :water, multiplier: 0.5 },
    { user: :fire, target: :grass, multiplier: 2 },
    { user: :fire, target: :ice, multiplier: 2 },
    { user: :fire, target: :bug, multiplier: 2 },
    { user: :fire, target: :rock, multiplier: 0.5 },
    { user: :fire, target: :dragon, multiplier: 0.5 },
    { user: :fire, target: :steel, multiplier: 2 },

    { user: :water, target: :fire, multiplier: 2 },
    { user: :water, target: :water, multiplier: 0.5 },
    { user: :water, target: :grass, multiplier: 0.5 },
    { user: :water, target: :ground, multiplier: 2 },
    { user: :water, target: :rock, multiplier: 2 },
    { user: :water, target: :dragon, multiplier: 0.5 },

    { user: :electric, target: :water, multiplier: 2 },
    { user: :electric, target: :electric, multiplier: 0.5 },
    { user: :electric, target: :grass, multiplier: 0.5 },
    { user: :electric, target: :ground, multiplier: 0 },
    { user: :electric, target: :flying, multiplier: 2 },
    { user: :electric, target: :dragon, multiplier: 0.5 },

    { user: :grass, target: :fire, multiplier: 0.5 },
    { user: :grass, target: :water, multiplier: 2 },
    { user: :grass, target: :grass, multiplier: 0.5 },
    { user: :grass, target: :poison, multiplier: 0.5 },
    { user: :grass, target: :ground, multiplier: 2 },
    { user: :grass, target: :flying, multiplier: 0.5 },
    { user: :grass, target: :bug, multiplier: 0.5 },
    { user: :grass, target: :rock, multiplier: 2 },
    { user: :grass, target: :dragon, multiplier: 0.5 },
    { user: :grass, target: :steel, multiplier: 0.5 },

    { user: :ice, target: :fire, multiplier: 0.5 },
    { user: :ice, target: :water, multiplier: 0.5 },
    { user: :ice, target: :grass, multiplier: 2 },
    { user: :ice, target: :ice, multiplier: 0.5 },
    { user: :ice, target: :ground, multiplier: 2 },
    { user: :ice, target: :flying, multiplier: 2 },
    { user: :ice, target: :dragon, multiplier: 2 },
    { user: :ice, target: :steel, multiplier: 0.5 },

    { user: :fighting, target: :normal, multiplier: 2 },
    { user: :fighting, target: :ice, multiplier: 2 },
    { user: :fighting, target: :poison, multiplier: 0.5 },
    { user: :fighting, target: :flying, multiplier: 0.5 },
    { user: :fighting, target: :psychic, multiplier: 0.5 },
    { user: :fighting, target: :bug, multiplier: 0.5 },
    { user: :fighting, target: :rock, multiplier: 2 },
    { user: :fighting, target: :ghost, multiplier: 0 },
    { user: :fighting, target: :dark, multiplier: 2 },
    { user: :fighting, target: :steel, multiplier: 2 },
    { user: :fighting, target: :fairy, multiplier: 0.5 },

    { user: :poison, target: :grass, multiplier: 2 },
    { user: :poison, target: :poison, multiplier: 0.5 },
    { user: :poison, target: :ground, multiplier: 0.5 },
    { user: :poison, target: :rock, multiplier: 0.5 },
    { user: :poison, target: :ghost, multiplier: 0.5 },
    { user: :poison, target: :steel, multiplier: 0 },
    { user: :poison, target: :fairy, multiplier: 2 },

    { user: :ground, target: :fire, multiplier: 2 },
    { user: :ground, target: :electric, multiplier: 2 },
    { user: :ground, target: :grass, multiplier: 0.5 },
    { user: :ground, target: :poison, multiplier: 2 },
    { user: :ground, target: :flying, multiplier: 0 },
    { user: :ground, target: :bug, multiplier: 0.5 },
    { user: :ground, target: :rock, multiplier: 2 },
    { user: :ground, target: :steel, multiplier: 2 },

    { user: :flying, target: :electric, multiplier: 0.5 },
    { user: :flying, target: :grass, multiplier: 2 },
    { user: :flying, target: :fighting, multiplier: 2 },
    { user: :flying, target: :bug, multiplier: 2 },
    { user: :flying, target: :rock, multiplier: 0.5 },
    { user: :flying, target: :steel, multiplier: 0.5 },

    { user: :psychic, target: :fighting, multiplier: 2 },
    { user: :psychic, target: :poison, multiplier: 2 },
    { user: :psychic, target: :psychic, multiplier: 0.5 },
    { user: :psychic, target: :dark, multiplier: 0 },
    { user: :psychic, target: :steel, multiplier: 0.5 },

    { user: :bug, target: :fire, multiplier: 0.5 },
    { user: :bug, target: :grass, multiplier: 2 },
    { user: :bug, target: :fighting, multiplier: 0.5 },
    { user: :bug, target: :poison, multiplier: 0.5 },
    { user: :bug, target: :flying, multiplier: 0.5 },
    { user: :bug, target: :psychic, multiplier: 2 },
    { user: :bug, target: :ghost, multiplier: 0.5 },
    { user: :bug, target: :dark, multiplier: 2 },
    { user: :bug, target: :steel, multiplier: 0.5 },
    { user: :bug, target: :fairy, multiplier: 0.5 },

    { user: :rock, target: :fire, multiplier: 2 },
    { user: :rock, target: :ice, multiplier: 2 },
    { user: :rock, target: :fighting, multiplier: 0.5 },
    { user: :rock, target: :ground, multiplier: 0.5 },
    { user: :rock, target: :flying, multiplier: 2 },
    { user: :rock, target: :bug, multiplier: 2 },
    { user: :rock, target: :steel, multiplier: 0.5 },

    { user: :ghost, target: :normal, multiplier: 0 },
    { user: :ghost, target: :psychic, multiplier: 2 },
    { user: :ghost, target: :ghost, multiplier: 2 },
    { user: :ghost, target: :dark, multiplier: 0.5 },

    { user: :dragon, target: :dragon, multiplier: 2 },
    { user: :dragon, target: :steel, multiplier: 0.5 },
    { user: :dragon, target: :fairy, multiplier: 0 },

    { user: :dark, target: :fighting, multiplier: 0.5 },
    { user: :dark, target: :psychic, multiplier: 2 },
    { user: :dark, target: :ghost, multiplier: 2 },
    { user: :dark, target: :dark, multiplier: 0.5 },
    { user: :dark, target: :fairy, multiplier: 0.5 },

    { user: :steel, target: :fire, multiplier: 0.5 },
    { user: :steel, target: :water, multiplier: 0.5 },
    { user: :steel, target: :electric, multiplier: 0.5 },
    { user: :steel, target: :ice, multiplier: 2 },
    { user: :steel, target: :rock, multiplier: 2 },
    { user: :steel, target: :steel, multiplier: 0.5 },
    { user: :steel, target: :fairy, multiplier: 2 },

    { user: :fairy, target: :fire, multiplier: 0.5 },
    { user: :fairy, target: :fighting, multiplier: 2 },
    { user: :fairy, target: :poison, multiplier: 0.5 },
    { user: :fairy, target: :dragon, multiplier: 2 },
    { user: :fairy, target: :dark, multiplier: 2 },
    { user: :fairy, target: :steel, multiplier: 0.5 }
  ].freeze
end
# rubocop:enable all
