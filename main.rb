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
  # p(num5re .my_select { |x| x.even? })
  # p num

  # Task no.4
  def my_all?
    return my_all?.to_enum unless block_given?

    check = true
    if self.class == hash
      my_each do |k, v|
        check = false unless yield(k, v)
      end
    elsif self.class == Regexp
      my_each do |x|
        check = false unless yield(x)
      end
    elsif self.class == Class
      my_each do |y|
        check = false unless yield(y)
      end
    else
      my_each do |z|
        check = false unless yield(z)
      end
    end
    check
  end

  # TEST FOR my_all?
  # p([1, 2, 3, 4, 5].my_all? { |x| x < 6 })

  # Task no.5
  def my_any?
    return my_any?.to_enum unless block_given?

    check = false
    if self.class == hash
      my_each do |k, v|
        check = true if yield(k, v)
      end
    elsif self.class == Regexp
      my_each do |x|
        check = true if yield(x)
      end
    elsif self.class == Class
      my_each do |y|
        check = true if yield(y)
      end
    else
      my_each do |z|
        check = true if yield(z)
      end
    end
    check
  end

  # TEST FOR #my_any?
  # p([1, 2, 3, 4, 5, 6].my_any? { |a| a == 9 })

  # Task no.6
  def my_none?
    return to_enum(:my_none) unless block_given?

    check = true
    if self.class == hash
      my_each do |k, v|
        check = false if yield(k, v)
      end
    elsif self.class == Regexp
      my_each do |x|
        check = false if yield(x)
      end
    elsif self.class == Class
      my_each do |y|
        check = false if yield(y)
      end
    else
      my_each do |z|
        check = false if yield(z)
      end
    end
    check
  end

  # TEST my_none
  # p([1, 2, 3, 4, 5].my_none? { |x| x.is_a?(Integer) })
  # p([1, 2, 3, 4, 5].my_none? { |x| x == 9 })

  # Task no.7
  def my_count
    return to_enum(:my_count) unless block_given?

    count = 0
    if self.class == Hash
      my_each do |k, v|
        count += 1 if yield(k, v)
      end
    else
      my_each do |x|
        count += 1 if yield(x)
      end
    end
    count
  end

  # TEST my_count
  # strings = ["one", "two", "three", "four"]
  # p strings.my_count { |x| x }

  # Task no.8 (This iteration takes a block)
  def my_map_first
    arr = []
    if self.class == Hash && block_given?
      my_each do |k, v|
        arr << yield(k, v)
      end
    elsif self.class == Array && block_given?
      my_each do |x|
        arr << yield(x)
      end
    else
      return to_enum(:my_map_first)
    end
    arr
  end

  # TEST my_map_first
  # p(%w[11 21 5 23 19].my_map_first { |str| str &.to_i })

  # Task no.9
  def my_inject(init = nil, symbol = nil)
    if !init.nil? && !symbol.nil?
      my_each { |num| init = init.method(symbol).call(num) }
      init
    elsif !init.nil? && init.is_a?(Symbol) && !symbol.nil?
      memo, *remaining_ele = self
      remaining_ele.my_each { |num| memo = memo.method(init).call(num) }
      memo
    elsif !init.nil? && init.is_a?(Integer) && symbol.nil?
      my_each { |num| init = yield(init, num) }
      init
    elsif init.nil? && symbol.nil?
      init, *remaining_ele = self
      remaining_ele.my_each { |num| init = yield(init, num) }
      init
    end
  end

  # TESTS FOR
  # my_inject
  # p [2, 4, 5].my_inject(1, :+)
  # p [2, 4, 5].my_inject(:*)
  # p [2, 4, 5].my_inject(2) { |memo, n| memo + n }
  # p [2, 4, 5].my_inject { |memo, n| memo + n }

  # Task no.11 & 12 (Takes a PROC)
  def my_map_second
    arr = []
    if self.class == Hash && block_given?
      my_each do |k, v|
        arr << yield(k, v)
      end
    elsif self.class == Array && block_given?
      my_each do |x|
        arr << yield(x)
      end
    else
      return to_enum(:my_map_first)
    end
    arr
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
