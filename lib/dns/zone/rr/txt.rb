# `A` resource record.
#
# RFC 1035
class DNS::Zone::RR::TXT < DNS::Zone::RR::Record

  attr_accessor :text

  def dump
    parts = general_prefix
    chunks = chunk(text, 95)
    txt_value = ''
    size = chunks.size
    chunks.each_with_index do |chunk, index|
      txt_value << "\t\t\t" unless index == 0
      txt_value << %Q{"#{chunk}"}
      txt_value << "\n" unless index == size - 1
    end
    parts << "(#{txt_value})"
    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata
    # extract text from within quotes; allow multiple quoted strings; ignore escaped quotes
    @text = rdata.scan(/"#{DNS::Zone::RR::REGEX_STRING}"/).join
    self
  end

  def chunk(string, size)
    string.scan(/.{1,#{size}}/)
  end

end
