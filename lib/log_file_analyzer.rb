# frozen_string_literal: true

# A coordinator class to mange injected dependencies.
# So, final desire task will fulfill
class LogFileAnalyzer
  def initialize(reader:, store:, printer:)
    @reader = reader
    @store = store
    @printer = printer
  end

  def execute
    reader.each_visit do |route, ip|
      store.add route, ip
    end

    printer.print(store.visit_count, store.unique_visit_count)
  end

  private

  attr_reader :reader, :store, :printer
end
