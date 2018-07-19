defmodule BlockTest do
  use ExUnit.Case

  test "generate hash" do
    index = 1
    timestamp = DateTime.utc_now() |> to_string()
    data = %{amount: 4} |> Poison.encode!()
    previousHash = "000000000000000000000000"
    block = Block.new(index, previousHash, timestamp, data)

    assert block.hash ==
             :crypto.hash(:sha256, "#{index}#{previousHash}#{timestamp}#{data}")
             |> Base.encode16()
  end
end
