class FiltersController < ApplicationController
    def index
        redirect_to root_url
    end
    def new
    @filters = Filter.new
    end
    def create

    end
end
