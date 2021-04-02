class HomeController < ApplicationController
    def index
        redirect_to schedule_path()
    end
end