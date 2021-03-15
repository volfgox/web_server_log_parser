# frozen_string_literal: true

# frozen_string_literal

# A class which knows how to send received info to standard output
class Printer
  def print(visits, unique_visits)
    print_visit_header

    visits.each do |visit|
      puts "#{visit[0]} #{visit[1]} #{visit[1] > 1 ? 'visits' : 'visit'}"
    end

    print_unique_visit_header

    unique_visits.each do |visit|
      puts "#{visit[0]} #{visit[1]} unique #{visit[1] > 1 ? 'views' : 'view'}"
    end
  end

  private

  def print_visit_header
    puts 'Routes visit count'
  end

  def print_unique_visit_header
    puts "\nRoutes unique visit count"
  end
end
