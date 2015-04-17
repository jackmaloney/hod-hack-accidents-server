require 'exifr'

puts EXIFR::JPEG.new("../uploaded_images/IMAG0392.jpg").gps.longitude.inspect
