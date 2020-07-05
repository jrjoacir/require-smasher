# frozen_string_literal: true

class B
  def self.test
    A.test
  end
end

B.test
