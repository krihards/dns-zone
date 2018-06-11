require 'dns/zone/test_case'

class RR_TXT_Test < DNS::Zone::TestCase

  def test_build_rr__txt
    rr = DNS::Zone::RR::TXT.new

    # ensure we can set text parameter
    rr.text = 'test text'
    assert_equal '@ IN TXT "test text"', rr.dump

    # with a label set
    rr.label = 'labelname'
    assert_equal 'labelname IN TXT "test text"', rr.dump

    # with a ttl
    rr.ttl = '2w'
    assert_equal 'labelname 2w IN TXT "test text"', rr.dump
  end

  def test_build_rr__txt_multiline
    rr = DNS::Zone::RR::TXT.new

    # ensure we can set text parameter
    rr.text = 'k=rsa; p=cIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3gOGfa9UXUwN1f5movOSQZ5lUqa2ZkCgSNR4UqSrp6Hysr3B7yJk77Zhd3tJ3GS0padpuQS33EeJfRMNBS+YyNXfTEFHg02+Gs4JH4ZWaZMNQNXeZrPWqVwbzaRjAXw/z18utbiDf9EUoprsJNI6zkj92kdYcta+2Pcpp2qyCUJbXJ2VL1akAcBy1lAfU+s6JdH7uqwOVwgtocVDdqraf00SZ4LjYDXzYw/7oW0+zgzDpFroT+F0wtakN+gx1yovRLETeuuBPBpH9drrNo1r5B6TziUY+l/Roca1kPb7tK75Oa04aU0hvO75+G7mE+XGj0oWHmFTUZA+uZ9GkaGpfwIDAQAB;'
    puts rr.dump
    assert_equal '@ IN TXT ("k=rsa; p=cIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3gOGfa9UXUwN1f5movOSQZ5lUqa2ZkCgSNR4UqSrp6"
			"Hysr3B7yJk77Zhd3tJ3GS0padpuQS33EeJfRMNBS+YyNXfTEFHg02+Gs4JH4ZWaZMNQNXeZrPWqVwbzaRjAXw/z18utbiDf"
			"9EUoprsJNI6zkj92kdYcta+2Pcpp2qyCUJbXJ2VL1akAcBy1lAfU+s6JdH7uqwOVwgtocVDdqraf00SZ4LjYDXzYw/7oW0+"
			"zgzDpFroT+F0wtakN+gx1yovRLETeuuBPBpH9drrNo1r5B6TziUY+l/Roca1kPb7tK75Oa04aU0hvO75+G7mE+XGj0oWHmF"
			"TUZA+uZ9GkaGpfwIDAQAB;")', rr.dump
  end

  def test_load_rr__txt
    rr = DNS::Zone::RR::TXT.new.load('txtrecord IN TXT "test text"')
    assert_equal 'txtrecord', rr.label
    assert_equal 'IN', rr.klass
    assert_equal 'TXT', rr.type
    assert_equal 'test text', rr.text
  end

  def test_load_multiple_quoted_strings
    rr = DNS::Zone::RR::TXT.new.load('txtrecord IN TXT "part1 yo" " part2 yo"')
    assert_equal 'part1 yo part2 yo', rr.text
  end

  def test_load_string_with_quotes
    rr = DNS::Zone::RR::TXT.new.load('txtrecord IN TXT "we have \"double\" quotes"')
    assert_equal %q{we have \"double\" quotes}, rr.text
  end

  def test_load_multiple_strings_with_quotes
    rr = DNS::Zone::RR::TXT.new.load('txtrecord IN TXT "part1 " "we have \"double\" quotes" " part3"')
    assert_equal %q{part1 we have \"double\" quotes part3}, rr.text
  end

end
