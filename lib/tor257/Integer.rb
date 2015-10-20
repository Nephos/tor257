class Integer

  def ror count, size=32
    count = count % size
    ((self >> count) | (self << (size - count))) & (2**size-1)
  end

end
