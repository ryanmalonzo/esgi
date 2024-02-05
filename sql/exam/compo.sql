-- q1
select first_name, last_name, iban, numbers
from owners
inner join accounts on owners.id = accounts.owner_id
inner join credit_cards on credit_cards.account_id = accounts.id
order by last_name, first_name;

-- q2
select count(*)
from owners
inner join accounts on owners.id = accounts.owner_id
where iban ilike 'FR76%';

-- q3
select avg(amount)
from transactions
inner join accounts on transactions.recipient_account_id = accounts.id
inner join owners on accounts.owner_id = owners.id
where extract(year from age(current_date, date_of_birth)) <= 25;

-- q4
with nb_transactions_payeurs as (
  select count(*) as ct
  from transactions
  group by sender_account_id
)
select min(ct) 
from nb_transactions_payeurs;

-- q5
with xyz as (
  select last_name, sum(amount) as sm
  from transactions
  inner join accounts on transactions.recipient_account_id = accounts.id
  inner join owners on accounts.owner_id = owners.id
  group by recipient_account_id, last_name
)
select *
from xyz
order by sm desc;

-- q6
with sus1 as (
  select transactions.id
  from transactions
  where amount >= 10000
), sus2 as (
  select transactions.id
  from transactions inner join accounts on transactions.sender_account_id = accounts.id
  where credit_card_id not in (
    select credit_cards.id
    from credit_cards
    where account_id = accounts.id
  )
), sus3 as (
  select transactions.id
  from transactions
  inner join credit_cards on credit_card_id = credit_cards.id
  where current_date >= expiration_date
), sus4 as (
  select transactions.id
  from transactions
  inner join accounts on sender_account_id = accounts.id
  where issued_at >= closing_date
), sus5 as (
  select transactions.id
  from transactions
  where currency <> 'EUR'
), sus6 as (
  select transactions.id
  from transactions
  where sender_account_id = recipient_account_id
)
select count(id)
from transactions
where id in (select * from sus1)
or id in (select * from sus2)
or id in (select * from sus3)
or id in (select * from sus4)
or id in (select * from sus5)
or id in (select * from sus6);

-- q7
with x as (
  select amount, extract(year from issued_at) as year
  from transactions
), y as (
  select sum(amount) sm, year
  from x
  group by year
), z as (
  select rank() over (order by sm desc), year, sm
  from y
)
select * from z;

-- q8
with x as (
  select sum(amount) as received 
  from transactions
  inner join accounts on transactions.recipient_account_id = accounts.id
  inner join owners on accounts.owner_id = owners.id
  where first_name = 'Doriane' and last_name = 'Fernandez'
), y as (
  select sum(amount) as paid 
  from transactions
  inner join accounts on transactions.sender_account_id = accounts.id
  inner join owners on accounts.owner_id = owners.id
  where first_name = 'Doriane' and last_name = 'Fernandez'
)
select received, paid, (received - paid) as diff from x, y;

-- q9
with transactions_rousseau as (
  select amount * -1 as amount, issued_at, 'debit' as operation
  from transactions
  inner join accounts on sender_account_id = accounts.id
  inner join owners on accounts.owner_id = owners.id
  where first_name = 'Fulcran' and last_name = 'Rousseau'
  union all 
  select amount as amount, issued_at, 'credit' as operation
  from transactions
  inner join accounts on recipient_account_id = accounts.id
  inner join owners on accounts.owner_id = owners.id
  where first_name = 'Fulcran' and last_name = 'Rousseau'
)
select *,
sum(amount) over (order by issued_at) as balance,
(coalesce(sum(amount) over (order by issued_at), 0) - amount) as previous_balance
from transactions_rousseau
order by issued_at;
