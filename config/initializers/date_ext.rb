class Date
    #lembrando que os intervalos estão sendo tratados como inicio fechado e final aberto (>= e <)

    def get_week_period
        [(self - (self.wday).days), (self + (7 - self.wday).days)]
    end

    def get_working_week_period
        r = get_week_period
        [r[0] + 1.day, r[1] - 1.day]
    end
end