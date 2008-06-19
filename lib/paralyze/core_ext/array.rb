class Array
  def partition_balanced(number_of_splits)    
    # TODO: Refactor this inefficient gremlin mercilessly
    partitions = (1..number_of_splits).map { [] }
    non_destructive_clone = self.clone
    until non_destructive_clone.empty? do
      partitions.each do |partition|
        partition << non_destructive_clone.shift unless non_destructive_clone.empty?
      end
    end
    index = 0
    partitions.map do |p| 
      current_index = index
      index += p.size
      self[current_index...(p.size + current_index)] 
    end
  end
end