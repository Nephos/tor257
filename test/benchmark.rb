require_relative '../lib/tor257'
require 'benchmark'

SIZES = [1, 10, 20, 50, 100]
MUL = 1_000
STRINGS = SIZES.map do |i|
  Tor257::Message.new("*" * (MUL * i))
end

KEY_SIZES = [128, 256, 512]

KEY_SIZES.each do |key_size|

  puts "====== TEST FOR #{key_size} bits KEY ====="
  key_string = "$" * (key_size / 8)
  key = Tor257::Key.new(key_string)

  print "\t "
  Benchmark.bm do |x|
    STRINGS.each do |input|
      print input.size, "\tBytes"
      x.report { input.encrypt(key) }
    end
  end

  puts
end
