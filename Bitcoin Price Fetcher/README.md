# Bitcoin Price Fetcher

Write a single Bash script named `execute.sh` that:

* Fetches the current Bitcoin (BTC) price in USD from the CoinGecko API
* Prints only the numeric price (e.g., `43250.12`) to stdout
* No extra text, JSON, symbols, or formatting allowed

## API Endpoint

```
https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd
```

Response format is simple JSON:

```json
{"bitcoin":{"usd":43250.12}}
```

## Example Output

```
43250.12
```