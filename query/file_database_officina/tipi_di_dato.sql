CREATE DOMAIN StringNotNull as varchar
	check(value is not null);

CREATE DOMAIN Civico as varchar
	check(value ~ '[0-9]+(/[a-z]+)?');

CREATE DOMAIN CAP as varchar
	check(value ~ '[0-9]{5}' and value is not null); 

CREATE TYPE Indirizzo (
	via StringNotNull,
	civico Civico,
	cap CAP
);
