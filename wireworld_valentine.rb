########################################################################
# Wireworld Valentine Challenge
# Objective: Implement Wireworld and create a Valentine circuit!
# Start Date: February 2, 2023
# End Date: February 14, 2023
########################################################################
class WireworldValentine
  EMPTY         = "🟪" # State 0
  ELECTRON_HEAD = "🟥" # State 1
  ELECTRON_TAIL = "⬜" # State 2
  CONDUCTOR     = "🟨" # State 3

  def initialize(rows:, cols:)
    @rows = rows
    @cols = cols
    @grid = Array.new(rows) { Array.new(cols, EMPTY) }
  end

  def self.load(file)
    # parse the file data
    data =
      file
        .readlines(chomp: true)
        .map(&:chars)

    # create the game
    self
      .new(rows: data.length, cols: data[0].length)
      .tap { |game| game.instance_variable_set(:@grid, data) }
  end

  def display
    system("clear") || system("cls")

    puts @grid.collect(&:join)
  end

  ######################################################################
  # Implement the below method. Rules for Wireworld may be found on wiki
  # https://en.wikipedia.org/wiki/Wireworld
  ######################################################################

  def get_neighbor_value(grid, i, k)
    neighbors = []
    # left
    neighbors << grid[i][k - 1] if k - 1 >= 0
    # right
    neighbors << grid[i][k + 1] if k + 1 < grid[i].length
    # top
    neighbors << grid[i - 1][k] if i - 1 >= 0
    # bottom
    neighbors << grid[i + 1][k] if i + 1 < grid.length
    # top-left
    neighbors << grid[i - 1][k - 1] if i - 1 >= 0 && k - 1 >= 0
    # top-right
    neighbors << grid[i - 1][k + 1] if i - 1 >= 0 && k + 1 < grid[i].length
    # bottom-left
    neighbors << grid[i + 1][k - 1] if i + 1 < grid.length && k - 1 >= 0
    # bottom-right
    neighbors << grid[i + 1][k + 1] if i + 1 < grid.length && k + 1 < grid[i].length
    #return all valid Moore neighborhood cells
    neighbors
  end

  def tick
    # Hint: mutate @grid
    new_grid = Array.new(@rows) { Array.new(@cols, EMPTY) }

    @grid.each_with_index do |row, i|
      row.each_with_index do |item, k|

        if item == CONDUCTOR
          head_count = get_neighbor_value(@grid, i, k).count(ELECTRON_HEAD)
          if head_count == 1 || head_count == 2
            new_grid[i][k] = ELECTRON_HEAD
          else
            new_grid[i][k] = CONDUCTOR  
          end
        elsif item == ELECTRON_TAIL
          new_grid[i][k] = CONDUCTOR
        elsif item == ELECTRON_HEAD
          new_grid[i][k] = ELECTRON_TAIL
        end
      end
    end
    @grid = new_grid
  end

  def run(steps=nil)
    (0..steps).each do
      display
      tick
      sleep 0.2
    end
  end
end

WireworldValentine.load(DATA).run
__END__
🟪🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨⬜🟥🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟪
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟨🟨🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟨🟪🟪🟨🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟨🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨🟪🟨🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟨🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟨🟪🟪🟨🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟨🟪🟨🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟨🟪🟪🟨🟨🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨🟪🟨🟪🟨🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟨🟨🟨🟨🟨🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟨🟨🟨🟨🟨🟨🟪🟨🟨🟨🟨🟨🟨🟨🟪🟪🟪🟪🟨🟨🟨🟨🟨🟨🟨🟨🟪🟨🟨🟨🟨🟨🟨🟪🟪🟨
🟨🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨
🟨🟪🟪🟨🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟨🟪🟪🟨🟪🟪🟨
🟨🟪🟪🟨🟪🟨🟪🟨🟪🟨🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟨🟪🟨🟪🟨🟪🟨🟪🟪🟨
🟨🟪🟪🟨🟪🟨🟪🟪🟨🟪🟪🟪🟨🟪🟪🟨🟨🟨🟪🟪🟨🟨🟨🟪🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪🟨🟨🟪🟪🟨
🟨🟪🟪🟨🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟨🟪🟪🟨
🟨🟪🟪🟪🟨🟪🟨🟪🟪🟪🟪🟨🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟨🟪🟪🟪🟨
🟨🟪🟪🟪🟨🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟨🟨🟨🟪🟪🟨🟨🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟨🟪🟪🟪🟨
🟨🟪🟪🟪🟨🟪🟪🟨🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨🟪🟪🟨🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟨🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟨🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟨🟨🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟨🟨🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟪🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟥⬜🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟪
🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪
🟪🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟪
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟨🟨🟪🟪🟪🟪🟪🟪🟨🟨🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟨🟨🟨
🟨🟪🟪🟨🟨🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟨🟪🟨🟨🟪🟪🟨🟨🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟨🟨🟨🟪🟪🟨
🟨🟪🟪🟨🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟨🟪🟨🟪🟪🟨
🟨🟪🟪🟨🟪🟪🟨🟨🟨🟨🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟨🟨🟨🟨🟪🟪🟨🟪🟪🟨
🟥🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟨
⬜🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟥
🟨🟪🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟨🟪🟪🟪⬜
🟨🟪🟪🟪🟨🟪🟨🟨🟪🟪🟪🟪🟪🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟪🟪🟪🟪🟨🟨🟪🟨🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨
🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨
🟨🟨🟨🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟨🟨🟨
🟨🟪🟪🟨🟨🟨🟨🟨🟨🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟨🟨🟨🟨🟨🟨🟪🟪🟨
🟨🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟨
🟨🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟪🟪🟪🟨🟪🟪🟪🟨
🟨🟪🟪🟨🟨🟪🟪🟪🟨🟪🟨🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟪🟨🟪🟨🟪🟪🟪🟨🟨🟪🟪🟨
🟪🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟨🟪