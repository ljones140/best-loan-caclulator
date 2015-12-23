# Best Loan Rate Quote Calculator

CLI program which takes a CSV and an amount of requested to borrow. The CSV contains different offers from lenders with the amount
of money they have available and the rate at which they will lend it at.

The Program calculates the best rate available from the pool of lenders for a 36 month loan blending the
interest rate if money has to be taken from multiple lenders. It builds the
quote by taking the money from the best rate lenders first and the higher rate
lenders if more money is required.

The quote is returned with monthly payments and total repayment calculated with
monthly compounded interest.

You can request a quote from £100 to £15000 in multiples of 100. The application will only be able to provide a quote in funds are available in the pool of lenders provided on the CSV.

To run cd into directory.
```sh
./loan_calculator [CSV file] [amount]
```

## Approach

The application was built with a TDD process to explore and learn about the
domain via unit testing. This approach enabled me to create solutions for the
best rate, blended rate and compounded interest calculations in a structured
simple way.

I have used the approach that a unit is a unit of
behaviour rather than an isolated component such as a class. Therefore in the
unit tests the loan_calculator_spec.rb is dependant on the Offer class as their
behaviour as collaborators is a unit.

## CSV format

Your CSV should be in the below format. Rate percentages must be in decimal.

```sh
Lender,Rate,Available
Bob,0.075,640
```

A sample CSV market.csv is provided. This CSV file is also used for the tests.
