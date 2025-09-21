
\restrict HNZrevKD6edU7kx3ZoH2r9aJMwAzC0tujhTHXp99rccDBFchLD1FWMJl6dzaM7R

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

ALTER ROLE "anon" SET "statement_timeout" TO '3s';

ALTER ROLE "authenticated" SET "statement_timeout" TO '8s';

ALTER ROLE "authenticator" SET "statement_timeout" TO '8s';

\unrestrict HNZrevKD6edU7kx3ZoH2r9aJMwAzC0tujhTHXp99rccDBFchLD1FWMJl6dzaM7R

RESET ALL;
