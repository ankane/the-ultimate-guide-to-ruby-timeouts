require_relative "test_helper"

class OsqpTest < Minitest::Test
  def test_solve
    p = [[4, 1], [0, 2]]
    q = [1, 1]
    a = [[1, 1], [1, 0], [0, 1]]
    l = [1, 0, 0]
    u = [1, 0.7, 0.7]

    solver = OSQP::Solver.new
    solver.solve(p, q, a, l, u, alpha: 1.0, time_limit: 0.000001)
  end
end
