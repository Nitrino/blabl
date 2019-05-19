defmodule BlablWeb.MessengerView do
  use BlablWeb, :view

  def initials(name) do
    name
    |> String.slice(0..1)
    |> String.upcase
  end
end
