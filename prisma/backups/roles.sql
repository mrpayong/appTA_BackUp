
\restrict nA4ZY4yMljJ2XubUApUvv5vTK4XWSU87eDVwokKvokic8e6EQ8IPPvuz0gm9Mf5

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

ALTER ROLE "anon" SET "statement_timeout" TO '3s';

ALTER ROLE "authenticated" SET "statement_timeout" TO '8s';

ALTER ROLE "authenticator" SET "statement_timeout" TO '8s';

\unrestrict nA4ZY4yMljJ2XubUApUvv5vTK4XWSU87eDVwokKvokic8e6EQ8IPPvuz0gm9Mf5

RESET ALL;
