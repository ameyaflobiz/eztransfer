CURRENCIES = { inr: 0, usd: 1, yen: 2, euro: 3, chf: 4 }
API_KEY=Rails.application.secrets.currency_api_key
BASE_API_URL="http://api.exchangeratesapi.io/v1/latest?access_key="
REQD_CURRENCIES="&symbols=INR,USD,YEN,EUR,CHF&format=1"
AMOUNT_PRECISION=2