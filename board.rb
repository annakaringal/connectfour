class ConnectFourBoard
  HEIGHT = 6
  WIDTH = 7
  DIRECTIONS = [[-1,1],[0,1],[1,1],
                [-1,0],[1,0],
                [-1,-1],[0,-1],[1,-1]]

  def initialize
    # 2D array: each array is a column
    @board = Array.new(WIDTH) { Array.new() {nil}}
  end

  def place(piece, col_num)
    @board[col_num].push(piece)
    @last_play = [piece, @board[col_num].length - 1, col_num]
  end

  def to_s
    get_rows.map do |row|
      row.map {|col| col ? col : " " }.join(" ").reverse
    end.join("\n").reverse
  end

  def win?
    piece, row, col = @last_play
    DIRECTIONS.each do |col_dir, row_dir|
      return true if check_direction(piece, col, row, col_dir, row_dir)
    end
    false
  end

  def check_direction(piece, col, row, col_dir, row_dir)
    3.times do
      col += col_dir
      row += row_dir
      return false if out_of_bounds?(row, col) || @board[col][row] != piece
    end
    true
  end

  def out_of_bounds?(row, col)
    row < 0 || row >= HEIGHT || col < 0 || col >= WIDTH
  end

  def get_rows
    (0..HEIGHT-1).map do |row|
      @board.map { |col| col[row] ? col[row] : nil }
    end
  end

  def col_full?(col)
    @board[col].length >= HEIGHT
  end

  def board_full?
    @board.all? { |col| col.length >= HEIGHT }
  end

end
