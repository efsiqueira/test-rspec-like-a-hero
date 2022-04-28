require 'rails_helper'

RSpec.describe "Weapons", type: :request do
    describe "GET /weapons" do
			it "the weapon's title is present" do
				weapons = create_list(:weapon, 3)
				get weapons_path
				weapons.each do |weapon|
					expect(response.body).to include(weapon.title)
				end
			end

			it "the weapon's name is present" do
				weapons = create_list(:weapon, 3)
				get weapons_path
				weapons.each do |weapon|
					expect(response.body).to include(weapon.name)
				end
			end

			it "the weapon's current power is present" do
				weapons = create_list(:weapon, 3)
				get weapons_path
				weapons.each do |weapon|
					expect(response.body).to include(weapon.current_power)
				end
			end

			it "the weapon details are presents" do
				weapons = create_list(:weapon, 3)
				get weapon_path
				weapons.each do |weapon|
					expect(response.body).to include(weapon)
				end
			end
		end

		describe "POST /weapons" do
			context "when it has valid parameters" do
				it "creates the weapon with correct attributes" do
					weapon_attributes = FactoryBot.attributes_for(:weapon)
					post weapons_path, params: { weapon: weapon_attributes }
					expect(Weapon.last).to have_attributes(weapon_attributes)
				end
			end

			context "when it has no valid parameters" do
				it "does not create weapon" do
					expect{
						post weapons_path, params: { weapon: { name: '', description: '', power_base: '', power_step: '', level: '' } }
					}.to_not change(Weapon, :count)
				end
			end
		end

		describe "DELETE /weapons" do
			
		end
end