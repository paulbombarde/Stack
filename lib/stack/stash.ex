defmodule Stack.Stash do
  use GenServer

  def start_link state do
    {:ok, pid} = GenServer.start_link(__MODULE__, state)
    pid
  end

  def stash pid, state do
    GenServer.cast(pid, {:stash, state})
  end

  def unstash pid do
    GenServer.call(pid, {:unstash})
  end

  def crash pid do
    GenServer.call(pid, :crash)
  end

  def handle_cast({:stash, state}, _) do
    {:noreply, state}
  end

  def handle_call({:unstash}, _from, state) do
    {:reply, state, state}
  end
end

