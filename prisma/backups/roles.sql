
\restrict Indf7i1eE2VdYsg3dc6rUo5aZ3P1chLYbyFe14Ok0AibVj1hwyahCDpjeTZH9Me

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

ALTER ROLE "anon" SET "statement_timeout" TO '3s';

ALTER ROLE "authenticated" SET "statement_timeout" TO '8s';

ALTER ROLE "authenticator" SET "statement_timeout" TO '8s';

\unrestrict Indf7i1eE2VdYsg3dc6rUo5aZ3P1chLYbyFe14Ok0AibVj1hwyahCDpjeTZH9Me

RESET ALL;
