class Movie < ActiveRecord::Base
    def aratings
        return ['G','PG','PG-13','R']
    end
end
