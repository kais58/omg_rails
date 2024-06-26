# == Schema Information
#
# Table name: restrictions
#
#  id                                             :bigint           not null, primary key
#  description(Restriction description)           :text
#  name(Restriction name)                         :string
#  vet_requirement(Minimum veterancy requirement) :integer
#  created_at                                     :datetime         not null
#  updated_at                                     :datetime         not null
#  doctrine_id                                    :bigint
#  doctrine_unlock_id                             :bigint
#  faction_id                                     :bigint
#  unlock_id                                      :bigint
#
# Indexes
#
#  index_restrictions_on_doctrine_id         (doctrine_id)
#  index_restrictions_on_doctrine_unlock_id  (doctrine_unlock_id)
#  index_restrictions_on_faction_id          (faction_id)
#  index_restrictions_on_unlock_id           (unlock_id)
#  unique_not_null_doctrine_id               (doctrine_id) UNIQUE WHERE (doctrine_id IS NOT NULL)
#  unique_not_null_doctrine_unlock_id        (doctrine_unlock_id) UNIQUE WHERE (doctrine_unlock_id IS NOT NULL)
#  unique_not_null_faction_id                (faction_id) UNIQUE WHERE (faction_id IS NOT NULL)
#  unique_not_null_unlock_id                 (unlock_id) UNIQUE WHERE (unlock_id IS NOT NULL)
#
# Foreign Keys
#
#  fk_rails_...  (doctrine_id => doctrines.id)
#  fk_rails_...  (doctrine_unlock_id => doctrine_unlocks.id)
#  fk_rails_...  (faction_id => factions.id)
#  fk_rails_...  (unlock_id => unlocks.id)
#
class Restriction < ApplicationRecord
  belongs_to :faction, optional: true
  belongs_to :doctrine, optional: true
  belongs_to :doctrine_unlock, optional: true
  belongs_to :unlock, optional: true

  has_many :restriction_units
  has_many :enabled_units
  has_many :disabled_units
  has_many :modified_add_units
  has_many :modified_replace_units
  has_many :units, through: :restriction_units
  has_many :restriction_upgrades
  has_many :enabled_upgrades
  has_many :disabled_upgrades
  has_many :modified_add_upgrades
  has_many :modified_replace_upgrades
  has_many :upgrades, through: :restriction_upgrades
  has_many :restriction_offmaps
  has_many :enabled_offmaps
  has_many :disabled_offmaps
  has_many :offmaps, through: :restriction_offmaps
  has_many :restriction_callin_modifiers
  has_many :enabled_callin_modifiers
  has_many :callin_modifiers, through: :restriction_callin_modifiers

  validates_presence_of :name
  validate :only_one_of_faction_doctrine_unlock
  validates :faction_id, uniqueness: { allow_blank: true }
  validates :doctrine_id, uniqueness: { allow_blank: true }
  validates :doctrine_unlock_id, uniqueness: { allow_blank: true }
  validates :unlock_id, uniqueness: { allow_blank: true }

  def only_one_of_faction_doctrine_unlock
    if faction_id.present? && (doctrine_id.present? || doctrine_unlock_id.present? || unlock_id.present?)
      errors.add(:faction_id, "Can only have one of faction_id, doctrine_id, doctrine_unlock_id, or unlock_id present")
    end
    if doctrine_id.present? && (faction_id.present? || doctrine_unlock_id.present? || unlock_id.present?)
      errors.add(:doctrine_id, "Can only have one of faction_id, doctrine_id, doctrine_unlock_id, or unlock_id present")
    end
    if doctrine_unlock_id.present? && (faction_id.present? || doctrine_id.present? || unlock_id.present?)
      errors.add(:doctrine_unlock_id, "Can only have one of faction_id, doctrine_id, doctrine_unlock_id, or unlock_id present")
    end
    if unlock_id.present? && (faction_id.present? || doctrine_id.present? || doctrine_unlock_id.present?)
      errors.add(:unlock_id, "Can only have one of faction_id, doctrine_id, doctrine_unlock_id, or unlock_id present")
    end
    if faction_id.blank? && doctrine_id.blank? && doctrine_unlock_id.blank? && unlock_id.blank?
      errors.add(:only_one_of_faction_doctrine_unlock, "Must have one of faction_id, doctrine_id, doctrine_unlock_id, unlock_id")
    end
  end

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :description
    expose :name
    expose :vet_requirement, as: :vetRequirement
    expose :faction_id, as: :factionId
    expose :doctrine_id, as: :doctrineId
    expose :doctrine_unlock_id, as: :doctrineUnlockId
    expose :unlock_id, as: :unlockId
  end
end
