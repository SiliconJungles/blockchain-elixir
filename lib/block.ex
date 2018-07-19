defmodule Block do
  def new(index, previousHash \\ "", timestamp, data) do
    {hash, nonce} = mine_block(index, previousHash, timestamp, data, 0)

    %{
      index: index,
      previousHash: previousHash,
      timestamp: timestamp,
      hash: hash,
      nonce: nonce
    }
  end

  def generate_hash(index, previousHash, timestamp, data, nonce) do
    :crypto.hash(:sha256, "#{index}#{previousHash}#{timestamp}#{data}#{nonce}")
    |> Base.encode16()
  end

  def mine_block(index, previousHash, timestamp, data, nonce) do
    hash = generate_hash(index, previousHash, timestamp, data, nonce)

    case hash
         |> String.starts_with?(Ebc.difficulty()) do
      true ->
        {hash, nonce}

      false ->
        mine_block(index, previousHash, timestamp, data, nonce + 1)
    end
  end
end
