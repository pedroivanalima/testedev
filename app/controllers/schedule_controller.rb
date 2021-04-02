class ScheduleController < ApplicationController
    def index
        @day = params["date"] ? Date.parse(params["date"]) : Date.today
        @week_begin, @week_end = @day.get_working_week_period
        @schedule = {}
        Schedule.select(:id, :user_id, :initial_time).includes(:user).week(@week_begin, @week_end).each do |s|
            @schedule[s.initial_time.wday] ||= {}
            @schedule[s.initial_time.wday][s.initial_time.hour] = s
        end
    end

    def detail
        schedule = Schedule.includes(:user).find(params["id"])
        render json: {
            schedule: {
                initial_time: schedule.initial_time.strftime("%Y-%m-%dT%H:%M"),
                final_time: schedule.final_time.strftime("%Y-%m-%dT%H:%M"),
                description: schedule.description
            },
            username: schedule.user.name 
        }
    end
end