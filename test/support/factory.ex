defmodule Blabl.Factory do
  @moduledoc """
  Main factory module.
  The purpose of the main factory is to allow you to include only a single module in all tests.
  """

  use ExMachina.Ecto, repo: Blabl.Repo
  use Blabl.UserFactory
end
