defmodule Stack.Server.Supervisor do
  use Supervisor
  def start_link(stash_pid) do
    Supervisor.start_link(__MODULE__, stash_pid)
  end
  def init(stash_pid) do
    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Stack.Worker.start_link(arg1, arg2, arg3)
      worker(Stack.Server, [stash_pid]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Stack.Server.Supervisor]
    supervise children, opts
  end
end
