module Support::Randomizer
  def self.string(length)
    (0...length).map{ ('a'..'z').to_a[Kernel.rand(26)] }.join
  end

  def self.integer(length)
    (0...length).map{ ('1'..'9').to_a[Kernel.rand(9)] }.join.to_i #no zeroes because it messes up the length
  end

  def self.boolean
    [true, false].sample
  end

  def self.array(array)
		array.sample
  end

  def self.password(length)
    Digest::SHA1.hexdigest(self.string(length))
  end
end
