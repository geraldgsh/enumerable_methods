# frozen_string_literal: true

module Enumerable
  # Task no.1
  def my_each
    i = 0
    while self[i]
      yield(self[i])
      i += 1
    end
    self
  end

  # # TEST FOR #my_each
  # [1,2,3,4].my_each do |x|
  #   puts "#{x}"
  # end

  # Task no.2
  def my_each_with_index
    i = 0
    while self[i]
      yield(self[i], i)
      i += 1
    end
    self
  end

  # TEST FOR #my_each_with_index
  # [1, 2, 3, 4].my_each_with_index do |x, i|
  #   puts "#{i}. #{x}"
  # end

  # Task no.3
  def my_select
    new_array = []
    my_each do |i|
      new_array << i if yield(i)
    end
    new_array
  end

  # TEST FOR my_select
  # num = [1, 2, 3, 4, 5, 6, 7, 8]
  # p num.my_select { |x| x.even? }
  # p num

  # Task no.4
  def my_all?
    my_each do |i|
      return false if yield(self[i]) == false || yield(self[i]).nil?
    end
    true
  end

  # TEST FOR my_all?
  # num = [1, 2, 3, 4, 5]
  # p num.my_all? { |x| x > 6}

  # Task no.5
  def my_any?
    my_each do |f|
      return true if yield(f)
    end
    false
  end

  # TEST FOR #my_any?
  # num = [1, 2, 3, 4, 5, 6]
  # p num.my_any? { |x| x == 2 }

  # Task no.6
  def my_none?
    i = 0
    while self[i]
      return false if yield(self[i])
      i += 1
    end
    true
  end

  # TEST my_none
  # numbers = [1, 2, 3, 4, 5]
  # p numbers.my_none? {|x| x.is_a?(String) }
  # p numbers.my_none? {|x| x == 1 }

end
