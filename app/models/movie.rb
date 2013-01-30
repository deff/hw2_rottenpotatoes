class Movie < ActiveRecord::Base

    def self.aratings
        return ["G","PG","PG-13","R"]
    end
end
