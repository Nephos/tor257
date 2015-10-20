# coding: utf-8

require_relative 'Integer'

def TOR257_KEYS(k, offsets)
  [
    k.ror(0 - offsets[0], 8),
    k.ror(-2 - offsets[1], 8),
    k.ror(-5 - offsets[2], 8),
    k.ror(-7 - offsets[3], 8),
  ]
end

def TOR257_KEY(k, offsets)
  TOR257_KEYS(k, offsets).inject(&:^)
end

# @param b [Integer 8b]
# @param k [Integer 8b]
def TOR257(b, k, offsets)
  return b ^ TOR257_KEY(k, offsets)
end

module Tor257

  class Key < String

    def initialize s
      super(s)
      raise ArgumentError, "Key must be at least 32 bits strong" if size() < 4
    end

    def subkey(i)
      # return self[i % self.size].bytes
      @koff = nil
      _subkey(i % self.size)
    end

    private
    def _subkey(i)
      raise ArgumentError unless i.is_a? Integer
      koff_update
      if i >= self.size
        @koff = nil
        return []
      end
      i += @koff
      return [self.bytes[i % self.size]] + _subkey(i)
      # return self.bytes[i % self.size]
    end

    def koff_update
      case @koff
      when nil
        @koff = 0
      when 0, 5
        @koff = 2
      when 2
        @koff = 5
      end
    end

  end

  # The message can be cut in 32 bits blocs
  class Message < String

    def encrypt(key)
      raise ArgumentError unless key.is_a? Key
      i = 0
      rotate_matrix = [1, 2, 4, 8]
      out = self.bytes.map do |b|
        skey = key.subkey(i)
        STDERR.write "[#{b}]\t+ [#{skey}\t>> #{rotate_matrix}]\t-> " if $verbose
        skey.each_with_index do |k|
          b = TOR257(b, k, rotate_matrix)
        end
        STDERR.write " [#{b}]\n" if $verbose
        i += 1
        rotate_matrix.rotate! 1 if i % 4 == 0 # bloc of 32
        b.chr
      end.join
      out = Message.new(out)
      out
    end

    def decrypt(key)
      self.encrypt(key)
    end

  end

end
