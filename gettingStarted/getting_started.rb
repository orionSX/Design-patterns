puts "Hello World!"

user_name=ARGV[0]

puts "Hello, #{user_name.capitalize}!\nWhat is your favourite programming language?"

favourite_language=STDIN.gets.chomp.downcase

case favourite_language
when "ruby"
	puts "You're such a suck-up eww\n"
when "python"
	puts "Haha noob choice\n"
when "fortran"
	puts "G-grandpa?.. H-how...\n"
when "javascript"
	puts "Yep, almost fell for that one ;)\n"
else
	puts "Never heard about that one 0_0\n"
end
puts "Whatever, soon it'll be Ruby anyways"

puts "\nEnter rubby command:"
ruby_command = STDIN.gets.chomp
puts "\nEnter OS command:"
os_command = STDIN.gets.chomp

puts "Result of Ruby command :"
puts eval(ruby_command)
if system(os_command)
	puts "OS command executed"
else
	puts "Something went wrong"
end

#euclid's algorythm for greatest divisor, if its 1 they're coprime
def euclid(x,y)
	while y!=0
		x,y = y,x%y
	end
	x
end

#going from 1 to n not included and counting if greatest divisor is 1
def coprimes_amount(n)
	counter=0
	(1...n).each {|number| counter+=1 if euclid(number,n)==1}	
	counter
end


def sum_of_digits_divided_by_3(n)
	sum=0
	n.to_s.chars.each {|char| sum+=char.to_i if char.to_i%3==0}
	sum
end

#going through all divisors, per iteration counting amount of digits with divisor coprimed which
#but it makes no sense because it will always return 1, so we probably should be asked about divisors
#different from 1 but solution wouldnt differ too much, we'd have to check if there's none of the
#divisors we're looking for
def divisor_coprimed_with_max_digits_amount(n)
	divisors = (1..n).select {|number| n%number ==0}
	
	digits=n.to_s.chars.map{ |char| char.to_i }
	
	longest_count=0
	best_divisor=0
	
	divisors.each do |div|
		coprimed_count = digits.count {|digit| euclid(digit,div)==1}
		if coprimed_count > longest_count
			longest_count = coprimed_count
			best_divisor=div
		end
	end
	
	best_divisor

end

puts "Enter the number you want to test methods on:"
entered_number=STDIN.gets.chomp.to_i

puts "Amount of numbers less than #{entered_number} and coprimed with it is #{coprimes_amount(entered_number)}"
puts "Summ of digits which are divided by 3 is #{sum_of_digits_divided_by_3(entered_number)}"
puts "Divisor which is coprimed with the most of amount of digits is #{divisor_coprimed_with_max_digits_amount(entered_number)}"


def min_element_for(arr)
  min = arr[0] 
  for i in 1...arr.size
    min = arr[i] if arr[i] < min
  end
  min
end


def first_positive_element_index_for(arr)
  index = nil
  for i in 0...arr.size
    if arr[i] > 0
      index = i
      break
    end
  end
  index
end

def min_element_while(arr)
  min = arr[0]
  i = 1
  while i < arr.size
    min = arr[i] if arr[i] < min
    i += 1
  end
  min
end


def first_positive_element_index_while(arr)
  index = nil
  i = 0
  while i < arr.size
    if arr[i] > 0
      index = i
      break
    end
    i += 1
  end
  index
end

puts "Enter array:"

array=STDIN.gets.chomp.split.map {|el| el.to_i}


puts "Min element (for): #{min_element_for(array)}"
puts "Min element (while): #{min_element_while(array)}"


puts first_positive_element_index_for(array).nil? ? "There's no positive elements in array":"Index of first positive element is #{first_positive_element_index_for(array)}"
puts first_positive_element_index_while(array).nil? ? "There's no positive elements in array":"Index of first positive element is #{first_positive_element_index_while(array)}"

