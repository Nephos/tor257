#!/usr/bin/env elixir

use Bitwise

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

  def keys(k, offsets) do
    {
      rol8(k, elem(offsets, 0) + 0),
      rol8(k, elem(offsets, 1) + 2),
      rol8(k, elem(offsets, 2) + 5),
      rol8(k, elem(offsets, 3) + 7),
    }
  end

  def key(k, offsets) do
    Enum.reduce(Tuple.to_list(keys(k, offsets)), 0, &bxor/2)
  end

  def execute(b, k, offsets) do
    k = key(k, offsets)
    b ^^^ k
  end

	def subkeys(k, i, ksize) do
		subkeys(k, [], i, 0, 0, ksize)
	end

	def subkeys(key, subkey, idx, used, offset, ksize) when used >= ksize do
		subkey
	end

	def subkeys(key, subkey, idx, used, offset, ksize) do
		new_offset = case {offset} do
			{0} -> 2
			{3} -> 2
			{2} -> 3
		end
		current = [elem(key, (rem idx, ksize))]
		IO.puts("Current: #{subkey}, #{current}, #{idx}")
		subkeys(key, subkey ++ current, idx + offset, used + offset, new_offset, ksize)
	end
end

Enum.map(Enum.with_index(m), fn char_with_index ->
  idx = elem char_with_index, 1
  char = elem char_with_index, 0
  kbyte = elem k, (rem idx, k_size)
  # TODO: finish implementation with bloc rotations etc.
  offsets = {0, 2, 5, 7}
  encrypted = Tor257.execute(char, kbyte, offsets)
  # TODO: remove debug
  IO.puts "#{idx} => #{char} xor #{kbyte} = #{encrypted}"
end)

klist = Tuple.to_list(k)
Enum.map(Enum.with_index(klist), fn char_with_index ->
  idx = elem char_with_index, 1
  char = elem char_with_index, 0
	sk = Tor257.subkeys(k, idx, Enum.count(klist))
	IO.puts "Key: create subkey #{idx}: #{sk}"
end)
