defmodule IoMustTest do
  use ExUnit.Case
  doctest IoMust

  test "greets the world" do
    assert IoMust.hello() == :world
  end
end
