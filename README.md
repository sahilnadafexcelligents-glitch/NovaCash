# Novacash

Demo-money banking app. It never connects to real payment systems.

## Run locally

1. Create a PostgreSQL database named `novacash`.
2. Run `psql -d novacash -f server/schema.sql`.
3. Copy `.env.example` to `.env` and set a strong `JWT_SECRET`.
4. Run `npm install`, then `npm run dev`.

The web app runs on `http://localhost:5173`; its API runs on port 4000.

In development, forgot-password returns a one-time demo reset token. Enter it at `/reset`. Production should email a reset link instead and use HTTPS, secure refresh-token cookies, rate limits, and a real secrets manager.
