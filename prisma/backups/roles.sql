
\restrict Dbosok3P9Yxm6XJZ4g5gFqtP9HQELf5fjDXWvAltQQCfb2V9jHP8LffkPXVfHxf

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

ALTER ROLE "anon" SET "statement_timeout" TO '3s';

ALTER ROLE "authenticated" SET "statement_timeout" TO '8s';

ALTER ROLE "authenticator" SET "statement_timeout" TO '8s';

\unrestrict Dbosok3P9Yxm6XJZ4g5gFqtP9HQELf5fjDXWvAltQQCfb2V9jHP8LffkPXVfHxf

RESET ALL;
