--QUERIES: Data Analysis Part 1
--How can you isolate (or group) the transactions of each cardholder?

SELECT a.cardholder_id, name, b.card, c.transaction_id, c.date, c.amount
FROM card_holder AS a
JOIN credit_card AS b ON a.cardholder_id = b.cardholder_id
JOIN transaction AS c ON b.card = c.card
GROUP BY a.cardholder_id, b.card, c.transaction_id
ORDER BY a.cardholder_id ASC;

--Count the transactions that are less than $2.00 per cardholder

SELECT a.cardholder_id, name, COUNT(c.amount < 2.00) AS "count of amount < $2.00"
FROM card_holder AS a
JOIN credit_card AS b ON a.cardholder_id = b.cardholder_id
JOIN transaction AS c ON b.card = c.card
	WHERE c.amount < 2.00
GROUP BY a.cardholder_id
ORDER BY a.cardholder_id ASC
;

--Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

--ANSWER: Based on the criteria of transaction with amount less than $2.00 isn't sufficient to help 
--determine if there is fraud taking place. One must deep dive into the transaction itself to 
--determine if the charge is valid or fraudulent.  

--Take your investigation a step further by considering the time period in 
--which potentially fraudulent transactions are made.

--What are the top 100 highest transactions made between 7:00 am and 9:00 am?
DROP VIEW if exists top100_transactions;

CREATE VIEW top100_transactions AS

SELECT transaction_id, CAST(date as TIME)as transaction_time, MAX(amount) AS top100_amount
FROM transaction
WHERE CAST(date as TIME) BETWEEN '07:00:00' AND '09:00:00' 
AND amount < 2.00
GROUP BY transaction_id
ORDER BY transaction_time ASC
LIMIT 100;

SELECT * FROM top100_transactions;

--Do you see any anomalous transactions that could be fraudulent?
--Answer:  There seem to be 30 top100 highest transactions that occur during 7-9AM.
--These can be considered fraudulent but more information/detail of the transaction is required 
--to be certain.

--Is there a higher number of fraudulent transactions made during this 
--time frame versus the rest of the day?

--Number of transactions with amount less than $2.00 between 7 to 9am

DROP VIEW if exists transactions_7to9;

CREATE VIEW transactions_7to9 AS

SELECT transaction_id, CAST(date as TIME)as transaction_time, amount AS seventonine_amount
FROM transaction
WHERE CAST(date as TIME) BETWEEN '07:00:00' AND '09:00:00' 
AND amount < 2.00
GROUP BY transaction_id
ORDER BY amount DESC
;

SELECT COUNT(seventonine_amount) FROM transactions_7to9;

--Number of transactions with amount less than $2.00 between 9:01 to 6:59am

DROP VIEW if exists transactions_9to6;

CREATE VIEW transactions_9to6 AS

SELECT transaction_id, CAST(date as TIME)as transaction_time, amount AS ninetosix_amount
FROM transaction
WHERE CAST(date as TIME) BETWEEN '09:01:00' AND '06:59:00' 
AND amount < 2.00
GROUP BY transaction_id
ORDER BY transaction_time DESC
;

SELECT COUNT(ninetosix_amount) FROM transactions_9to6;

--Answer:  Number of transaction during 7AM to 9AM with amount less than $2.00 is 30 vs. number of 
--transaction during 9:01 to 6:59AM with amount less than $2.00 is 0. Hence, yes.

--If you answered yes to the previous question, explain why you think 
--there might be fraudulent transactions during this time frame.

--Answer:  The transactions made in the early hours may or may not be fraudulent. Further information is 
--required to reach a conlcusion.

-- What are the top 5 merchants prone to being hacked using small transactions?

DROP VIEW if exists top5_merchants;

CREATE VIEW top5_merchants AS

SELECT transaction_id, CAST(date as TIME)as transaction_time, 
amount AS seventonine_amount, 
b.name AS merchant_name,
c.name AS merchant_type
FROM transaction as a
JOIN merchant AS b ON a.merchant_id = b.merchant_id
JOIN merchant_category AS c ON b.merchant_category_id = c.merchant_category_id
WHERE CAST(date as TIME) BETWEEN '07:00:00' AND '09:00:00' 
AND amount < 2.00
GROUP BY transaction_id, b.name, c.name
ORDER BY amount DESC
LIMIT 5
;

SELECT * FROM top5_merchants;

--It is likely that majority of these transactions are coffee purchases that ranges from ($0.50 - $2.00USD)
--in the morning between 7-9am.  Looking at the Top 5 Merchants and Merchant type, it is evident that
--cardholders are visiting restaurants or bars to grab a coffee before the workday starts.  But this does
--seems to be an ideal time to run a small transaction to check if the cardholder would notice a small
--small transaction similar to a coffee charge.  For fraudster this seems to be an ideal time to check the
--validity of the card as well as the laxness with which the cardholder reviews the card transactions.

--QUERIES for JUPYTER NOTEBOOK: Data Analysis Part 2
--Question 1

SELECT 
	a.cardholder_id, a.name, 
	b.card, 
	c.transaction_id, c.date, c.amount,
	d.merchant_id, d.name, 
	e.merchant_category_id, e.name
FROM card_holder AS a
JOIN credit_card AS b ON a.cardholder_id = b.cardholder_id
JOIN transaction AS c ON b.card = c.card
JOIN merchant AS d ON c.merchant_id = d.merchant_id
JOIN merchant_category AS e ON d.merchant_category_id = e.merchant_category_id
WHERE a.cardholder_id = 2 OR a.cardholder_id = 18
GROUP BY a.cardholder_id, b.card, c.transaction_id, d.merchant_id, e.merchant_category_id
ORDER BY a.cardholder_id
;

--Question 2

SELECT 
	a.cardholder_id, a.name, 
	b.card, 
	c.transaction_id, c.date, c.amount,
	d.merchant_id, d.name, 
	e.merchant_category_id, e.name
FROM card_holder AS a
JOIN credit_card AS b ON a.cardholder_id = b.cardholder_id
JOIN transaction AS c ON b.card = c.card
JOIN merchant AS d ON c.merchant_id = d.merchant_id
JOIN merchant_category AS e ON d.merchant_category_id = e.merchant_category_id
WHERE a.cardholder_id = 25
AND CAST(c.date as DATE) BETWEEN '2018-01-01' AND '2018-06-30' 
GROUP BY a.cardholder_id, b.card, c.transaction_id, d.merchant_id, e.merchant_category_id
ORDER BY c.date
;
