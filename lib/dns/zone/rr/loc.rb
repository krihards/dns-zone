# `LOC` resource record.
#
class DNS::Zone::RR::LOC < DNS::Zone::RR::Record

    REGEX_LOC_RDATA = %r{
    (?<lat_degrees>\d+)\s*
    (?<lat_minutes>\d+)\s*
    (?<lat_seconds>\d+\.\d+)\s*
    (?<lat_direction>[N|S])\s*
    (?<long_degrees>\d+)\s*
    (?<long_minutes>\d+)\s*
    (?<long_seconds>\d+\.\d+)\s*
    (?<long_direction>[E|W])\s*
    (?<altitude>-?(\d+\.\d+|\d+|\.\d+)m)\s*
    (?<size>(\d+\.\d+|\d+|\.\d+)m)?\s*
    (?<precision_horz>(\d+\.\d+|\d+|\.\d+)m)?\s*
    (?<precision_vert>(\d+\.\d+|\d+|\.\d+)m)?\s*
  }mx

  attr_accessor :lat_degrees, :lat_minutes, :lat_seconds, :lat_direction, :long_degrees, :long_minutes, :long_seconds, :long_direction, :altitude, :size, :precision_horz, :precision_vert

  def dump
    parts = general_prefix
    parts << lat_degrees
    parts << lat_minutes
    parts << lat_seconds
    parts << lat_direction
    parts << long_degrees
    parts << long_minutes
    parts << long_seconds
    parts << long_direction
    parts << altitude
    parts << size
    parts << precision_horz
    parts << precision_vert

    parts.join(' ')
  end

  def load(string, options = {})
    rdata = load_general_and_get_rdata(string, options)
    return nil unless rdata

    captures = rdata.match(REGEX_LOC_RDATA)
    return nil unless captures

    @lat_degrees = captures[:lat_degrees].to_i
    @lat_minutes = captures[:lat_minutes].to_i
    @lat_seconds = captures[:lat_seconds]
    @lat_direction = captures[:lat_direction]
    @long_degrees = captures[:long_degrees].to_i
    @long_minutes = captures[:long_minutes].to_i
    @long_seconds = captures[:long_seconds]
    @long_direction = captures[:long_direction]
    @altitude = captures[:altitude]
    @size = captures[:size]
    @precision_horz = captures[:precision_horz]
    @precision_vert = captures[:precision_vert]
    self
  end

end
