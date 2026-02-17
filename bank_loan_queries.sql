                                             --  Bank Loan Analysis  --

CREATE TABLE bank_loan_data (

    id INT PRIMARY KEY,
    address_state        VARCHAR(50),
    application_type     VARCHAR(50),
    emp_length           VARCHAR(50),
    emp_title            VARCHAR(100),
    grade                VARCHAR(50),
    home_ownership       VARCHAR(50),
    issue_date           DATE,
    last_credit_pull_date DATE,
    last_payment_date    DATE,
    loan_status          VARCHAR(50),
    next_payment_date    DATE,
    member_id            INT,
    purpose              VARCHAR(50),
    sub_grade            VARCHAR(50),
    term                 VARCHAR(50),
    verification_status  VARCHAR(50),
    annual_income        NUMERIC(12,2),
    dti                  NUMERIC(6,2),
    installment          NUMERIC(10,2),
    int_rate             NUMERIC(5,2),
    loan_amount          NUMERIC(12,2),
    total_acc            SMALLINT,
    total_payment        NUMERIC(12,2)
);
select * from bank_loan_data

--KPI’s:

--Total Loan Applications

select count(id)as Total_loan_application from bank_loan_data;

--MTD Loan Applications

select count(id)as Total_MTD_application from bank_loan_data
where extract(month from issue_date)=12;

--PMTD Loan Applications

select count(id)as Total_MTD_application from bank_loan_data
where extract(month from issue_date)=11;

--Total Funded Amount

select sum(loan_amount)as total_funded_amt from bank_loan_data;

--MTD Total Funded Amount

select sum(loan_amount)as Total_MTD_fumd from bank_loan_data
where extract(month from issue_date) =12;

--PMTD Total Funded Amount

select sum(loan_amount)as Total_MTD_fumd from bank_loan_data
where extract(month from issue_date) =11;

--Total Amount Received

select sum(total_payment)as total_amt_received from bank_loan_data;

--MTD Total Amount Received

select sum(total_payment)as total_amt_received from bank_loan_data
where extract(month from issue_date) =12;

--PMTD Total Amount Received

select sum(total_payment)as total_amt_received from bank_loan_data
where extract(month from issue_date) =11;

--Average Interest Rate

select round(avg(int_rate)*100,2) as Avg_int_rate from bank_loan_data

--MTD Average Interest 

select round(avg(int_rate)*100,2) from bank_loan_data
where extract(month from issue_date)=12;

--PMTD Average Interest

select round(avg(int_rate)*100,2) from bank_loan_data
where extract(month from issue_date)=11;

--Avg DTI

select round(avg(dti)*100,2)as avg_dti from bank_loan_data

--MTD Avg DTI

select avg(dti)*100 as MTD_avg_dti from bank_loan_data
where extract(month from issue_date)=12;

--PMTD Avg DTI

select avg(dti)*100 as MTD_avg_dti from bank_loan_data
where extract(month from issue_date)=12;

--Good Loan Percentage

select count(
case
when loan_status in('Fully Paid','Current') then id end
)*100/count(id) as Good_loan
from bank_loan_data;

--Good Loan Applications

select count(id)as Good_loan from bank_loan_data
where loan_status in('Fully Paid','Current') ;

--Good Loan Funded Amount

select sum(loan_amount) as Good_loan_amt  from bank_loan_data
where loan_status in('Fully Paid','Current') 

--Good Loan Amount Received

select sum(total_payment) as Good_loan_amt  from bank_loan_data
where loan_status in('Fully Paid','Current') 

                                           --BAD LOAN ISSUED--
--Bad Loan Percentage

select count(id)*100.0/(
select count(id) from bank_loan_data
) as Percentage_bad_loan  from bank_loan_data
where loan_status ='Charged Off' 

--Bad Loan Applications

select count(id) as bad_loan  from bank_loan_data
where loan_status ='Charged Off'

--Bad Loan Funded Amount

select sum(loan_amount) as bad_loan_amt  from bank_loan_data
where loan_status ='Charged Off'

--Bad Loan Amount Received

select sum(total_payment) as bad_loan_amt  from bank_loan_data
where loan_status ='Charged Off'

--LOAN STATUS

select loan_status,
        count(id) as LoanCount,
        sum(total_payment) as Total_Amount_Received,
        sum(loan_amount) as Total_Funded_Amount,
        avg(int_rate * 100) as Interest_Rate,
        avg(dti * 100) as DTI
        from bank_loan_data
    group by loan_status

--MTD
select
	loan_status, 
	sum(total_payment) as MTD_Total_Amount_Received, 
	sum(loan_amount) as MTD_Total_Funded_Amount 
from bank_loan_data
where extract(month from issue_date) = 12 
group by loan_status;

--CHARTS
--Metrics to be shown: 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'

--Monthly Trends by Issue Date

select
	extract(month from issue_date),
	to_char(issue_date,'Month'),
	count(id)as total_loan_appli,
	sum(loan_amount)as total_amount_funded,
	sum(total_payment) as total_amount_reveiced
from bank_loan_data
group by extract(month from issue_date),to_char(issue_date,'Month')
order by extract(month from issue_date);

--Regional Analysis by State 

select 
	address_state,
	count(id)as total_loan_application,
	sum(loan_amount)as total_loan_funded,
	sum(total_payment)as total_amount_received
from bank_loan_data
group by address_state
order by address_state;

--Loan Term Analysis 

select 
	term,
	count(id)as total_loan_application,
	sum(loan_amount)as total_loan_funded,
	sum(total_payment)as total_amount_received
from bank_loan_data
group by term
order by term;

--Employee Length Analysis 

select 
	emp_length,
	count(id)as total_loan_application,
	sum(loan_amount)as total_loan_funded,
	sum(total_payment)as total_amount_received
from bank_loan_data
group by emp_length
order by emp_length;

--Loan Purpose Breakdown 

select 
	purpose,
	count(id)as total_loan_application,
	sum(loan_amount)as total_loan_funded,
	sum(total_payment)as total_amount_received
from bank_loan_data
group by purpose
order by purpose;

--Loan Purpose Breakdown for Grade A

select 
	purpose , 
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Amount_Received
from bank_loan_data
where grade = 'A'
group by purpose
order by purpose;


--Home Ownership Analysis

select 
	home_ownership,
	count(id)as total_loan_application,
	sum(loan_amount)as total_loan_funded,
	sum(total_payment)as total_amount_received
from bank_loan_data
group by home_ownership
order by home_ownership;

                                                    --END--


