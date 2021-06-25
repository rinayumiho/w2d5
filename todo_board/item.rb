class Item
    attr_accessor :title, :description
    attr_reader :done

    def self.valid_date?(str)
        arr = str.split("-")
        return false if arr[0].length != 4
        month = arr[1].to_i
        return false if month < 1 || month > 12
        day = arr[2].to_i
        return false if day < 1
        if [1, 3, 5, 7, 8, 10, 12].include?(month)
            return false if day > 31
        elsif [4, 6, 9, 11].include?(month)
            return false if day > 30
        else
            year = arr[0].to_i
            if(year % 100 != 0 && year % 4 == 0 || year % 400 == 0)
                return false if day > 29
            else
                return false if day > 28
            end
        end
        true
    end

    def initialize(title, deadline, description)
        raise "invalid date" if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def deadline
        @deadline
    end

    def deadline=(time)
        raise "invalid time" if !Item.valid_date?(time)
        @deadline = time
    end

    def toggle
        @done = !@done
    end
end