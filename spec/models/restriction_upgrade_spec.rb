# == Schema Information
#
# Table name: restriction_upgrades
#
#  id                                                    :bigint           not null, primary key
#  fuel(Fuel cost)                                       :integer
#  man(Manpower cost)                                    :integer
#  mun(Munition cost)                                    :integer
#  pop(Population cost)                                  :integer
#  priority(Priority of this restriction)                :integer
#  type(What effect this restriction has on the upgrade) :string           not null
#  uses(Number of uses this upgrade provides)            :integer
#  created_at                                            :datetime         not null
#  updated_at                                            :datetime         not null
#  restriction_id                                        :bigint
#  ruleset_id                                            :bigint
#  upgrade_id                                            :bigint
#
# Indexes
#
#  index_restriction_upgrades_on_restriction_id  (restriction_id)
#  index_restriction_upgrades_on_ruleset_id      (ruleset_id)
#  index_restriction_upgrades_on_upgrade_id      (upgrade_id)
#
# Foreign Keys
#
#  fk_rails_...  (restriction_id => restrictions.id)
#  fk_rails_...  (ruleset_id => rulesets.id)
#  fk_rails_...  (upgrade_id => upgrades.id)
#
require "rails_helper"

RSpec.describe RestrictionUpgrade, type: :model do
  let!(:restriction_upgrade) { create :restriction_upgrade }

  describe 'associations' do
    it { should belong_to(:restriction) }
    it { should belong_to(:upgrade) }
    it { should belong_to(:ruleset) }
  end
end
