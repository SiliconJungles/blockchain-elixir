defmodule BlockChain do
  def new do
    [create_genesis_block()]
  end

  def latest_block(chain) do
    chain |> List.last()
  end

  def add_block(chain, new_block) do
    chain ++ [new_block]
  end

  def valid?(chain) do
    for {_el, counter} <- chain |> Enum.with_index(1) do
      current_block = chain |> Enum.at(counter)
      previous_block = chain |> Enum.at(counter - 1)

      if current_block do
        if current_block.previousHash != previous_block.hash do
          false
        end
      end
    end

    true
  end

  defp create_genesis_block do
    Block.new(1, "000000000000000000000000", "2018-07-19 05:39:53.504271Z", "Genesis Block")
  end
end
