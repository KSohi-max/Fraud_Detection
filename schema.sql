DROP TABLE IF EXISTS card_holder CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS transaction CASCADE;
DROP TABLE IF EXISTS merchant_category CASCADE;
DROP TABLE IF EXISTS merchant CASCADE;

CREATE TABLE card_holder (
	cardholder_id INT PRIMARY KEY NOT NULL,
	name VARCHAR(255)
);

SELECT * FROM card_holder;

CREATE TABLE credit_card (
	card VARCHAR (20) PRIMARY KEY NOT NULL,
	cardholder_id INT NOT NULL,
	FOREIGN KEY (cardholder_id) REFERENCES card_holder(cardholder_id)
);

SELECT * FROM credit_card;

CREATE TABLE merchant (
	merchant_id INT PRIMARY KEY NOT NULL,
	name VARCHAR(255),
	merchant_category_id INT NOT NULL,
	FOREIGN KEY (merchant_category_id) REFERENCES merchant_category(merchant_category_id)
);

SELECT * FROM merchant;

CREATE TABLE merchant_category (
	merchant_category_id INT PRIMARY KEY NOT NULL,
	name VARCHAR(255)
);

SELECT * FROM merchant_category;

CREATE TABLE transaction (
	transaction_id INT PRIMARY KEY NOT NULL,
	date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
	amount numeric NOT NULL,
	card VARCHAR (20) NOT NULL,
	merchant_id INT NOT NULL,
	FOREIGN KEY (card) REFERENCES credit_card(card),
	FOREIGN KEY (merchant_id) REFERENCES merchant(merchant_id)
);

SELECT * FROM transaction;
