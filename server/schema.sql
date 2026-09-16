CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE TABLE IF NOT EXISTS users (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), email TEXT UNIQUE NOT NULL, password_hash TEXT NOT NULL,
 full_name TEXT NOT NULL, created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS accounts (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 balance NUMERIC(14,2) NOT NULL DEFAULT 0, created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TYPE transaction_kind AS ENUM ('deposit','transfer_sent','transfer_received');
CREATE TABLE IF NOT EXISTS transactions (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
 kind transaction_kind NOT NULL, amount NUMERIC(14,2) NOT NULL CHECK (amount > 0),
 counterparty TEXT, note TEXT, created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS password_resets (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 token_hash TEXT NOT NULL, expires_at TIMESTAMPTZ NOT NULL, used_at TIMESTAMPTZ
);
