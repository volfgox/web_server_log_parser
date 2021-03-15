# frozen_string_literal: true

# A repository class to hold visits detail
class Store
  def initialize
    @visits = Hash.new { |hash, key| hash[key] = [] }
  end

  def add(route, ip)
    visits[route] << ip
  end

  def visit_count
    sort(visits.map { |key, value| [key, value.count] })
  end

  def unique_visit_count
    sort(visits.map { |key, value| [key, value.uniq.count] })
  end

  private

  attr_reader :visits

  def count(route)
    visits[route].count
  end

  def sort(count_array)
    count_array.sort { |a, b| b[1] <=> a[1] }
  end
end
