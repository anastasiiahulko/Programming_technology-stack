class PlasticineFigure
  attr_accessor  :name, :emothion, :face

  def initialize(name, emothion, face)
    @name = name
    @emothion = emothion
    @face = face
  end

  def clone
    copy = super
    copy
  end

  def display_figure
    puts "  /\\_/\\  "
    puts " ( #{@face} ) " 
    puts "  > ^ <  "
    info
  end

  def info
    puts "Привіт, я #{@emothion} #{@name}"
  end
end

original_figure = PlasticineFigure.new("Барсик", "здивований", "o.o")
original_figure.display_figure 

clone1_from_original_figure = original_figure.clone
clone1_from_original_figure.display_figure 

clone2_from_clone_1_with_changes = clone1_from_original_figure.clone
clone2_from_clone_1_with_changes.face = "-.-" 
clone2_from_clone_1_with_changes.name = "Соня"
clone2_from_clone_1_with_changes.emothion = "сонний"
clone2_from_clone_1_with_changes.display_figure 

clone3_from_clone_1 = clone1_from_original_figure.clone
clone3_from_clone_1.display_figure 

if original_figure.face == clone1_from_original_figure.face
  puts 'Примітивні значення полів з оригінальної фігури "original_figure" були перенесені в клон "clone1".'
else
  puts 'Примітивні значення полів з оригінальної фігури "original_figure" -НЕ- були перенесені в клон "clone1".'
end

if original_figure.face == clone2_from_clone_1_with_changes.face
  puts 'Примітивні значення полів з оригінальної фігури "original_figure" були перенесені та -НЕ- змінені в клон "clone2".'
else
  puts 'Примітивні значення полів з оригінальної фігури "original_figure" були перенесені та змінені в клон "clone2".'
end

if clone1_from_original_figure.face == clone2_from_clone_1_with_changes.face
  puts 'Примітивні значення полів з оригінальної фігури "clone1" були перенесені в клон "clone2".'
else
  puts 'Примітивні значення полів з оригінальної фігури "clone1" -НЕ- були перенесені в клон "clone2".'
end

if clone1_from_original_figure.face == clone3_from_clone_1.face
  puts 'Примітивні значення полів з оригінальної фігури "clone1" були перенесені в клон "clone3".'
else
  puts 'Примітивні значення полів з оригінальної фігури "clone1" НЕ були перенесені в клон "clone3".'
end

