defmodule EbcTest do
  use ExUnit.Case

  test "difficulty" do
    assert Ebc.difficulty() == "00"
  end
end
