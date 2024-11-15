require 'minitest/autorun'
require_relative 'my_arr_processor.rb'
class MyArrayProcessorTest < Minitest::Test
  def setup
    @array_processor = MyArrayProcessor.new(array: [1, 2, 3, 4, 5])
  end

  def test_elements
    assert_equal [1, 2, 3, 4, 5], @array_processor.array
  end

  def test_each_slice
    result = []
    @array_processor.each_slice(2) { |slice| result << slice }
    assert_equal [[1, 2], [3, 4], [5]], result
  end

  def test_max_by
    max_by = @array_processor.max_by { |x| -x }
    assert_equal 1, max_by
  end

  def test_sort_by
    sorted = @array_processor.sort_by { |x| -x }
    assert_equal [5, 4, 3, 2, 1], sorted
  end

  def test_cycle
    result = []
    @array_processor.cycle(2) { |x| result << x }
    assert_equal [1, 2, 3, 4, 5, 1, 2, 3, 4, 5], result
  end

  def test_inject
    sum = @array_processor.inject(0) { |acc, x| acc + x }
    assert_equal 15, sum
  end

  def test_reject
    rejected = @array_processor.reject { |x| x.even? }
    assert_equal [1, 3, 5], rejected
  end
end
