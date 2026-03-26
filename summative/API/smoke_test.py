import argparse
import json
import urllib.error
import urllib.request


def main() -> None:
    parser = argparse.ArgumentParser(description="Smoke test for /predict endpoint")
    parser.add_argument("--year", type=int, default=2030, help="Year to predict")
    parser.add_argument(
        "--url",
        type=str,
        default="http://127.0.0.1:8000/predict",
        help="Prediction endpoint URL",
    )
    args = parser.parse_args()

    payload = json.dumps({"year": args.year}).encode("utf-8")
    request = urllib.request.Request(
        args.url,
        data=payload,
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    try:
        with urllib.request.urlopen(request, timeout=10) as response:
            body = response.read().decode("utf-8")
            data = json.loads(body)
    except urllib.error.URLError as error:
        print(f"❌ Could not reach API at {args.url}: {error}")
        raise SystemExit(1)

    year = data.get("year")
    prediction = data.get("predicted_gap_percentage")

    if year is None or prediction is None:
        print("❌ API responded, but payload is missing expected fields.")
        print(data)
        raise SystemExit(1)

    print(f"✅ In {year}, predicted wage gap is {prediction}%")


if __name__ == "__main__":
    main()
