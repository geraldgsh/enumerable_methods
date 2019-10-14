# frozen_string_literal: true

module Enumerable
  # Task no.1
  def my_each
    if block_given?
      i = 0
      while self[i]
        yield(self[i])
        i += 1
      end
      self
    else
      to_enum(:my_each)
    end
  end

  # # TEST FOR #my_each
  # [1, 2, 3, 4].my_each do |x|
  #   puts "#{x}"
  # end

  # Task no.2
  def my_each_with_index
    if block_given?
      i = 0
      while self[i]
        yield(self[i], i)
        i += 1
      end
      self
    else
      to_enum(:my_each_with_index)
    end
  end

  # TEST FOR #my_each_with_index
  # [1, 2, 3, 4].my_each_with_index do |x, i|
  #   puts "#{i}. #{x}"
  # end

  # Task no.3
  def my_select
    if block_given?
      new_array = []
      my_each do |i|
        new_array << i if yield(i)
      end
      new_array
    else
      to_enum(:my_select)
    end
  end

  # TEST FOR my_select
  # num = [1, 2, 3, 4, 5, 6, 7, 8]
  # p num.my_select { |x| x.even? }
  # p num

  # Task no.4
  def my_all?
    if block_given?
      my_each do |i|
        return false if yield(self[i]) == false || yield(self[i]).nil?
      end
      true
    else
      to_enum(:my_all?)
    end
  end

  # TEST FOR my_all?
  # num = [1, 2, 3, 4, 5]
  # p num.my_all? { |x| x > 6}

  # Task no.5
  def my_any?
    if block_given?
      my_each do |f|
        return true if yield(f)
      end
      false
    else
      to_enum(:my_any?)
    end
  end

  # TEST FOR #my_any?
  # num = [1, 2, 3, 4, 5, 6]
  # p num.my_any? { |x| x == 2 }

  # Task no.6
  def my_none?
    if block_given?
      i = 0
      while self[i]
        return false if yield(self[i])

        i += 1
      end
      true
    else
      to_enum(:my_none?)
    end
  end

  # TEST my_none
  # numbers = [1, 2, 3, 4, 5]
  # p numbers.my_none? {|x| x.is_a?(String) }
  # p numbers.my_none? {|x| x == 1 }

  # Task no.7
  def my_count
    count = 0
    my_each do |i|
      count += 1
      return count if block_given? && yield(self[i])

      to_enum(:my_each)
    end
    count
  end

  # TEST my_count
  # p ["one", "two", "three", "four", "five"].my_count

  # Task no.8 (This iteration takes a block)
  def my_map_first
    if block_given?
      arr = []
      my_each do |i|
        arr << yield(i)
      end
      arr
    else
      to_enum(:my_map_first)
    end
  end

  # TEST my_map_first
  # p ["11", "21", "5", "23", "19"].my_map_first { |str| str.to_i }

  # Task no.9

  def my_inject(_initial = nil)
    mem = initial
    my_each do |e|
      mem = if mem.nil?
              e
            else
              yield(mem, e)
            end
    end
    mem
  end

  # Task no.11 & 12 (Takes a PROC)
  def my_map_second
    if block_given?
      arr = []
      my_each do |i|
        arr << yield(i)
      end
      arr
    else
      to_enum(:my_map_second)
    end
  end

  # TEST my_map_second
  # my_proc = proc { |x| x * 3 }
  # p [1, 2, 3, 4, 5].my_map_second(&my_proc)
end

# Task no.10
def multiply_els(arr)
  arr.my_inject { |sum, x| sum * x }
end

# TEST multiply_els
# p multiply_els([2, 4, 5])
