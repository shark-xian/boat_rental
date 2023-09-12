class Dock
  attr_reader :name,
              :max_rental_time,
              :boats_rented,
              :returned_boats

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @log_hour = 0
    @boats_rented = []
    @returned_boats = []
  end

  def rent(boat, renter)
    @boats_rented << [boat,renter]
  end

  def log_hour
    @boats_rented.map do |boat_rented|
      boat_rented[0].add_hour
    end
  end

  def return(boat)
    returned_boat = @boats_rented.find do |boat_rented|
      boat_rented[0] == boat
    end
    @returned_boats << returned_boat
  end

  def revenue
    @returned_boats.map do |boat|
      if boat[0].hours_rented > 3
        @max_rental_time % boat[0].hours_rented * boat[0].price_per_hour
      else
        boat[0].hours_rented * boat[0].price_per_hour
      end
    end.sum
  end

end
