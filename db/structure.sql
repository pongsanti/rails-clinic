--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE appointments (
    id integer NOT NULL,
    date date,
    "time" time without time zone,
    exam_id integer,
    note character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE appointments_id_seq OWNED BY appointments.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE clients (
    id integer NOT NULL,
    name character varying,
    description text,
    display_name character varying,
    owner_name character varying,
    owner_surname character varying,
    email character varying,
    address character varying,
    sub_district character varying,
    district character varying,
    province character varying,
    postal_code character varying,
    home_phone_no character varying,
    mobile_phone_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    subdomain character varying,
    settings hstore
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE customers (
    id integer NOT NULL,
    cn character varying NOT NULL,
    name character varying,
    surname character varying,
    sex character varying,
    id_card_no character varying,
    passport_no character varying,
    birthdate date,
    address character varying,
    sub_district character varying,
    district character varying,
    province character varying,
    postal_code character varying,
    occupation character varying,
    tel_no character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    prefix_id integer,
    home_phone_no character varying,
    nationality character varying,
    email character varying,
    deleted_at timestamp without time zone,
    street character varying
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: diags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE diags (
    id integer NOT NULL,
    name character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: diags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE diags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE diags_id_seq OWNED BY diags.id;


--
-- Name: drug_ins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE drug_ins (
    id integer NOT NULL,
    expired_date date,
    cost numeric(8,2),
    sale_price_per_unit numeric(8,2),
    balance integer,
    drug_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: drug_ins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE drug_ins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drug_ins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE drug_ins_id_seq OWNED BY drug_ins.id;


--
-- Name: drug_movements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE drug_movements (
    id integer NOT NULL,
    balance numeric,
    prev_bal numeric,
    note character varying,
    drug_in_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    patient_drug_id integer
);


--
-- Name: drug_movements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE drug_movements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drug_movements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE drug_movements_id_seq OWNED BY drug_movements.id;


--
-- Name: drug_usages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE drug_usages (
    id integer NOT NULL,
    code character varying,
    text character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    times_per_day integer,
    use_amount numeric(4,1),
    deleted_at timestamp without time zone
);


--
-- Name: drug_usages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE drug_usages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drug_usages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE drug_usages_id_seq OWNED BY drug_usages.id;


--
-- Name: drugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE drugs (
    id integer NOT NULL,
    name text,
    trade_name text,
    effect text,
    balance integer,
    drug_usage_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    store_unit_id integer,
    concern character varying,
    deleted_at timestamp without time zone
);


--
-- Name: drugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE drugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE drugs_id_seq OWNED BY drugs.id;


--
-- Name: exams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exams (
    id integer NOT NULL,
    weight numeric,
    height numeric,
    bp_systolic integer,
    bp_diastolic integer,
    pulse integer,
    drug_allergy text,
    note text,
    exam_pi text,
    exam_pe text,
    exam_note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    customer_id integer,
    examiner_id integer,
    revenue numeric(9,2),
    paid_status boolean
);


--
-- Name: exams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE exams_id_seq OWNED BY exams.id;


--
-- Name: patient_diags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE patient_diags (
    id integer NOT NULL,
    exam_id integer,
    diag_id integer,
    "order" integer,
    note character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: patient_diags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patient_diags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patient_diags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patient_diags_id_seq OWNED BY patient_diags.id;


--
-- Name: patient_drugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE patient_drugs (
    id integer NOT NULL,
    exam_id integer,
    drug_in_id integer,
    drug_usage_id integer,
    amount numeric(4,1),
    revenue numeric(9,2),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: patient_drugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE patient_drugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patient_drugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE patient_drugs_id_seq OWNED BY patient_drugs.id;


--
-- Name: prefixes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE prefixes (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sex character varying
);


--
-- Name: prefixes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prefixes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prefixes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prefixes_id_seq OWNED BY prefixes.id;


--
-- Name: qs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE qs (
    id integer NOT NULL,
    category character varying,
    exam_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean
);


--
-- Name: qs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE qs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: qs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE qs_id_seq OWNED BY qs.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: store_units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE store_units (
    id integer NOT NULL,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: store_units_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE store_units_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: store_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE store_units_id_seq OWNED BY store_units.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    client_id integer,
    display_name character varying,
    roles_mask integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY appointments ALTER COLUMN id SET DEFAULT nextval('appointments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY diags ALTER COLUMN id SET DEFAULT nextval('diags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_ins ALTER COLUMN id SET DEFAULT nextval('drug_ins_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_movements ALTER COLUMN id SET DEFAULT nextval('drug_movements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_usages ALTER COLUMN id SET DEFAULT nextval('drug_usages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY drugs ALTER COLUMN id SET DEFAULT nextval('drugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY exams ALTER COLUMN id SET DEFAULT nextval('exams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_diags ALTER COLUMN id SET DEFAULT nextval('patient_diags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_drugs ALTER COLUMN id SET DEFAULT nextval('patient_drugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY prefixes ALTER COLUMN id SET DEFAULT nextval('prefixes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY qs ALTER COLUMN id SET DEFAULT nextval('qs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY store_units ALTER COLUMN id SET DEFAULT nextval('store_units_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: diags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY diags
    ADD CONSTRAINT diags_pkey PRIMARY KEY (id);


--
-- Name: drug_ins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_ins
    ADD CONSTRAINT drug_ins_pkey PRIMARY KEY (id);


--
-- Name: drug_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_movements
    ADD CONSTRAINT drug_movements_pkey PRIMARY KEY (id);


--
-- Name: drug_usages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_usages
    ADD CONSTRAINT drug_usages_pkey PRIMARY KEY (id);


--
-- Name: drugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drugs
    ADD CONSTRAINT drugs_pkey PRIMARY KEY (id);


--
-- Name: exams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (id);


--
-- Name: patient_diags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_diags
    ADD CONSTRAINT patient_diags_pkey PRIMARY KEY (id);


--
-- Name: patient_drugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_drugs
    ADD CONSTRAINT patient_drugs_pkey PRIMARY KEY (id);


--
-- Name: prefixes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (id);


--
-- Name: qs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY qs
    ADD CONSTRAINT qs_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: store_units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY store_units
    ADD CONSTRAINT store_units_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_appointments_on_exam_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_appointments_on_exam_id ON appointments USING btree (exam_id);


--
-- Name: index_clients_on_settings; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_clients_on_settings ON clients USING gist (settings);


--
-- Name: index_customers_on_cn; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_customers_on_cn ON customers USING btree (cn);


--
-- Name: index_customers_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customers_on_deleted_at ON customers USING btree (deleted_at);


--
-- Name: index_customers_on_prefix_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_customers_on_prefix_id ON customers USING btree (prefix_id);


--
-- Name: index_diags_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diags_on_deleted_at ON diags USING btree (deleted_at);


--
-- Name: index_drug_ins_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drug_ins_on_deleted_at ON drug_ins USING btree (deleted_at);


--
-- Name: index_drug_ins_on_drug_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drug_ins_on_drug_id ON drug_ins USING btree (drug_id);


--
-- Name: index_drug_movements_on_drug_in_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drug_movements_on_drug_in_id ON drug_movements USING btree (drug_in_id);


--
-- Name: index_drug_movements_on_patient_drug_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drug_movements_on_patient_drug_id ON drug_movements USING btree (patient_drug_id);


--
-- Name: index_drug_usages_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drug_usages_on_deleted_at ON drug_usages USING btree (deleted_at);


--
-- Name: index_drugs_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drugs_on_deleted_at ON drugs USING btree (deleted_at);


--
-- Name: index_drugs_on_drug_usage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drugs_on_drug_usage_id ON drugs USING btree (drug_usage_id);


--
-- Name: index_drugs_on_store_unit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drugs_on_store_unit_id ON drugs USING btree (store_unit_id);


--
-- Name: index_exams_on_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exams_on_customer_id ON exams USING btree (customer_id);


--
-- Name: index_exams_on_examiner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_exams_on_examiner_id ON exams USING btree (examiner_id);


--
-- Name: index_patient_diags_on_diag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_diags_on_diag_id ON patient_diags USING btree (diag_id);


--
-- Name: index_patient_diags_on_exam_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_diags_on_exam_id ON patient_diags USING btree (exam_id);


--
-- Name: index_patient_drugs_on_drug_in_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_drugs_on_drug_in_id ON patient_drugs USING btree (drug_in_id);


--
-- Name: index_patient_drugs_on_drug_usage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_drugs_on_drug_usage_id ON patient_drugs USING btree (drug_usage_id);


--
-- Name: index_patient_drugs_on_exam_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_drugs_on_exam_id ON patient_drugs USING btree (exam_id);


--
-- Name: index_qs_on_exam_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_qs_on_exam_id ON qs USING btree (exam_id);


--
-- Name: index_store_units_on_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_store_units_on_deleted_at ON store_units USING btree (deleted_at);


--
-- Name: index_users_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_client_id ON users USING btree (client_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_0397db7555; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT fk_rails_0397db7555 FOREIGN KEY (prefix_id) REFERENCES prefixes(id);


--
-- Name: fk_rails_0426c6a005; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY appointments
    ADD CONSTRAINT fk_rails_0426c6a005 FOREIGN KEY (exam_id) REFERENCES exams(id);


--
-- Name: fk_rails_4bd6ca3ccd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_drugs
    ADD CONSTRAINT fk_rails_4bd6ca3ccd FOREIGN KEY (drug_usage_id) REFERENCES drug_usages(id);


--
-- Name: fk_rails_668698c2b3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_movements
    ADD CONSTRAINT fk_rails_668698c2b3 FOREIGN KEY (drug_in_id) REFERENCES drug_ins(id);


--
-- Name: fk_rails_72913c5165; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_diags
    ADD CONSTRAINT fk_rails_72913c5165 FOREIGN KEY (exam_id) REFERENCES exams(id);


--
-- Name: fk_rails_80c788af15; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_drugs
    ADD CONSTRAINT fk_rails_80c788af15 FOREIGN KEY (exam_id) REFERENCES exams(id);


--
-- Name: fk_rails_945291cfbc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_ins
    ADD CONSTRAINT fk_rails_945291cfbc FOREIGN KEY (drug_id) REFERENCES drugs(id);


--
-- Name: fk_rails_a8e046e513; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drugs
    ADD CONSTRAINT fk_rails_a8e046e513 FOREIGN KEY (store_unit_id) REFERENCES store_units(id);


--
-- Name: fk_rails_b6153fbd2d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT fk_rails_b6153fbd2d FOREIGN KEY (examiner_id) REFERENCES users(id);


--
-- Name: fk_rails_c7c3966cf4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_diags
    ADD CONSTRAINT fk_rails_c7c3966cf4 FOREIGN KEY (diag_id) REFERENCES diags(id);


--
-- Name: fk_rails_c7d111fae3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exams
    ADD CONSTRAINT fk_rails_c7d111fae3 FOREIGN KEY (customer_id) REFERENCES customers(id);


--
-- Name: fk_rails_d033e98e2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY qs
    ADD CONSTRAINT fk_rails_d033e98e2c FOREIGN KEY (exam_id) REFERENCES exams(id);


--
-- Name: fk_rails_d3559eaf4c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_rails_d3559eaf4c FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- Name: fk_rails_e262d4e501; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY patient_drugs
    ADD CONSTRAINT fk_rails_e262d4e501 FOREIGN KEY (drug_in_id) REFERENCES drug_ins(id);


--
-- Name: fk_rails_e2632dca88; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drugs
    ADD CONSTRAINT fk_rails_e2632dca88 FOREIGN KEY (drug_usage_id) REFERENCES drug_usages(id);


--
-- Name: fk_rails_fd5434ec28; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drug_movements
    ADD CONSTRAINT fk_rails_fd5434ec28 FOREIGN KEY (patient_drug_id) REFERENCES patient_drugs(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "public";

INSERT INTO schema_migrations (version) VALUES ('20160403093259');

INSERT INTO schema_migrations (version) VALUES ('20160405154453');

INSERT INTO schema_migrations (version) VALUES ('20160405161030');

INSERT INTO schema_migrations (version) VALUES ('20160405161154');

INSERT INTO schema_migrations (version) VALUES ('20160429091817');

INSERT INTO schema_migrations (version) VALUES ('20160503161514');

INSERT INTO schema_migrations (version) VALUES ('20160506133931');

INSERT INTO schema_migrations (version) VALUES ('20160520150418');

INSERT INTO schema_migrations (version) VALUES ('20160520150710');

INSERT INTO schema_migrations (version) VALUES ('20160521135339');

INSERT INTO schema_migrations (version) VALUES ('20160523142928');

INSERT INTO schema_migrations (version) VALUES ('20160523162800');

INSERT INTO schema_migrations (version) VALUES ('20160526135901');

INSERT INTO schema_migrations (version) VALUES ('20160601143911');

INSERT INTO schema_migrations (version) VALUES ('20160621152743');

INSERT INTO schema_migrations (version) VALUES ('20160621161207');

INSERT INTO schema_migrations (version) VALUES ('20160622131533');

INSERT INTO schema_migrations (version) VALUES ('20160701160124');

INSERT INTO schema_migrations (version) VALUES ('20160702001428');

INSERT INTO schema_migrations (version) VALUES ('20160706023525');

INSERT INTO schema_migrations (version) VALUES ('20160718160911');

INSERT INTO schema_migrations (version) VALUES ('20160720024927');

INSERT INTO schema_migrations (version) VALUES ('20160825125104');

INSERT INTO schema_migrations (version) VALUES ('20160826162644');

INSERT INTO schema_migrations (version) VALUES ('20160905072713');

INSERT INTO schema_migrations (version) VALUES ('20160907055302');

INSERT INTO schema_migrations (version) VALUES ('20160908084239');

INSERT INTO schema_migrations (version) VALUES ('20160912040827');

INSERT INTO schema_migrations (version) VALUES ('20160912152818');

INSERT INTO schema_migrations (version) VALUES ('20160918124637');

INSERT INTO schema_migrations (version) VALUES ('20160920064841');

INSERT INTO schema_migrations (version) VALUES ('20160920081154');

INSERT INTO schema_migrations (version) VALUES ('20160920110710');

INSERT INTO schema_migrations (version) VALUES ('20160921104457');

INSERT INTO schema_migrations (version) VALUES ('20160922074900');

INSERT INTO schema_migrations (version) VALUES ('20160923094558');

INSERT INTO schema_migrations (version) VALUES ('20160923100011');

INSERT INTO schema_migrations (version) VALUES ('20160927160359');

INSERT INTO schema_migrations (version) VALUES ('20160927161323');

INSERT INTO schema_migrations (version) VALUES ('20160929133135');

INSERT INTO schema_migrations (version) VALUES ('20160929140944');

INSERT INTO schema_migrations (version) VALUES ('20161001051937');

INSERT INTO schema_migrations (version) VALUES ('20161002170823');

INSERT INTO schema_migrations (version) VALUES ('20161005101549');

INSERT INTO schema_migrations (version) VALUES ('20161005102800');

