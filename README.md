# Fraud_Detection

### Report on Fraudulent Transactions (Data Aalysis Part 1)

This provides an overview of the analysis of fraudulent transactions in a credit card database.

### Assumptions for fraudulent credit card transactions:
* Fraudsters hack a credit card by making several small transactions, generally less than $2.00 which is ignored by cardholders
* Fraudsters make these transaction early in the morning in high frequency between 7-9am
* Certain merchants are prone to being hacked more than others
* Fraudsters charge high value transactions on credit cards that would otherwise be outside of normal transaction type for individual cardholder

#### Transaction under $2.00 on Credit Cards

![No_of_Trns_less_than_2](https://github.com/KSohi-max/Fraud_Detection/blob/main/Images/No_of_Trns_less_than_2.png)

In reviewing the data from the database, it is clear that at least 25 cardholders have had transactions of less than $2.00.  Several of them have had significant number of these small transaction, for example, one cardholder has had 26 transactions on their card. But this analysis in itself is not sufficient to reach the conclusion that these credit cards have been hacked. Further deep dive is necessary.

#### Timing of small (less than $2.00) Transactions

![Top_100_Transns_btwn_7_9am](https://github.com/KSohi-max/Fraud_Detection/blob/main/Images/Transns_btwn_7_9am.png)

Majority of these small amount transactions do occur between 7-9am based on above graph. There are 30 transactions that occur during 7-9AM. These can be considered fraudulent but more information/detail of the transaction is required to be certain.

#### Top 5 Merchant Types with small transactions between 7-9am

![Merchant_Type_v_Transn_Size](https://github.com/KSohi-max/Fraud_Detection/blob/main/Images/Merchant_Type_v_Transn_Size.png)

Looking at the Top 5 merchants with small transactions between the hours of 7 and 9am, all of them fall into the category of either restaurant or bar.  This indicates that majority of these transactions may not necessarily be fraudulent as many people buy coffee (Cost range: $0.50 to $2.00 USD) in the morning before start of work.  

But it is important to note that this time range seems to be an ideal time to run a small transaction to check if the cardholder would notice a transaction similar to a coffee charge.  For fraudster this seems to be an ideal time to check both the validity of the card they want to use as well as the laxness with which the cardholder reviews the card transactions.

### Conclusion

Although above analysis is a good start to determining the criteria for fraudlent transactions, further deep dive is required to determine if fraud is actually taking place and the card has been hacked.  There needs to further analysis of other leading indicators like location/country of merchant or transaction, strange merchant names, etc. rather than lagging ones for credit card transaction.  

Also, it may be prudent to ensure that cardholders regularly check their transacations, transaction types and merchant and report any out of the ordinary transactions that seem suspect. Educating the cardholder may go a long way in reporting fraud. Prevention is the best medicine. 

### Fraudsters charge high value transactions on credit cards (Data Analysis Part 2)

Please see conclusions on this analysis in the Jupyter Notebook:

![visual_data_analysis.ipynb](https://github.com/KSohi-max/Fraud_Detection/blob/main/visual_data_analysis.ipynb)

##### What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? Explain your rationale in the markdown report.

![Transactions for Cardholder 2 & 18 (Year 2018)](https://github.com/KSohi-max/Fraud_Detection/blob/main/Images/Transactions%20for%20Cardholder%202%20%26%2018%20(Year%202018).png)

There doesn't seem to be any difference between the trasaction date and amount in terms of consumption patterns between Cardholder 2 and 18.  The transactions seem to overlap perfectly as is evident from the overlapped graph and the dates and amounts for the two cardholders.  This suggests that multiple cards have been 'hacked' and fraudulent transactions have been run on multiple cards from the database as a test for future fraud charges by fraudsters.

##### Do you notice any anomalies? Describe your observations and conclusions in your markdown report.

![Box Plot for Cardholder 25](https://github.com/KSohi-max/Fraud_Detection/blob/main/Images/Box%20Plot%20for%20Cardholder%2025.png)

There are many extreme outliers or anomalies that lie way outside of majority of the transactions. This does indicate that there were some very large purchases made from January to June, the largest transaction amount occuring in June, 2018.  Further detailed investigation is required to understand these transaction and confirm with cardholder that they are indeed not legitimate purchases.
