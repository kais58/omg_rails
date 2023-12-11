# == Schema Information
#
# Table name: company_stats
#
#  id                         :bigint           not null, primary key
#  infantry_kills_1v1         :integer          default(0), not null
#  infantry_kills_2v2         :integer          default(0), not null
#  infantry_kills_3v3         :integer          default(0), not null
#  infantry_kills_4v4         :integer          default(0), not null
#  infantry_losses_1v1        :integer          default(0), not null
#  infantry_losses_2v2        :integer          default(0), not null
#  infantry_losses_3v3        :integer          default(0), not null
#  infantry_losses_4v4        :integer          default(0), not null
#  losses_1v1                 :integer          default(0), not null
#  losses_2v2                 :integer          default(0), not null
#  losses_3v3                 :integer          default(0), not null
#  losses_4v4                 :integer          default(0), not null
#  streak_1v1(win streak 1v1) :integer          default(0), not null
#  streak_2v2(win streak 2v2) :integer          default(0), not null
#  streak_3v3(win streak 3v3) :integer          default(0), not null
#  streak_4v4(win streak 4v4) :integer          default(0), not null
#  vehicle_kills_1v1          :integer          default(0), not null
#  vehicle_kills_2v2          :integer          default(0), not null
#  vehicle_kills_3v3          :integer          default(0), not null
#  vehicle_kills_4v4          :integer          default(0), not null
#  vehicle_losses_1v1         :integer          default(0), not null
#  vehicle_losses_2v2         :integer          default(0), not null
#  vehicle_losses_3v3         :integer          default(0), not null
#  vehicle_losses_4v4         :integer          default(0), not null
#  wins_1v1                   :integer          default(0), not null
#  wins_2v2                   :integer          default(0), not null
#  wins_3v3                   :integer          default(0), not null
#  wins_4v4                   :integer          default(0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  company_id                 :bigint           not null
#
# Indexes
#
#  index_company_stats_on_company_id  (company_id)
#
FactoryBot.define do
  factory :company_stats do
    association :company
  end
end

