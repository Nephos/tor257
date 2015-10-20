# coding: utf-8

def TOR257_KEYS(k)
  [
    ((k << 0) & 0xff) + ((k & 0b00000000) >> 8),
    ((k << 2) & 0xff) + ((k & 0b11000000) >> 6),
    ((k << 5) & 0xff) + ((k & 0b11111000) >> 3),
    ((k << 7) & 0xff) + ((k & 0b11111110) >> 1)
  ]
end

def TOR257_KEY(k)
  TOR257_KEYS(k).inject(&:^)
end

# @param b [Integer 8b]
# @param k [Integer 8b]
def TOR257(b, k)
  return b ^ TOR257_KEY(k)
end

module Tor257

  class Key < String

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

  class Message < String

    def encrypt(key)
      raise ArgumentError unless key.is_a? Key
      i = 0
      out = Message.new(self.bytes.map do |b|
                          skey = key.subkey(i)
                          skey.each{|k| b = TOR257(b, k) }
                          i += 1
                          b.chr
                        end.join)
      out
    end

    def decrypt(key)
      self.encrypt(key)
    end

  end

end
