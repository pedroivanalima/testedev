class Schedule < ApplicationRecord
    belongs_to :user

    validates :initial_time, :final_time, :user_id, presence: true
    validate :final_greater_than_initial
    validate :overlap?

    scope :week, -> (week_begin, week_end) {where("initial_time >= ? and final_time < ?", week_begin, week_end)}
    
    def overlap?
        r = Schedule.where("(? >= initial_time and ? < final_time) or (? >= initial_time and ? < final_time)", initial_time, initial_time, final_time, final_time)
                .where.not(id: self.id).size > 0
        if r
            errors.add(:initial_time, "Horário #{self.initial_time} ou #{self.final_time} sobrepõe com horário já existente: ")
        end
        r
    end

    #está dentro do prazo de edição que é 'dentro da semana'?
    def editable?
        Date.today.get_working_week_period[1] <= self.initial_time.to_date.get_working_week_period[1]
    end

    private
    def final_greater_than_initial
        if self.final_time <= self.initial_time
           errors.add(:final_time, "Final precisa ser maior que o inicial.")
        end
    end

end