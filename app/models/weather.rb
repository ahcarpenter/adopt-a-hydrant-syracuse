class Weather
  
  def get_snow_cover(lat, lng)
    nodes = LibXML::XML::Reader.string(Net::HTTP.get(URI('http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?lat=' + lat.to_s + '&lon=' + lng.to_s + '&product=time-series&begin=' + DateTime.now.utc.new_offset(0).to_s + '&end=' + DateTime.now.utc.new_offset(0).to_s + '&snow=snow')))
    snow_amounts = Array.new

    while nodes.read
      unless nodes.node_type == LibXML::XML::Reader::TYPE_END_ELEMENT
        if nodes.name == 'value'
          nodes.read
          snow_amounts.push nodes.value
        end
      end
    end
    
    nodes.close
    return snow_amounts.sort.last.to_i
  end
end