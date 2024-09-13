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