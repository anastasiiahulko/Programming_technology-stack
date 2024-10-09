def valid_ipv4?(ip)
  parts = ip.split('.')

  return false unless parts.length == 4

  parts.all? { |part| part.match?(/\A\d+\z/) && part.to_i.between?(0, 255) }
end

puts valid_ipv4?('192.168.1.1') # true
puts valid_ipv4?('10.0.0.256')  # false
puts valid_ipv4?('127.0.0.1')   # true
puts valid_ipv4?('0.0.0.0')     # true
puts valid_ipv4?('255.255.255.255') # true
puts valid_ipv4?('192.168.01.1')   # false (з ведучими нулями)
