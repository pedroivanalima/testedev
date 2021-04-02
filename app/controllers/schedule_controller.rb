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
                id: schedule.id,
                initial_time: schedule.initial_time.strftime("%Y-%m-%dT%H:%M"),
                final_time: schedule.final_time.strftime("%Y-%m-%dT%H:%M"),
                description: schedule.description
            },
            username: schedule.user.name
        }
    end

    def create
        schedule = Schedule.new
        schedule.initial_time   = params["initial_time"]
        schedule.final_time     = params["final_time"]
        schedule.description    = params["description"]
        schedule.user_id        = current_user.id
        
        if schedule.editable?
            if schedule.save
                render json: {}, status: 200
            else
                render json: {msg: schedule.errors.first.type}, status: 400
            end
        else
            render json: {msg: "Fora do prazo de edição."}, status: 400
        end
    end

    def update        
        schedule = Schedule.where(id: params["id"], user_id: current_user.id)[0]
        if schedule
            schedule.initial_time   = params["initial_time"]
            schedule.final_time     = params["final_time"]
            schedule.description    = params["description"]
            if schedule.save
                render json: {}, status: 200
                return
            end
        end
        msg = schedule.errors.first.type rescue "Operação não permitida"
        render json: {msg: msg}, status: 400
    end

    def destroy
        schedule = Schedule.where(id: params["id"], user_id: current_user.id)[0]
        if schedule
            schedule.destroy
            render json: {}, status: 200
        else
            #não pode deletar agenda do coleguinha
            render json: {msg: "Operação não permitida"}, status: 400
        end
    end
end