class AstroidTable

  def self.create_table(astroids)
    t = new(astroids)
    puts t.divider
    puts t.header
    t.create_rows
    puts t.divider
  end

  def initialize(astroids)
    @astroids = astroids
  end

  def header
    "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def divider
    "+-#{ column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def create_rows
    @astroids.each { |astroid| format_row_data(astroid) }
  end

  private

  def format_row_data(row_data)
    row = row_data.keys.map { |key| row_data[key].ljust(column_data[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def column_labels
    { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  end

  def column_data
    @column_data ||= column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [@astroids.map { |astroid| astroid[col].size }.max, label.size].max}
    end
  end
end
