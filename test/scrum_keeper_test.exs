defmodule ScrumKeeperTest do
  use ExUnit.Case
  doctest ScrumKeeper

  test "greets the world" do
    assert ScrumKeeper.hello() == :world
  end
end
