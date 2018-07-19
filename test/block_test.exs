defmodule BlockTest do
  use ExUnit.Case

  test "generate hash" do
    timestamp = DateTime.utc_now() |> to_string()
    transaction = %{amount: 4} |> Poison.encode!()
    previousHash = "000000000000000000000000"
    block = Block.new(previousHash, timestamp, transaction)

    assert block.hash |> String.starts_with?(Ebc.difficulty()) == true
  end
end
