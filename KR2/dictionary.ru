class Dictionary
  attr_accessor :data

  def initialize(data = {})
    @data = data
  end

  def +(other)
    combined_data = @data.merge(other.data)
    Dictionary.new(combined_data)
  end
end

dict1 = Dictionary.new({'apple' => 'яблуко', 'book' => 'книга'})
dict2 = Dictionary.new({'car' => 'автомобіль', 'book' => 'книжка'})

dict3 = dict1 + dict2
puts dict3.data
# Виведе: {"apple"=>"яблуко", "book"=>"книжка", "car"=>"автомобіль"}
