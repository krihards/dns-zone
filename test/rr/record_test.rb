require 'dns/zone/test_case'

class RR_Record_Test < DNS::Zone::TestCase

  def test_rr_record_defaults
    rr = DNS::Zone::RR::Record.new
    assert_equal '@', rr.label, 'label is @, by default'
    assert_nil rr.ttl, 'ttl is nil, by default'
  end

  def test_rr_record_with_label
    rr = DNS::Zone::RR::Record.new
    rr.label = 'labelname'
    assert_equal 'labelname IN <type>', rr.dump
  end

  def test_rr_record_with_label_and_ttl
    rr = DNS::Zone::RR::Record.new
    rr.label = 'labelname'
    rr.ttl = '2d'
    assert_equal 'labelname 2d IN <type>', rr.dump
  end

  def test_rr_record_with_ttl
    rr = DNS::Zone::RR::Record.new
    rr.ttl = '2d'
    assert_equal '@ 2d IN <type>', rr.dump
  end

  # the load method should be overloaded by a subclass, calling direct should raise
  def test_record_load_default_method_raises_exception
    assert_raises(NotImplementedError) {
      DNS::Zone::RR::Record.new.load('')
    }
  end

end
