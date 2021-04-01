class Schedule < ApplicationRecord
    belongs_to :user

    validates :initial_time, :final_time, :user_id, presence: true

    validate :overlap?
    
    def overlap?
        r = Schedule.where("(? >= initial_time and ? < final_time) or (? >= initial_time and ? < final_time)", initial_time, initial_time, final_time, final_time)
                .where.not(id: self.id).size > 0
        if r
            errors.add(:initial_time, "Horário #{self.initial_time} ou #{self.final_time} sobrepõe com horário já existente: ")
        end
        r
    end
end