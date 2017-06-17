defmodule Stack.Server do
  use GenServer

  # seems to be better as judged from the elixir mix/otp getting started tutorial

  # Client API
  def start_link(initial_stack \\ []) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
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

  # Server callbacks
  def handle_call(:pop, _from, [h|t]) do
    {:reply, h, t}
  end

  def handle_call(:pop, _from, []) do
    {:reply, :empty, []}
  end

  def handle_call(:length, _from, stack) do
    {:reply, Kernel.length(stack), stack}
  end

  def handle_cast({:push, v}, stack) do
    {:noreply, [v|stack]}
  end

  def format_status(_reason, [ _pdict, state]) do
    [data: [{'State', "The current stack content is #{inspect state}"}]]
  end
end
