
\restrict RKppBVT8S6GdjGe4pojs0AlpBSU9vFcmWjxMOA8ELko2bAoaCzON2h2erJ862EV

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

ALTER ROLE "anon" SET "statement_timeout" TO '3s';

ALTER ROLE "authenticated" SET "statement_timeout" TO '8s';

ALTER ROLE "authenticator" SET "statement_timeout" TO '8s';

\unrestrict RKppBVT8S6GdjGe4pojs0AlpBSU9vFcmWjxMOA8ELko2bAoaCzON2h2erJ862EV

RESET ALL;
