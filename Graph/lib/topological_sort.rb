require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  khan_sort(vertices)
  # tarian_sort(vertices)
end

def khan_sort(vertices)
  queue = []
  in_edge_count = {}
  # Collect node with no in_edges
  vertices.each do |ver|
    queue << ver if ver.in_edges.empty?
    in_edge_count[ver] = ver.in_edges.length
  end

  out_arr = []
  until queue.empty?
    curr = queue.shift
    out_arr << curr
    curr.out_edges.each do |out_edge|
      to_vertex = out_edge.to_vertex
      in_edge_count[to_vertex] -= 1
      queue << to_vertex if in_edge_count[to_vertex] == 0
    end
  end
  out_arr
end

def tarian_sort(vertices)

end

def dfs!(vertex, explored, ordering)
  explored.add(vertex)

  vertex.out_edges.each do |edge| # O(|e|)
    new_vertex = edge.to_vertex
    dfs!(new_vertex, explored, ordering) unless explored.include?(new_vertex) 
  end

  ordering.unshift(vertex)
end
