
\restrict KNG2YZ3RFAuZap9eDexdf9lzIwNCcmAjJMyoW141goB12F5Yh8i77jAvr2YZF1f

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

ALTER ROLE "anon" SET "statement_timeout" TO '3s';

ALTER ROLE "authenticated" SET "statement_timeout" TO '8s';

ALTER ROLE "authenticator" SET "statement_timeout" TO '8s';

\unrestrict KNG2YZ3RFAuZap9eDexdf9lzIwNCcmAjJMyoW141goB12F5Yh8i77jAvr2YZF1f

RESET ALL;
