defmodule ServerTest do
  use ExUnit.Case, async: false
  doctest Stack

  test "basic behavior of client api" do
    #{:ok, pid} = Stack.Server.start_link([1, 2, 3])
    assert 3 == Stack.Server.length
    assert 1 == Stack.Server.pop
    assert 2 == Stack.Server.pop
    assert 1 == Stack.Server.length
    Stack.Server.push(1)
    assert 2 == Stack.Server.length
    assert 1 == Stack.Server.pop
    assert 3 == Stack.Server.pop
    assert :empty == Stack.Server.pop
    assert 0 == Stack.Server.length
  end

  #test "default state" do
  # {:ok, pid} = Stack.Server.start_link()
  # assert 0 == Stack.Server.length(pid)
  # assert :empty == Stack.Server.pop(pid)
  # Stack.Server.push(pid, "coucou")
  # assert "coucou" == Stack.Server.pop(pid)
  # assert :empty == Stack.Server.pop(pid)
  # Stack.Server.stop
  #end
end
