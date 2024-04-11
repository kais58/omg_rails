require 'csv'

after :rulesets do
  # Unlocks
  # Create a doctrineUnlock for the unlock as our seed unlocks are 1 to 1 with doctrineUnlocks
  #
  # CSV generated from the following SQL query
  # select da_id, internalName as internal_name, CONSTNAME as const, doctrine_tree as tree, branch, tier, description from doctrineabilities
  # where branch != 0 or tier != 0 order by CONSTNAME

  def snakecase(str)
    str.parameterize.underscore
  end

  def get_doc_str_from_const(str)
    str.split('.').third
  end

  def get_doc_location_str_from_const(str)
    str.split('.')[2..5].join(".")
  end

  doctrines_by_const = {
    INFANTRY: Doctrine.find_by_name("infantry"),
    AIRBOURNE: Doctrine.find_by_name("airborne"),
    ARMOUR: Doctrine.find_by_name("armor"),

    RCA: Doctrine.find_by_name("canadians"),
    ENGINEERS: Doctrine.find_by_name("engineers"),
    COMMANDO: Doctrine.find_by_name("commandos"),

    DEFENSIVE: Doctrine.find_by_name("defensive"),
    BLITZ: Doctrine.find_by_name("blitz"),
    TERROR: Doctrine.find_by_name("terror"),

    SCORCHED: Doctrine.find_by_name("scorched_earth"),
    LUFTWAFFE: Doctrine.find_by_name("luftwaffe"),
    TANKHUNTERS: Doctrine.find_by_name("tank_hunters")
  }.with_indifferent_access

  war_ruleset = Ruleset.find_by(ruleset_type: Ruleset.ruleset_types[:war], is_active: true)

  CSV.foreach('db/seeds/doctrineabilities.csv', headers: true) do |row|
    name = row["internal_name"]
    doc = get_doc_str_from_const(row["const"])
    doctrine = doctrines_by_const[doc]

    if row["description"].blank?
      name = get_doc_location_str_from_const(row["const"])
    end

    puts "name: #{name}, constname: #{row["const"]}, doctrine: #{doctrine.display_name}"
    is_disabled = row["vp"].to_i > 25
    unlock = Unlock.create!(name: snakecase(name), const_name: row["const"], display_name: name, description: row["description"], ruleset: war_ruleset)
    du = DoctrineUnlock.create!(doctrine: doctrine, unlock: unlock, ruleset: war_ruleset, vp_cost: row["vp"], tree: row["tree"], branch: row["branch"], row: row["tier"], disabled: is_disabled)

    Restriction.create!(doctrine_unlock: du,
                        name: "#{doctrine.display_name} | #{unlock.display_name}",
                        description: "#{doctrine.display_name} Doctrine Unlock Restriction - #{unlock.display_name}")
    Restriction.create!(unlock: unlock, name: unlock.display_name, description: "#{unlock.display_name} - Unlock Restriction")
  end
end
