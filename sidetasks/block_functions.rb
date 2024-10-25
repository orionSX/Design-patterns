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

def loc_max_count(arr)
    if arr.size<3 
        yield(0)
        return
    end  
    local_maxima = arr.each_with_index.select do |num, idx|
      (idx > 0 && idx < arr.size - 1) && (arr[idx] > arr[idx - 1] && arr[idx] > arr[idx + 1])
    end
    yield(local_maxima.size)
end



def alternating_real_int?(arr) 
    if arr.size==0 
        yield(false)
        return
    end  
    normalized_ar=arr.map do |el| 
        el.to_s.split('.')[1]=='0'? el.to_i : el
    end  
    ans = normalized_ar.each_cons(2).all? { |a, b| a.is_a?(Integer) != b.is_a?(Integer) }
    yield(ans)
  end


def is_prime?(n)
    if n<=1 then return false end
    (2...n).each do |el|
        if n%el ==0  then return false end
    end
    return true
end


def srar_not_prime_gt_srar_prime(arr)
    not_primes=arr.select { |el| !is_prime?(el)}
    primes = arr - not_primes
    begin
        srar_primes=primes.sum / primes.size 
        
        ans= not_primes.select {|el| el>srar_primes}
        srar_ans=ans.sum/ans.size 
    rescue ZeroDivisionError
        yield(-999)
    else
        yield(srar_ans)
    end
end
def main
  
  
    puts "Выберите задачу:"
    puts "8. Найти индексы двух наименьших элементов массива."
    puts "20. Найти пропущенные элементы в массиве."
    puts "32. Найти кол-во локальных максимумов."
    puts "44. Проверить, чередуются ли R и N числа."
    puts "56. Среднее арифм. составных элементов, которые больше чем среднее арифм. простых элементов"
    choice = gets.to_i
    puts "Введите массив чисел через пробел:"
   
    if choice != 20
        array = gets.chomp.split.map{|el| el.to_f}    
    else
        array = gets.chomp.split.map{|el| el.to_i} 
    end
    case choice
    when 8
        two_smallest_indexes(array) { |result| puts "Индексы двух наименьших элементов: #{result}" }
    when 20
        missing_numbers(array) { |result| puts "Пропущенные элементы: #{result}" }
    when 32
        loc_max_count(array) { |result| puts "Число локальных максимумов: #{result}" }
    when 44
        alternating_real_int?(array) { |result| puts "Чередуются ли вещественные и натуральные? #{result}" }
    when 56
        srar_not_prime_gt_srar_prime(array) { |result| puts "Среднее арифм. составных элементов, которые больше чем среднее арифм. простых элементов: #{result}" }
    else
      puts "Некорректный выбор."
    end
end

main