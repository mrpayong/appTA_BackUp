
\restrict uBZK1PbmobL8HhGrqAt7xc6pO6E4rvsmdYhkUzP3Z4IgZOBxwvfoP32pHS5e70L

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

ALTER ROLE "anon" SET "statement_timeout" TO '3s';

ALTER ROLE "authenticated" SET "statement_timeout" TO '8s';

ALTER ROLE "authenticator" SET "statement_timeout" TO '8s';

\unrestrict uBZK1PbmobL8HhGrqAt7xc6pO6E4rvsmdYhkUzP3Z4IgZOBxwvfoP32pHS5e70L

RESET ALL;
