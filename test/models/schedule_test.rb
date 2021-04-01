require "test_helper"

class ScheduleTest < ActiveSupport::TestCase
  test "empty_schedule" do
    schedule = Schedule.new
    assert_not schedule.save, "Schedule sem campos preenchidos"
  end
  
  test "overlap" do
    user = users(:one)

    schedule = Schedule.new
    schedule.initial_time   = '2021-01-01 11:00:00'
    schedule.final_time     = '2021-01-01 12:00:00'
    schedule.user_id        = user.id
    assert schedule.overlap?, "Método overlap falhou a detecção de overlap"
    assert_not schedule.save, "Schedule salvou sobre intervalo da anterior"

    schedule.initial_time   += 1.hour
    schedule.final_time     += 1.hour
    assert schedule.save!, "Schedule deveria ter salvo pois o 11~12h e 12~13h pode. #{schedule.initial_time} #{schedule.final_time}\n#{Schedule.first.initial_time} - #{Schedule.first.final_time}"
  end
end
