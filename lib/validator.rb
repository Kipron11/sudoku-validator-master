class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    sudoku = parse_sudoku(@puzzle_string)

    return 'Sudoku is invalid.' unless valid?(sudoku)
    return completed?(sudoku) ? 'Sudoku is valid.' : 'Sudoku is valid but incomplete.'
  end

  private

  # Cleared sudoku to see only numbers and created a 2D array, which means array in array
  def parse_sudoku(puzzle_string)
    puzzle_string.scan(/\d/).map(&:to_i).each_slice(9).to_a 
  end

  # Check if in given array all numbers are uniq, uniq numbers = valid numbers
  def valid_nums?(num)
    num.reject(&:zero?).uniq.length == num.reject(&:zero?).length
  end

  # return true if all chars in row are true...map is not best idea for this
  def valid_rows?(sudoku)
    sudoku.all? { |row| valid_nums?(row) }
  end

  # return true if all chars in column are true
  def valid_columns?(sudoku)
    sudoku.transpose.all? { |column| valid_nums?(column) }
  end

  # Slice all board after 3 element in horizontal and vertical direction
  # those pieces 3x3 i named square and check if in square are valid numbers
  def valid_squares?(sudoku)
    sudoku.each_slice(3).all? do |rows|
      rows.transpose.each_slice(3).all? { |square| valid_nums?(square.flatten) }
    end
  end
  
  # Just all valid methods in one
  def valid?(sudoku)
    valid_rows?(sudoku) && valid_columns?(sudoku) && valid_squares?(sudoku)
  end

  # Check if sudoku does NOT include 0
  def completed?(sudoku)
    !sudoku.flatten.include?(0)
  end
end
