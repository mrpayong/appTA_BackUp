

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pgsodium";








ALTER SCHEMA "public" OWNER TO "postgres";


CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."AccountType" AS ENUM (
    'INCORPORATION',
    'PARTNERSHIP',
    'COOPERATIVE',
    'ASSOCIATION',
    'CORPORATION',
    'FREELANCE',
    'PROFESSIONAL',
    'SOLEPROPRIETORSHIP',
    'OTHERS'
);


ALTER TYPE "public"."AccountType" OWNER TO "postgres";


CREATE TYPE "public"."CashFlowPeriod" AS ENUM (
    'DAILY',
    'WEEKLY',
    'MONTHLY',
    'SEMI_ANNUAL',
    'QUARTERLY',
    'ANNUAL',
    'FISCAL_YEAR'
);


ALTER TYPE "public"."CashFlowPeriod" OWNER TO "postgres";


CREATE TYPE "public"."RecurringInterval" AS ENUM (
    'DAILY',
    'WEEKLY',
    'MONTHLY',
    'YEARLY'
);


ALTER TYPE "public"."RecurringInterval" OWNER TO "postgres";


CREATE TYPE "public"."TaskStatus" AS ENUM (
    'COMPLETED',
    'PROGRESS',
    'PLANNING',
    'RESEARCH'
);


ALTER TYPE "public"."TaskStatus" OWNER TO "postgres";


CREATE TYPE "public"."TransactionType" AS ENUM (
    'INCOME',
    'EXPENSE'
);


ALTER TYPE "public"."TransactionType" OWNER TO "postgres";


CREATE TYPE "public"."UrgencyLevel" AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH'
);


ALTER TYPE "public"."UrgencyLevel" OWNER TO "postgres";


CREATE TYPE "public"."UserRole" AS ENUM (
    'USER',
    'ADMIN',
    'STAFF',
    'SYSADMIN'
);


ALTER TYPE "public"."UserRole" OWNER TO "postgres";


CREATE TYPE "public"."activityType" AS ENUM (
    'OPERATION',
    'INVESTMENT',
    'FINANCING'
);


ALTER TYPE "public"."activityType" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."ActivityLog" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "action" "text" NOT NULL,
    "meta" "jsonb",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."ActivityLog" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."Cashflow" (
    "id" "text" NOT NULL,
    "netChange" double precision NOT NULL,
    "startBalance" double precision NOT NULL,
    "endBalance" double precision NOT NULL,
    "description" "text",
    "date" timestamp(3) without time zone NOT NULL,
    "userId" "text" NOT NULL,
    "accountId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "activityTotal" double precision[],
    "periodCashFlow" "public"."CashFlowPeriod" DEFAULT 'DAILY'::"public"."CashFlowPeriod" NOT NULL
);


ALTER TABLE "public"."Cashflow" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."_TransactionToCashflow" (
    "A" "text" NOT NULL,
    "B" "text" NOT NULL
);


ALTER TABLE "public"."_TransactionToCashflow" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."_prisma_migrations" (
    "id" character varying(36) NOT NULL,
    "checksum" character varying(64) NOT NULL,
    "finished_at" timestamp with time zone,
    "migration_name" character varying(255) NOT NULL,
    "logs" "text",
    "rolled_back_at" timestamp with time zone,
    "started_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "applied_steps_count" integer DEFAULT 0 NOT NULL
);


ALTER TABLE "public"."_prisma_migrations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."accounts" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "type" "public"."AccountType" NOT NULL,
    "userId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "birthDate" timestamp(3) without time zone NOT NULL,
    "branchCount" integer,
    "businessLine" "text" NOT NULL,
    "contactNumber" character varying(11) NOT NULL,
    "email" "text" NOT NULL,
    "isHeadOffice" boolean DEFAULT false NOT NULL,
    "owner" "text" NOT NULL,
    "city" "text" NOT NULL,
    "isIndividual" boolean DEFAULT false NOT NULL,
    "province" "text" NOT NULL,
    "region" "text" NOT NULL,
    "street" "text" NOT NULL,
    "town" "text" NOT NULL,
    "zip" "text" NOT NULL,
    "RDO" "text" NOT NULL,
    "tin" integer[],
    "buildingNumber" "text" NOT NULL
);


