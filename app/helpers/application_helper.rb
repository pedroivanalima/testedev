module ApplicationHelper
    def parse_initial_time week_begin, wday, hour
        (week_begin + wday.day).strftime("%Y-%m-%dT#{hour.to_s.rjust(2, "0")}:00")
    end

    #sugere o intervalo de 1h sugerido no desenvolvimento
    def parse_final_time week_begin, wday, hour
        parse_initial_time(week_begin, wday, hour + 1)
    end
end
