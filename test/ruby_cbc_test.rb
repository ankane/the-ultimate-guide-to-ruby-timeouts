require_relative "test_helper"

class RubyCbcTest < Minitest::Test
  def test_solve
    m = Cbc::Model.new
    x1, x2, x3 = m.int_var_array(3, 0..Cbc::INF)
    m.maximize(10 * x1 + 6 * x2 + 4 * x3)
    m.enforce(x1 + x2 + x3 <= 100)
    m.enforce(10 * x1 + 4 * x2 + 5 * x3 <= 600)
    m.enforce(2 * x1 + 2 * x2 + 6* x3 <= 300)

    problem = m.to_problem
    problem.set_time_limit(0)
    problem.solve

    assert problem.time_limit_reached?
  end
end
