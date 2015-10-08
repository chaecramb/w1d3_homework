@students = %w(Iwona Craig GraemeK Kathryn Kieran Peter Ere Chae Zsolt Simon Syed Neil GraemeS Keith Nevin)

def get_integer
  integer = Integer(gets) rescue nil
  if integer.is_a?(Fixnum) 
    integer 
  else 
    print "Please enter a number: "
    get_integer
  end
end

def get_abc
  reply = gets.chomp.downcase
  if (reply == "a" || reply == "b" || reply == "c") 
    reply 
  else 
    print "Please enter \"a\", \"b\" or \"c\": "
    get_abc
  end
end

def number_of_groups(size)
  (@students.length / size.to_f).ceil
end

def reassign_groups(groups)
    groups_list = []
    groups.times do
      groups_list << []
    end
    n = 0
    @students.each do |student|
      if n < groups_list.size
        groups_list[n] << student
      else
        n = 0
        groups_list[n] << student
      end
      n += 1
    end
    groups_list
end

def split_students(groups, size)
  shuffled_students = @students.shuffle
  group_list = []
  (1..groups).each do |n|
    group_list << shuffled_students.shift(size)
  end
  if group_list.last.size < (group_list.first.size*(2.0/3))
    puts "With groups of #{size} you will have #{groups} groups, but the last group will only have #{group_list.last.size} members. Are you sure you want #{groups} groups?"
    puts "Enter (a) to stick to #{groups} groups."
    puts "Enter (b) to divide the students between #{groups - 1} groups."
    puts "Enter (c) to divide the students between #{groups + 1} groups."
    case get_abc
    when "a" then group_list
    when "b" then group_list = reassign_groups(groups - 1)
    when "c" then group_list = reassign_groups(groups + 1)
    end
  end  
  group_list
end

def create_groups
  print "What size of groups would you like? "
  size = get_integer
  groups = number_of_groups(size)
  group_list = split_students(groups, size)
  (1..group_list.length).each do |g|
    puts "Group #{g}: #{group_list[g-1].join(", ")}"
  end
end

create_groups

