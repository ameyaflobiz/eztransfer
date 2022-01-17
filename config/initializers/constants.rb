CURRENCIES = { "inr" => 0, "usd" => 1, "yen" => 2, "eur" => 3, "chf" => 4 } # Change to strings
API_KEY=Rails.application.credentials.api_key
JWT_SECRET= Rails.application.credentials.jwt_secret
BASE_API_URL="http://api.exchangeratesapi.io/v1/latest?access_key="
REQD_CURRENCIES="&symbols=INR,USD,JPY,EUR,CHF&format=1"
AMOUNT_PRECISION=2