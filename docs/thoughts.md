**Motivation?**

Most organizations have database schemas that grow large and complex over the years.

Analytics people have to develop complex data-wrangling queries, which takes a lot of time. 

Also, humans do not have full knowledge of SQL constraints, 

Can we be more specific about the problem?

	Dealing with timestamps is difficult.
	At times you have modify the fields names before showing it to the end user.
	you have to do multiple joins.
	Queries can become slow. 
	i do not fully understand the capabilities of SQL
	

**Abstract solution?**

What are the questions that I need to understand about LLMS?

1> Can the LLM, know the database schema? Can it remember the schema and answer questions about it? 

2>  

The more technical solution?

Small working POC?

Let's create a dummy database entity for restaurant billing.

1) Products

2) Employee

3) invoice

Customer ID FK (UUID)

Invoice ID  (UUID)

4) Product category

Id (UUID)

Name (string)

5) Orders

ID (UUID)

6) Customers

7) Invoice line 

Invoice line ID (UUID)

Invoice ID FK (UUID)

Product ID FK (UUID)

Amount     (double)

Unit price  (numeric decial)

Total price (numeric decial)

8)  

Logs of meeting

2024-10-26T17:49:47Z
Discussion:-  Felipe, showed his present tool. (Datasquirell)
			  Rahul, Presented his ideas around real life problem and his motivation to work on POC.
			  Initiated creation of a testing setup for the tool.


Next steps:- Rahul to improve the table generation script (p0)
	Write a real life txns generation script (p0)
	Write a real life mocking read load generation. (p1)

	Felipe:- Improve the data scientist
	Add support for joining tables on his tables.
	Final PDF report. Add cover page. Reduce long tables, improve font. 




Rusty 

https://speechnotes.co/