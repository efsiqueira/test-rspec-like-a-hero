class Weapon < ApplicationRecord
    validates :level, numericality: { greater_than: 0, less_than_or_equal_to: 99 }

    def current_power
        (power_base + ((level - 1) * power_step))
    end

    def title
        "#{self.name} ##{self.level}"
    end
end

# name, description, power_base, power_step, level
