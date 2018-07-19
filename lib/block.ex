defmodule Block do
  def new(previousHash \\ "", timestamp, transaction) do
    {hash, nonce} = mine_block(previousHash, timestamp, transaction, 0)

    %{
      previousHash: previousHash,
      timestamp: timestamp,
      hash: hash,
      nonce: nonce
    }
  end

  def generate_hash(previousHash, timestamp, transaction, nonce) do
    :crypto.hash(:sha256, "#{previousHash}#{timestamp}#{transaction}#{nonce}")
    |> Base.encode16()
  end

  def mine_block(previousHash, timestamp, transaction, nonce) do
    hash = generate_hash(previousHash, timestamp, transaction, nonce)

    case hash
         |> String.starts_with?(Ebc.difficulty()) do
      true ->
        {hash, nonce}

      false ->
        mine_block(previousHash, timestamp, transaction, nonce + 1)
    end
  end
end
