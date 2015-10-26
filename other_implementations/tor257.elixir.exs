#!/usr/bin/env elixir

use Bitwise

defmodule Tor257 do
  def rol8(b, nb_bits) do
    high = b <<< (rem(nb_bits, 8))
    low = b >>> (8 - nb_bits)
    (high ||| low ) &&& 0xFF
  end

  def ror8(b, nb_bits) do
    high = b >>> (rem(nb_bits, 8))
    low = b <<< (8 - nb_bits)
    (high ||| low ) &&& 0xFF
  end

  defmodule Key do

    def encrypt(b, k, offsets) do
      k = rotate_key(k, offsets)
      b ^^^ k
    end

    def rotate_keys(k, offsets) do
    {
      Tor257.rol8(k, elem(offsets, 0) + 0),
      Tor257.rol8(k, elem(offsets, 1) + 2),
      Tor257.rol8(k, elem(offsets, 2) + 5),
      Tor257.rol8(k, elem(offsets, 3) + 7),
    }
    end

    def rotate_key(k, offsets) do
      Enum.reduce(Tuple.to_list(rotate_keys(k, offsets)), 0, &bxor/2)
    end
    def subkeys(k, i, ksize) do
      subkeys(k, [], i, 0, 0, ksize)
    end

    #def subkeys(key, subkey, idx, used, offset, ksize) when used >= ksize do
    def subkeys(_, subkey, _, used, _, ksize) when used >= ksize do
    	subkey
    end
    def subkeys(key, subkey, idx, used, offset, ksize) do
      new_offset = case {offset} do
        {0} -> 2
    	{3} -> 2
    	{2} -> 3
      end
      current = [elem(key, (rem idx, ksize))]
      subkeys(key, subkey ++ current, idx + offset, used + offset, new_offset, ksize)
    end
  end

end

# TODO: read with -p and -k
k = hd System.argv
# TODO: read by 4096 on stdin
m = hd tl System.argv

# TODO: rm debug message
IO.puts "Message: #{m}"
IO.puts "Key    : #{k}"

# TODO: check for performances
# Check for the useful type to use (to avoid heavy cast)
k = String.to_char_list k
k_size = Enum.count k
k = List.to_tuple k
m = String.to_char_list m

klist = Tuple.to_list(k)
subkeys = Enum.map(Enum.with_index(klist), fn char_with_index ->
  idx = elem char_with_index, 1
  #char = elem char_with_index, 0
  sk = Tor257.Key.subkeys(k, idx, Enum.count(klist))
  IO.puts "Key: create subkey #{idx}: #{sk}"
  #List.to_tuple(sk)
  sk
end)

t_subkeys = List.to_tuple(subkeys)

offsets = {0, 2, 5, 7}
Enum.map(Enum.with_index(m), fn char_with_index ->
  idx = elem(char_with_index, 1)
  char = elem(char_with_index, 0)
  # TODO: use the bloc rotation to get the right kbyte
  #kbyte = elem k, (rem idx, k_size)
  current_subkeys = elem(t_subkeys, (rem idx, k_size))
  # TODO: finish implementation with bloc rotations etc.
  kbytes = Enum.map(current_subkeys, fn subkey -> Tor257.Key.rotate_key(subkey, offsets) end)
  kbyte = Enum.reduce(kbytes, 0, &bxor/2)
  encrypted = Tor257.Key.encrypt(char, kbyte, offsets)
  # TODO: remove debug
  IO.puts "#{idx} => #{char} xor #{kbyte} = #{<<encrypted :: utf8>>}"
end)
