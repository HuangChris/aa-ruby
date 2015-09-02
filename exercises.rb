class Employee
  attr_reader :name, :title, :salary, :boss
  def initialize(name,title,salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
    unless @boss.nil?
      @boss.children << self
    end
  end

  def bonus(multiplier)
    salary * multiplier
  end

  def sub_salaries
    salary
  end


end

class Manager < Employee
  attr_reader :children

  def initialize(name,title,salary, boss)
    super(name,title,salary, boss)
    @children = []
  end

  def bonus(multiplier)
    bonus = multiplier * (sub_salaries - salary)
  end

  def sub_salaries

    return salary if children.empty?
    # puts "salary:#{@salary}"
    # children.each do |child|
    #   sum += child.sub_salaries
    a = children.inject(salary) do |sum, child|
      # puts "#{child} \=\> #{sum}"
      sum + child.sub_salaries
    end
    #finds all sub_employees + self, sums their salaries
  end

end

ned = Manager.new("Ned","Founder",1000000,nil)
darren = Manager.new("Darren","TA Manager",78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David","TA",10000,darren)

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
