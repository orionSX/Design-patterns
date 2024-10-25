def two_smallest_indexes(arr)
    min1, min2 = arr.min(2)
    idx1 = arr.index(min1)
    idx2 = arr.index(min2)
    yield([idx1, idx2])
end
  
def missing_numbers(arr)
    range=(arr.min..arr.max).to_a
    yield(range-arr)
end

def main
    puts "Выберите задачу:"
    puts "1. Найти индексы двух наименьших элементов массива."
    puts "2. Найти пропущенные элементы в массиве."
  
    choice = gets.to_i
    puts "Введите массив чисел через пробел:"
    array = gets.chomp.split.map{|el| el.to_i}   
  
    case choice
    when 1
        two_smallest_indexes(array) { |result| puts "Индексы двух наименьших элементов: #{result}" }
    when 2
        missing_numbers(array) { |result| puts "Пропущенные элементы: #{result}" }
    else
      puts "Некорректный выбор."
    end
end

main