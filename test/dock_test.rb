require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/dock'
require './lib/boat'
require './lib/renter'
require 'pry'

class DockTest <Minitest::Test
  def test_it_exists
    dock = Dock.new("The Rowing Dock", 3)

    assert_instance_of Dock, dock
  end

  def test_dock_has_a_name
    dock = Dock.new("The Rowing Dock", 3)

    assert_equal "The Rowing Dock", dock.name
  end

  def test_dock_has_max_rental_time
    dock = Dock.new("The Rowing Dock", 3)

    assert_equal 3, dock.max_rental_time
  end

  def test_dock_can_store_rented_boats_in_array
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)

    assert_equal [[kayak_1,patrick],[kayak_2,patrick]], dock.boats_rented
  end

  def test_it_can_log_hours
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour
    dock.rent(canoe,patrick)
    dock.log_hour


    assert_equal 2, dock.boats_rented[0][0].hours_rented
    assert_equal 1, dock.boats_rented[2][0].hours_rented

  end

  def test_can_calculate_revenue_for_first_renter
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour
    dock.rent(canoe, patrick)
    dock.log_hour
    dock.return(kayak_1)
    dock.return(kayak_2)
    dock.return(canoe)

    assert_equal 105, dock.revenue
  end

  def test_can_calculate_revenue_2

    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(sup_1, eugene)
    dock.rent(sup_2, eugene)
    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.return(sup_1)
    dock.return(sup_2)

    assert_equal 90, dock.revenue
  end


end
