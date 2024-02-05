DROP TABLE IF EXISTS "transactions";
DROP TABLE IF EXISTS "credit_cards";
DROP TABLE IF EXISTS "accounts";
DROP TABLE IF EXISTS "owners";

CREATE TABLE "owners" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "first_name" varchar(150) NOT NULL,
  "last_name" varchar(150) NOT NULL,
  "gender" varchar(10) NOT NULL,
  "date_of_birth" date NOT NULL
);

CREATE TABLE "accounts" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "iban" varchar(27) UNIQUE NOT NULL,
  "bic" varchar(8) NOT NULL,
  "opening_date" timestamp NOT NULL,
  "closing_date" timestamp,
  "owner_id" integer NOT NULL REFERENCES "owners" ("id"),
  UNIQUE ("id", "owner_id")
);

CREATE TABLE "credit_cards" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "issuer" varchar(30) NOT NULL,
  "numbers" varchar(16) UNIQUE NOT NULL,
  "expiration_date" date NOT NULL,
  "cvv" varchar(3) NOT NULL,
  "account_id" integer NOT NULL REFERENCES "accounts" ("id")
);

CREATE TABLE "transactions" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "amount" numeric NOT NULL,
  "currency" varchar(3) NOT NULL,
  "merchant_name" varchar(100) NOT NULL,
  "issued_at" timestamp NOT NULL,
  "sender_account_id" integer NOT NULL REFERENCES "accounts" ("id"),
  "recipient_account_id" integer NOT NULL REFERENCES "accounts" ("id"),
  "credit_card_id" integer NOT NULL REFERENCES "credit_cards" ("id")
);

COPY owners(id, first_name, last_name, gender, date_of_birth)
FROM '/sql/datasets/account-owners.csv'
DELIMITER ','
CSV HEADER;

COPY accounts(id, iban, bic, opening_date, closing_date, owner_id)
FROM '/sql/datasets/accounts.csv'
DELIMITER ','
CSV HEADER;

COPY credit_cards(id, issuer, numbers, expiration_date, cvv, account_id)
FROM '/sql/datasets/credit-cards.csv'
DELIMITER ','
CSV HEADER;

COPY transactions(id, amount, currency, merchant_name, issued_at, sender_account_id, recipient_account_id, credit_card_id)
FROM '/sql/datasets/transactions.csv'
DELIMITER ','
CSV HEADER;
