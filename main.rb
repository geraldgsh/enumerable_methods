# frozen_string_literal: true

# Task no.1
module Enumerable # rubocop:disable Metrics/ModuleLength
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
  # rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif arg == Hash
      my_each { |k, v| return false unless yield(k, v) }
    elsif arg.class == Class
      my_each { |w| return false unless yield(w) }
    elsif arg.class == Regexp
      my_each { |x| return false unless x =~ arg }
    elsif arg.nil?
      my_each { |y| return false unless y }
    else
      my_each { |z| return false unless z == arg }
    end
    true
  end

  # TEST FOR my_all?
  # p([1, 2, 3, 4, 5].my_all? { |x| x < 6 })

  # Task no.5
  def my_any?(arg = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif arg == Hash
      my_each { |k, v| return true if yield(k, v) }
    elsif arg.class == Class
      my_each { |w| return true if yield(w) }
    elsif arg.class == Regexp
      my_each { |x| return true if x =~ arg }
    elsif arg.nil?
      my_each { |y| return true if y }
    else
      my_each { |z| return true if z == arg }
    end
    false
  end

  # TEST FOR #my_any?
  # p([1, 2, 3, 4, 5, 6].my_any? { |a| a == 1 })

  # Task no.6
  def my_none?(arg = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif arg == Hash
      my_each { |k, v| return false if yield(k, v) }
    elsif arg.class == Class
      my_each { |w| return false if yield(w) }
    elsif arg.class == Regexp
      my_each { |x| return false if x =~ arg }
    elsif arg.nil?
      my_each { |y| return false if y }
    else
      my_each { |z| return false if z == arg }
    end
    true
  end

  # rubocop:enable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  # TEST my_none
  # p([1, 2, 3, 4, 5].my_none? { |x| x.is_a?(String) })
  # p([1, 2, 3, 4, 5].my_none? { |x| x == 9 })

  # Task no.7
  def my_count(ele = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) }
    elsif ele.nil?
      my_each { count += 1 }
    else
      my_each { count += 1 if i == arg }
    end
    count
  end

  # TEST my_count
  # p(%w[one two three four five].my_count { |x| x })

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
  # rubocop:disable  Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
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

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
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