ALTER TABLE "public"."accounts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."archives" (
    "id" "text" NOT NULL,
    "userId" "text" NOT NULL,
    "action" "text" NOT NULL,
    "entityType" "text" NOT NULL,
    "entityId" "text" NOT NULL,
    "data" "jsonb" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "accountId" "text"
);


ALTER TABLE "public"."archives" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."cashflow_sub_accounts" (
    "cashFlowId" "text" NOT NULL,
    "subAccountId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "assignedBy" "text"
);


ALTER TABLE "public"."cashflow_sub_accounts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sub_account_relations" (
    "id" "text" NOT NULL,
    "parentId" "text",
    "childId" "text" NOT NULL,
    "relationName" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE "public"."sub_account_relations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sub_account_transactions" (
    "subAccountId" "text" NOT NULL,
    "transactionId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE "public"."sub_account_transactions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."sub_accounts" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "description" "text",
    "balance" numeric(65,30),
    "accountId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE "public"."sub_accounts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tasks" (
    "id" "text" NOT NULL,
    "taskName" "text" NOT NULL,
    "taskDescription" "text",
    "taskCategory" "text" NOT NULL,
    "urgency" "public"."UrgencyLevel" DEFAULT 'MEDIUM'::"public"."UrgencyLevel" NOT NULL,
    "dueDate" timestamp(3) without time zone NOT NULL,
    "userId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone
);


ALTER TABLE "public"."tasks" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."transactions" (
    "id" "text" NOT NULL,
    "type" "public"."TransactionType" NOT NULL,
    "amount" numeric(65,30) NOT NULL,
    "description" "text",
    "date" timestamp(3) without time zone NOT NULL,
    "category" "text" NOT NULL,
    "receiptUrl" "text",
    "Activity" "public"."activityType" NOT NULL,
    "isRecurring" boolean DEFAULT false NOT NULL,
    "recurringInterval" "public"."RecurringInterval",
    "nextRecurringDate" timestamp(3) without time zone,
    "lastProcessed" timestamp(3) without time zone,
    "userId" "text" NOT NULL,
    "accountId" "text" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "refNumber" "text" NOT NULL,
    "particular" "text",
    "printNumber" "text" NOT NULL
);


ALTER TABLE "public"."transactions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" "text" NOT NULL,
    "clerkUserId" "text" NOT NULL,
    "email" "text" NOT NULL,
    "imageUrl" "text",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "role" "public"."UserRole" DEFAULT 'USER'::"public"."UserRole" NOT NULL,
    "Fname" "text" NOT NULL,
    "Lname" "text" NOT NULL,
    "username" "text" NOT NULL
);


ALTER TABLE "public"."users" OWNER TO "postgres";


ALTER TABLE ONLY "public"."ActivityLog"
    ADD CONSTRAINT "ActivityLog_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."Cashflow"
    ADD CONSTRAINT "Cashflow_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."_TransactionToCashflow"
    ADD CONSTRAINT "_TransactionToCashflow_AB_pkey" PRIMARY KEY ("A", "B");



ALTER TABLE ONLY "public"."_prisma_migrations"
    ADD CONSTRAINT "_prisma_migrations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."archives"
    ADD CONSTRAINT "archives_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cashflow_sub_accounts"
    ADD CONSTRAINT "cashflow_sub_accounts_pkey" PRIMARY KEY ("cashFlowId", "subAccountId");



ALTER TABLE ONLY "public"."sub_account_relations"
    ADD CONSTRAINT "sub_account_relations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."sub_account_transactions"
    ADD CONSTRAINT "sub_account_transactions_pkey" PRIMARY KEY ("subAccountId", "transactionId");



ALTER TABLE ONLY "public"."sub_accounts"
    ADD CONSTRAINT "sub_accounts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



CREATE INDEX "Cashflow_accountId_idx" ON "public"."Cashflow" USING "btree" ("accountId");



CREATE INDEX "Cashflow_id_idx" ON "public"."Cashflow" USING "btree" ("id");



