# frozen_string_literal: true

class C
  def self.test
    B.test
    A.test
  end
end

C.test
