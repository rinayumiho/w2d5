require_relative "item"

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = "")
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end

    def size
        @items.length
    end

    def valid_index?(idx)
        idx >= 0 && idx < size
    end

    def swap(idx1, idx2)
        return false if !valid_index?(idx1) || !valid_index?(idx2)
        @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
        true
    end

    def [](idx)
        return nil if !valid_index?(idx)
        @items[idx]
    end

    def priority
        return nil if size == 0
        @items[0]
    end

    def print
        puts "-" * 50
        puts " " * ((50 - label.length) / 2) + label
        puts "-" * 50
        puts "Index".ljust(6) + " | " + "Item".ljust(20) + " | " + "Deadline".ljust(10) + " | " + "Done?"
        puts "-" * 50 
        @items.each_with_index do |item, idx|
            done = item.done ? "YES" : "NO"
            puts idx.to_s.ljust(6) + " | " + item.title.ljust(20) + " | " + item.deadline.ljust(10) + " | " + done
        end
        puts "-" * 50
    end

    def print_full_item(idx)
        return if !valid_index?(idx)
        item = self[idx]
        done = item.done ? "YES" : "NO"
        puts "-" * 50
        puts item.title.ljust(20) + item.deadline.ljust(25) + done
        puts item.description
        puts "-" * 50
    end

    def print_priority
        print_full_item(0)
    end

    def up(idx, steps = 1)
        return false if !valid_index?(idx)
        while steps > 0 && idx > 0
            swap(idx, idx - 1)
            idx -= 1
            steps -= 1
        end
        true
    end

    def down(idx, steps = 1)
        return false if !valid_index?(idx)
        while steps > 0 && idx < size - 1
            swap(idx, idx + 1)
            idx += 1
            steps -= 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |a| a.deadline }
    end

    def toggle_item(idx)
        return false if !valid_index?(idx)
        @items[idx].toggle
    end

    def purge
        @items.reject! { |item| item.done }
    end
end