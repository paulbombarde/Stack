defmodule Stack.Server do
  use GenServer

  # seems to be better as judged from the elixir mix/otp getting started tutorial

  # Client API
  def start_link(stash) do
    state = Stack.Stash.unstash stash
    GenServer.start_link(__MODULE__, {stash, state}, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push v do
    GenServer.cast(__MODULE__, {:push, v})
  end

  def length do
    GenServer.call(__MODULE__, :length)
  end

  def crash do
    GenServer.call(__MODULE__, :crash)
  end

  def stop do
    GenServer.stop(__MODULE__)
  end
      

  # Server callbacks
  def handle_call(:pop, _from, {stash, [h|t]}) do
    {:reply, h, {stash,t}}
  end

  def handle_call(:pop, _from, {stash, []}) do
    {:reply, :empty, {stash, []}}
  end

  def handle_call(:length, _from, {stash, stack}) do
    {:reply, Kernel.length(stack), {stash, stack}}
  end

  def handle_cast({:push, v}, {stash, stack}) do
    {:noreply, {stash, [v|stack]}}
  end

  def format_status(_reason, [ _pdict, state]) do
    [data: [{'State', "The current stack content is #{inspect state}"}]]
  end

  def terminate(_reason, {stash_pid, state}) do
    Stack.Stash.stash stash_pid, state
  end
end
