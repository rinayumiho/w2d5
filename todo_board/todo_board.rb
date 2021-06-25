require_relative "item"
require_relative "list"

class Todo_board
    def initialize
        @board = Hash.new
    end

    def get_command
        puts "please enter your command: "
        cmd, *args = gets.chomp.split(' ')
        label = args.empty? ? nil : args[0]
        strs = args.length < 2 ? nil : args[1...args.length]
        arr = strs == nil ? nil : strs.map { |ele| ele.to_i }
        case cmd
        when "mklist"
            @board[label] = List.new(label)
        when "ls"
            puts @board.keys
        when "showall"
            @board.each_value { |list| list.print }
        when "mktodo"
            @board[label].add_item(*strs)
        when "up"
            @board[label].up(*arr)
        when "down"
            @board[label].down(*arr)
        when "swap"
            @board[label].swap(*arr)
        when "sort"
            @board[label].sort_by_date!
        when "priority"
            @board[label].print_priority
        when "print"
            if arr == nil
                @board[label].print
            else
                @board[label].print_full_item(arr[0])
            end
        when "quit"
            return false
        when "toggle"
            @board[label].toggle_item(arr[0])
        when "purge"
            @board[label].purge
        else
            puts "invalid input"
        end
        true
    end

    def run
        signal = get_command
        while signal
            signal = get_command
        end
    end
end