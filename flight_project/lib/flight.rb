class Flight
    attr_reader :passengers

    def initialize(str, num)
        @flight_number = str.upcase
        @capacity = num
        @passengers = []
    end

    def full?
        @passengers.length == @capacity
    end

    def board_passenger(passenger)
        passengers << passenger if passenger.has_flight?(@flight_number) && !full?
    end

    def list_passengers
        @passengers.map { |p| p.name }
    end

    def [](idx)
        @passengers[idx]
    end

    def <<(passenger)
        board_passenger(passenger)
    end
end