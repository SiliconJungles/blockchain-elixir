defmodule BlockChainTest do
  use ExUnit.Case

  setup do
    {:ok, %{blockchain: BlockChain.new()}}
  end

  test "get latest block", %{blockchain: blockchain} do
    timestamp = "2018-07-19 05:39:53.504271Z"
    first_hash = "000000000000000000000000"
    transaction = "Genesis Block"

    assert blockchain |> BlockChain.latest_block() ==
             Block.new(first_hash, timestamp, transaction)
  end

  test "add new block to the chain", %{blockchain: blockchain} do
    timestamp = DateTime.utc_now() |> to_string
    transaction = %{amount: 10} |> Poison.encode!()

    latest_block = blockchain |> BlockChain.latest_block()

    assert blockchain
           |> BlockChain.add_block(Block.new(latest_block.hash, timestamp, transaction))
           |> length == 2
  end

  test "the chain is valid", %{blockchain: blockchain} do
    timestamp = DateTime.utc_now() |> to_string
    transaction = %{amount: 10} |> Poison.encode!()

    timestamp1 = DateTime.utc_now() |> to_string
    transaction1 = %{amount: 40} |> Poison.encode!()

    chain =
      blockchain
      |> BlockChain.add_block(
        Block.new((blockchain |> BlockChain.latest_block()).hash, timestamp, transaction)
      )

    chain =
      chain
      |> BlockChain.add_block(
        Block.new((chain |> BlockChain.latest_block()).hash, timestamp1, transaction1)
      )

    IO.inspect(chain, label: "Chain")

    assert chain |> BlockChain.valid?() == true
    assert chain |> length == 3
  end

  test "the chain is not valid", %{blockchain: blockchain} do
    timestamp1 = DateTime.utc_now() |> to_string
    transaction1 = %{amount: 40} |> Poison.encode!()

    chain =
      blockchain
      |> BlockChain.add_block(Block.new("230428049203942034", timestamp1, transaction1))

    assert chain |> BlockChain.valid?() == false
  end
end
