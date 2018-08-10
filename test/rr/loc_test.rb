require 'dns/zone/test_case'

class RR_LOC_Test < DNS::Zone::TestCase

  def test_build_rr__loc
    rr = DNS::Zone::RR::LOC.new
    rr.lat_degrees = 33
    rr.lat_minutes = 40
    rr.lat_seconds = '31.000'
    rr.lat_direction = 'N'

    rr.long_degrees = 106
    rr.long_minutes = 28
    rr.long_seconds = '29.000'
    rr.long_direction = 'W'

    rr.altitude = '10.00m'
    rr.size = '1m'
    rr.precision_horz = '10000m'
    rr.precision_vert = '10m'

    assert_equal '@ IN LOC 33 40 31.000 N 106 28 29.000 W 10.00m 1m 10000m 10m', rr.dump
  end

  def test_load_rr__loc
    rr = DNS::Zone::RR::LOC.new.load('@ IN LOC 33 40 31.000 N 106 28 29.000 W 10.00m 1m 10000m 10m')
    assert_equal '@', rr.label
    assert_equal 'LOC', rr.type

    assert_equal 33, rr.lat_degrees
    assert_equal 40, rr.lat_minutes
    assert_equal '31.000', rr.lat_seconds
    assert_equal 'N', rr.lat_direction

    assert_equal 106, rr.long_degrees
    assert_equal 28, rr.long_minutes
    assert_equal '29.000', rr.long_seconds
    assert_equal 'W', rr.long_direction

    assert_equal '10.00m', rr.altitude
    assert_equal '1m', rr.size
    assert_equal '10000m', rr.precision_horz
    assert_equal '10m', rr.precision_vert

  end

  def test_load_rr__loc_short
    rr = DNS::Zone::RR::LOC.new.load('@ IN LOC 56 58 1.480 N 24 8 30.200 E 20.00m')
    assert_equal '@', rr.label
    assert_equal 'LOC', rr.type

    assert_equal 56, rr.lat_degrees
    assert_equal 58, rr.lat_minutes
    assert_equal '1.480', rr.lat_seconds
    assert_equal 'N', rr.lat_direction

    assert_equal 24, rr.long_degrees
    assert_equal 8, rr.long_minutes
    assert_equal '30.200', rr.long_seconds
    assert_equal 'E', rr.long_direction

    assert_equal '20.00m', rr.altitude
  end

  def test_load_rr__loc_negative_altitude
    rr = DNS::Zone::RR::LOC.new.load('@ IN LOC 33 40 31.000 N 106 28 29.000 W -24.55m 1m 10000m 10m')
    assert_equal '@', rr.label
    assert_equal 'LOC', rr.type

    assert_equal 33, rr.lat_degrees
    assert_equal 40, rr.lat_minutes
    assert_equal '31.000', rr.lat_seconds
    assert_equal 'N', rr.lat_direction

    assert_equal 106, rr.long_degrees
    assert_equal 28, rr.long_minutes
    assert_equal '29.000', rr.long_seconds
    assert_equal 'W', rr.long_direction

    assert_equal '-24.55m', rr.altitude
    assert_equal '1m', rr.size
    assert_equal '10000m', rr.precision_horz
    assert_equal '10m', rr.precision_vert

  end
end
