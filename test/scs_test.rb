require_relative "test_helper"

class ScsTest < Minitest::Test
  def test_solve
    data = {a: [[1], [-1]], b: [1, 0], c: [-1]}
    cone = {q: [], l: 2}

    solver = SCS::Solver.new
    result = solver.solve(data, cone, time_limit_secs: 0.000001, verbose: false)
    assert_equal "solved (inaccurate - reached time_limit_secs)", result[:status]
  end
end
