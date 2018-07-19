# Ebc

Simple elixir program to understand the underlying technology of Blockchain.

## How to use

```
mix test
```

```
.Chain: [
  %{
    hash: "003DEF4D4959A3696F3EF5E518434CDC6A4F071AA2EC2400891D2602C7971C02",
    nonce: 108,
    previousHash: "000000000000000000000000",
    timestamp: "2018-07-19 05:39:53.504271Z"
  },
  %{
    hash: "0038B548AA07188C7D6A77C2BEE65CCF6C174AB889DE19C43D14FFE7C1022D15",
    nonce: 261,
    previousHash: "003DEF4D4959A3696F3EF5E518434CDC6A4F071AA2EC2400891D2602C797
1C02",
    timestamp: "2018-07-19 10:16:40.676761Z"
  },
  %{
    hash: "007E2A1CDF1B6920ADA2DEBB9A82DA407DEAB3A271B9E6C44CE321429DE972A3",
    nonce: 136,
    previousHash: "0038B548AA07188C7D6A77C2BEE65CCF6C174AB889DE19C43D14FFE7C102
2D15",
    timestamp: "2018-07-19 10:16:40.703552Z"
  }
]
.....
```

## Note

Change the difficulty at ebc.ex and run the mix test again.
