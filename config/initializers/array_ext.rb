class Array

  def non_dub
    self.inject({}) do |res, el|
      res[el] ||= 0
      res[el] += 1
      res
    end.delete_if{|k, v| v > 1}.keys
  end

  #NOTE: the complexity is 0(n), not sure could I decrease it, need investigation more.
end