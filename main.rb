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

end
