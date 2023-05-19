class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    sudoku = parse_sudoku(@puzzle_string)

    if valid?(sudoku)
      if completed?(sudoku)
        return 'Sudoku is valid.'
      else 
        return 'Sudoku is valid but incomplete.'
      end
    else
      return 'Sudoku is invalid.'
    end
  end


  private

  def parse_sudoku(puzzle_string)
    puzzle_string.scan(/\d/).map(&:to_i).each_slice(9).to_a 
    # Cleared sudoku to see only numbers and created a 2D array, which means array in array
  end

  def valid_nums?(num)
    num.reject { |n| n == 0 }.uniq.length == num.reject { |n| n == 0 }.length
    # Check if in given array all numbers are uniq, uniq numbers = valid numbers
  end

  def valid_rows?(sudoku)
    sudoku.all? { |row| valid_nums?(row) }
    # return true if all chars in row are true...map is not best idea for this
  end

  def valid_columns?(sudoku)
    sudoku.transpose.all? { |column| valid_nums?(column) }
    # return true if all chars in column are true
  end

  def valid_squares?(sudoku)
    sudoku.each_slice(3).all? do |rows|
      rows.transpose.each_slice(3).all? { |square| valid_nums?(square.flatten) }
    # Slice all board after 3 element in horizontal and vertical direction
    # those pieces 3x3 i named square and check if in square are valid numbers
    end
  end
  
  def valid?(sudoku)
    valid_rows?(sudoku) && valid_columns?(sudoku) && valid_squares?(sudoku)
    # Just all valid methods in one
  end

  def completed?(sudoku)
    !sudoku.flatten.include?(0)
    # Check if sudoku does NOT include 0
  end
end