CREATE UNIQUE INDEX "Cashflow_id_key" ON "public"."Cashflow" USING "btree" ("id");



CREATE INDEX "Cashflow_userId_idx" ON "public"."Cashflow" USING "btree" ("userId");



CREATE INDEX "_TransactionToCashflow_B_index" ON "public"."_TransactionToCashflow" USING "btree" ("B");



CREATE UNIQUE INDEX "accounts_name_key" ON "public"."accounts" USING "btree" ("name");



CREATE INDEX "accounts_userId_idx" ON "public"."accounts" USING "btree" ("userId");



CREATE INDEX "archives_accountId_idx" ON "public"."archives" USING "btree" ("accountId");



CREATE INDEX "archives_userId_idx" ON "public"."archives" USING "btree" ("userId");



CREATE INDEX "sub_account_relations_childId_idx" ON "public"."sub_account_relations" USING "btree" ("childId");



CREATE INDEX "sub_account_relations_parentId_idx" ON "public"."sub_account_relations" USING "btree" ("parentId");



CREATE INDEX "sub_accounts_accountId_idx" ON "public"."sub_accounts" USING "btree" ("accountId");



CREATE UNIQUE INDEX "sub_accounts_id_key" ON "public"."sub_accounts" USING "btree" ("id");



CREATE INDEX "tasks_userId_idx" ON "public"."tasks" USING "btree" ("userId");



CREATE INDEX "transactions_accountId_idx" ON "public"."transactions" USING "btree" ("accountId");



CREATE UNIQUE INDEX "transactions_refNumber_key" ON "public"."transactions" USING "btree" ("refNumber");



CREATE INDEX "transactions_userId_idx" ON "public"."transactions" USING "btree" ("userId");



CREATE UNIQUE INDEX "users_clerkUserId_key" ON "public"."users" USING "btree" ("clerkUserId");



CREATE UNIQUE INDEX "users_email_key" ON "public"."users" USING "btree" ("email");



CREATE UNIQUE INDEX "users_username_key" ON "public"."users" USING "btree" ("username");



ALTER TABLE ONLY "public"."ActivityLog"
    ADD CONSTRAINT "ActivityLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."Cashflow"
    ADD CONSTRAINT "Cashflow_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "public"."accounts"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."Cashflow"
    ADD CONSTRAINT "Cashflow_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."_TransactionToCashflow"
    ADD CONSTRAINT "_TransactionToCashflow_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."transactions"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."_TransactionToCashflow"
    ADD CONSTRAINT "_TransactionToCashflow_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."Cashflow"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."archives"
    ADD CONSTRAINT "archives_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "public"."accounts"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."archives"
    ADD CONSTRAINT "archives_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."cashflow_sub_accounts"
    ADD CONSTRAINT "cashflow_sub_accounts_cashFlowId_fkey" FOREIGN KEY ("cashFlowId") REFERENCES "public"."Cashflow"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."cashflow_sub_accounts"
    ADD CONSTRAINT "cashflow_sub_accounts_subAccountId_fkey" FOREIGN KEY ("subAccountId") REFERENCES "public"."sub_accounts"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."sub_account_relations"
    ADD CONSTRAINT "sub_account_relations_childId_fkey" FOREIGN KEY ("childId") REFERENCES "public"."sub_accounts"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."sub_account_relations"
    ADD CONSTRAINT "sub_account_relations_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "public"."sub_accounts"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."sub_account_transactions"
    ADD CONSTRAINT "sub_account_transactions_subAccountId_fkey" FOREIGN KEY ("subAccountId") REFERENCES "public"."sub_accounts"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."sub_account_transactions"
    ADD CONSTRAINT "sub_account_transactions_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "public"."transactions"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."sub_accounts"
    ADD CONSTRAINT "sub_accounts_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "public"."accounts"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."tasks"
    ADD CONSTRAINT "tasks_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "public"."accounts"("id") ON UPDATE CASCADE ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON UPDATE CASCADE ON DELETE RESTRICT;





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


REVOKE USAGE ON SCHEMA "public" FROM PUBLIC;



























































































































































































































RESET ALL;
