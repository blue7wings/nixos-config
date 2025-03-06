#!/usr/bin/env python3

import urllib.request
import argparse
import json
import sys

parser = argparse.ArgumentParser(description="Display currencies on polybar")
parser.add_argument("--coins", type=str,
                    nargs="+", help="Select coins to display")
parser.add_argument("--base", type=str,
                    nargs="?", default="USD", help="Currency base to convert against")
parser.add_argument("--decimals", type=int,
                    nargs="?", default=2, help="How many decimals to show")
parser.add_argument("--display", type=str,
                    nargs="?", default="price", choices=["price", "percentage", "both"], help="Display mode")

args = parser.parse_args()

if not args.coins:
    parser.print_help()
    parser.exit()

BASE_URL = "https://www.okx.com"
CURRENCY_SIGN = {
    "USD": "$",
    "USDT": "$",
    "EUR": "€",
    "BTC": "₿"
}

for coin in args.coins:
    instId = f"{coin.upper()}-USDT" if args.base.upper() == "USD" else f"{coin.upper()}-{args.base.upper()}"
    
    try:
        url = f"{BASE_URL}/api/v5/market/ticker?instId={instId}"
        req = urllib.request.Request(url)
        req.add_header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
        req.add_header("Accept", "application/json")
        
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
            ticker = data["data"][0]
        
        # 最新价格
        price_float = round(float(ticker["last"]), args.decimals)
        current_price = f"{CURRENCY_SIGN.get(args.base.upper(), args.base)}{price_float}"
        
        # 计算24小时变化百分比
        last = float(ticker["last"])
        open24h = float(ticker["sodUtc8"])
        change = ((last - open24h) / open24h) * 100

        if args.display == "price":
            sys.stdout.write(f" {coin} {current_price} ")
        elif args.display == "percentage":
            sys.stdout.write(f" {coin} {change:+.2f}% ")
        elif args.display == "both":
            sys.stdout.write(f" {coin} {current_price}({change:+.2f}%)")

    except urllib.error.HTTPError as e:
        sys.stderr.write(f"HTTP Error {e.code} for {coin}: {e.reason}\n")
        sys.stderr.write(f"Response: {e.read().decode()}\n")
    except (KeyError, IndexError, ValueError) as e:
        sys.stderr.write(f"Error processing data for {coin}: {str(e)}\n")

sys.stdout.write("\n")
