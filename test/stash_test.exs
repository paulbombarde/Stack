defmodule StashTest do
  use ExUnit.Case
  doctest Stack.Stash

  test "Stash is empty by default" do
    pid = Stack.Stash.start_link
    assert [] == Stack.Stash.unstash pid
  end

  test "Stash remember stashed value" do
    pid = Stack.Stash.start_link
    Stack.Stash.stash(pid, :value)
    assert :value == Stack.Stash.unstash pid
    # test unstash can be called twice with the same result.
    assert :value == Stack.Stash.unstash pid
  end

  test "Stashed value can be updated" do
    pid = Stack.Stash.start_link
    Stack.Stash.stash(pid, :value1)
    Stack.Stash.stash(pid, :value2)
    assert :value2 == Stack.Stash.unstash pid
  end
end
