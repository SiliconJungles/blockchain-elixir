defmodule BlockChainTest do
  use ExUnit.Case

  setup do
    {:ok, %{blockchain: BlockChain.new()}}
  end

  test "get latest block", %{blockchain: blockchain} do
    index = 1
    timestamp = "2018-07-19 05:39:53.504271Z"
    first_hash = "000000000000000000000000"
    data = "Genesis Block"

    assert blockchain |> BlockChain.latest_block() ==
             Block.new(index, first_hash, timestamp, data)
  end

  test "add new block to the chain", %{blockchain: blockchain} do
    index = 2
    timestamp = DateTime.utc_now() |> to_string
    data = %{amount: 10} |> Poison.encode!()

    latest_block = blockchain |> BlockChain.latest_block()

    # IO.inspect(
    #   blockchain
    #   |> BlockChain.add_block(Block.new(index, latest_block.hash, timestamp, data))
    # )

    assert blockchain
           |> BlockChain.add_block(Block.new(index, latest_block.hash, timestamp, data))
           |> length == 2
  end

  test "the chain is valid", %{blockchain: blockchain} do
    index = 2
    timestamp = DateTime.utc_now() |> to_string
    data = %{amount: 10} |> Poison.encode!()

    index1 = 3
    timestamp1 = DateTime.utc_now() |> to_string
    data1 = %{amount: 40} |> Poison.encode!()

    chain =
      blockchain
      |> BlockChain.add_block(
        Block.new(index, (blockchain |> BlockChain.latest_block()).hash, timestamp, data)
      )

    chain =
      chain
      |> BlockChain.add_block(
        Block.new(index1, (chain |> BlockChain.latest_block()).hash, timestamp1, data1)
      )

    assert chain |> BlockChain.valid?() == true
    assert chain |> length == 3
  end

  test "the chain is not valid", %{blockchain: blockchain} do
    index1 = 3
    timestamp1 = DateTime.utc_now() |> to_string
    data1 = %{amount: 40} |> Poison.encode!()

    chain =
      blockchain
      |> BlockChain.add_block(Block.new(index1, "230428049203942034", timestamp1, data1))

    assert chain |> BlockChain.valid?() == false
  end
end
