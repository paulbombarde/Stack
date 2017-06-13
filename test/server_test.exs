defmodule ServerTest do
  use ExUnit.Case
  doctest Stack

  test "basic behavior of client api" do
    {:ok, pid} = Stack.Server.start_link([1, 2, 3])
    assert 3 == Stack.Server.length(pid)
    assert 1 == Stack.Server.pop(pid)
    assert 2 == Stack.Server.pop(pid)
    assert 1 == Stack.Server.length(pid)
    Stack.Server.push(pid, 1)
    assert 2 == Stack.Server.length(pid)
    assert 1 == Stack.Server.pop(pid)
    assert 3 == Stack.Server.pop(pid)
    assert :empty == Stack.Server.pop(pid)
    assert 0 == Stack.Server.length(pid)
  end

  test "default state" do
    {:ok, pid} = Stack.Server.start_link()
    assert 0 == Stack.Server.length(pid)
    assert :empty == Stack.Server.pop(pid)
    Stack.Server.push(pid, "coucou")
    assert "coucou" == Stack.Server.pop(pid)
    assert :empty == Stack.Server.pop(pid)
  end
end
