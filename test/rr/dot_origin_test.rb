require 'dns/zone/test_case'

class DOT_Origin_Test < DNS::Zone::TestCase

  def test_load_rr__dot_origin
    zone = DNS::Zone.load(%Q{$ORIGIN .\n$ORIGIN lividpenguin.com.\nwww A 127.0.0.1}, 'lividpenguin.com')

    rr = zone.records.last
    assert_equal 'www.lividpenguin.com', rr.label
    assert_equal '127.0.0.1', rr.address

  end


  def test_load_rr__dot_origin_with_subdomain
    zone = DNS::Zone.load(%Q{$ORIGIN .\n$ORIGIN demo.lividpenguin.com.\nwww A 127.0.0.1}, 'lividpenguin.com')

    rr = zone.records.last
    assert_equal 'www.demo.lividpenguin.com', rr.label
    assert_equal '127.0.0.1', rr.address
  end


end
