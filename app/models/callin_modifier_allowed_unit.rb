# == Schema Information
#
# Table name: callin_modifier_allowed_units
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  callin_modifier_id :bigint
#  unit_id            :bigint
#
# Indexes
#
#  index_callin_modifier_allowed_units_on_callin_modifier_id  (callin_modifier_id)
#  index_callin_modifier_allowed_units_on_unit_id             (unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (callin_modifier_id => callin_modifiers.id)
#  fk_rails_...  (unit_id => units.id)
#
class CallinModifierAllowedUnit < ApplicationRecord
  belongs_to :callin_modifier
  belongs_to :unit

  validates_presence_of :callin_modifier
  validates_presence_of :unit

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :callin_modifier_id, as: :callinModifierId
    expose :unit_id, as: :unitId
  end
end
