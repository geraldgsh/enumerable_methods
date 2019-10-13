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

end
