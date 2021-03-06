defmodule IoMust do
  def receive_message(message) do
    message
    |> encode_message_to_osc
    |> IO.puts
  end

  def encode_message_to_osc(%{address: address, arguments: arguments}) do
    OSC.encode!(%OSC.Message{address: address, arguments: arguments})
  end

  def send_message(recipient, message) do
    spawn_task(__MODULE__, :receive_message, recipient, [message])
  end

  def spawn_task(module, fun, recipient, args) do
    recipient
    |> remote_supervisor()
    |> Task.Supervisor.async(module, fun, args)
    |> Task.await()
  end

  defp remote_supervisor(recipient) do
    {IoMust.TaskSupervisor, recipient}
  end
end
