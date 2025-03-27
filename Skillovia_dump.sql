--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 10.23

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.account (
    id integer NOT NULL,
    user_id integer NOT NULL,
    spark_token_balance integer,
    cash_balance numeric,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.account OWNER TO humaoqjw;

--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_id_seq OWNER TO humaoqjw;

--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- Name: account_user_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.account_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_id_seq OWNER TO humaoqjw;

--
-- Name: account_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.account_user_id_seq OWNED BY public.account.user_id;


--
-- Name: billing_methods; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.billing_methods (
    id integer NOT NULL,
    user_id integer NOT NULL,
    card_number character varying(80) NOT NULL,
    expiry_date character varying(50) NOT NULL,
    cvv character varying(50) NOT NULL,
    address text NOT NULL,
    city character varying(300) NOT NULL,
    postal_code character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.billing_methods OWNER TO humaoqjw;

--
-- Name: billing_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.billing_methods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.billing_methods_id_seq OWNER TO humaoqjw;

--
-- Name: billing_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.billing_methods_id_seq OWNED BY public.billing_methods.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    skills_id integer NOT NULL,
    booking_user_id integer NOT NULL,
    booked_user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    booking_location character varying(500),
    booking_date character varying(50),
    file_url character varying(255),
    status character varying(30) DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.bookings OWNER TO humaoqjw;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_id_seq OWNER TO humaoqjw;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.follows (
    id integer NOT NULL,
    following_id integer NOT NULL,
    follower_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.follows OWNER TO humaoqjw;

--
-- Name: follows_follower_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.follows_follower_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follows_follower_id_seq OWNER TO humaoqjw;

--
-- Name: follows_follower_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.follows_follower_id_seq OWNED BY public.follows.follower_id;


--
-- Name: follows_following_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.follows_following_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follows_following_id_seq OWNER TO humaoqjw;

--
-- Name: follows_following_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.follows_following_id_seq OWNED BY public.follows.following_id;


--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.follows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.follows_id_seq OWNER TO humaoqjw;

--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;


--
-- Name: kyc; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.kyc (
    id integer NOT NULL,
    user_id integer NOT NULL,
    kyc_method character varying(80),
    kyc_id_type character varying(80),
    document_url character varying(255) NOT NULL,
    approval_status character varying(30) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.kyc OWNER TO humaoqjw;

--
-- Name: kyc_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.kyc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kyc_id_seq OWNER TO humaoqjw;

--
-- Name: kyc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.kyc_id_seq OWNED BY public.kyc.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    sender_id integer NOT NULL,
    receiver_id integer NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    mark_as_read boolean DEFAULT false NOT NULL
);


ALTER TABLE public.messages OWNER TO humaoqjw;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO humaoqjw;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(500) NOT NULL,
    description text NOT NULL,
    mark_as_seen character varying(5) DEFAULT 'NO'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notifications OWNER TO humaoqjw;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO humaoqjw;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.password_reset_tokens (
    id integer NOT NULL,
    user_id integer,
    token text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.password_reset_tokens OWNER TO humaoqjw;

--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.password_reset_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.password_reset_tokens_id_seq OWNER TO humaoqjw;

--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;


--
-- Name: refreshtoken; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.refreshtoken (
    id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.refreshtoken OWNER TO humaoqjw;

--
-- Name: refreshtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.refreshtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.refreshtoken_id_seq OWNER TO humaoqjw;

--
-- Name: refreshtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.refreshtoken_id_seq OWNED BY public.refreshtoken.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roles OWNER TO humaoqjw;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO humaoqjw;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.skills (
    id integer NOT NULL,
    user_id integer NOT NULL,
    skill_type character varying(255),
    experience_level character varying(80),
    hourly_rate character varying(10),
    spark_token character varying(10),
    description text NOT NULL,
    approval_status character varying(15) DEFAULT 'draft'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    thumbnail01 character varying(255),
    thumbnail02 character varying(255),
    thumbnail03 character varying(255),
    thumbnail04 character varying(255)
);


ALTER TABLE public.skills OWNER TO humaoqjw;

--
-- Name: skills_category; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.skills_category (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(500),
    thumbnail character varying(255),
    status character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.skills_category OWNER TO humaoqjw;

--
-- Name: skills_category_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.skills_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skills_category_id_seq OWNER TO humaoqjw;

--
-- Name: skills_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.skills_category_id_seq OWNED BY public.skills_category.id;


--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skills_id_seq OWNER TO humaoqjw;

--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: stripe_account; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.stripe_account (
    id integer NOT NULL,
    user_id integer NOT NULL,
    stripe_account_id character varying(255) NOT NULL,
    charges_enabled boolean DEFAULT false NOT NULL,
    payouts_enabled boolean DEFAULT false NOT NULL,
    details_submitted boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.stripe_account OWNER TO humaoqjw;

--
-- Name: stripe_account_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.stripe_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stripe_account_id_seq OWNER TO humaoqjw;

--
-- Name: stripe_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.stripe_account_id_seq OWNED BY public.stripe_account.id;


--
-- Name: suggest_skills; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.suggest_skills (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name text NOT NULL,
    approval_status character varying(30) DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.suggest_skills OWNER TO humaoqjw;

--
-- Name: suggest_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.suggest_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggest_skills_id_seq OWNER TO humaoqjw;

--
-- Name: suggest_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.suggest_skills_id_seq OWNED BY public.suggest_skills.id;


--
-- Name: suggest_skills_user_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.suggest_skills_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggest_skills_user_id_seq OWNER TO humaoqjw;

--
-- Name: suggest_skills_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.suggest_skills_user_id_seq OWNED BY public.suggest_skills.user_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.users (
    id integer NOT NULL,
    phone character varying(15),
    email character varying(255),
    firstname character varying(50),
    lastname character varying(50),
    gender character varying(10),
    password text,
    notification_type character varying(20),
    appearance_mode character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    photourl text,
    google_id character varying(255),
    bio text,
    location character varying(500),
    street character varying(500),
    zip_code character varying(30),
    verification_code character varying(10),
    is_email_verified integer DEFAULT 0,
    lat double precision,
    lon double precision,
    radius double precision,
    location_updated_at character varying(50) DEFAULT CURRENT_TIMESTAMP,
    role_id integer DEFAULT 3 NOT NULL,
    referred_by character varying(50),
    referral_code character varying(50),
    website character varying(200)
);


ALTER TABLE public.users OWNER TO humaoqjw;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO humaoqjw;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: verifyemail; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.verifyemail (
    id integer NOT NULL,
    email character varying(255),
    token character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.verifyemail OWNER TO humaoqjw;

--
-- Name: verifyemail_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.verifyemail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.verifyemail_id_seq OWNER TO humaoqjw;

--
-- Name: verifyemail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.verifyemail_id_seq OWNED BY public.verifyemail.id;


--
-- Name: withdrawal_methods; Type: TABLE; Schema: public; Owner: humaoqjw
--

CREATE TABLE public.withdrawal_methods (
    id integer NOT NULL,
    user_id integer NOT NULL,
    bank_name character varying(255) NOT NULL,
    account_number character varying(100) NOT NULL,
    account_name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.withdrawal_methods OWNER TO humaoqjw;

--
-- Name: withdrawal_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: humaoqjw
--

CREATE SEQUENCE public.withdrawal_methods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.withdrawal_methods_id_seq OWNER TO humaoqjw;

--
-- Name: withdrawal_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: humaoqjw
--

ALTER SEQUENCE public.withdrawal_methods_id_seq OWNED BY public.withdrawal_methods.id;


--
-- Name: account id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- Name: account user_id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.account ALTER COLUMN user_id SET DEFAULT nextval('public.account_user_id_seq'::regclass);


--
-- Name: billing_methods id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.billing_methods ALTER COLUMN id SET DEFAULT nextval('public.billing_methods_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);


--
-- Name: follows following_id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.follows ALTER COLUMN following_id SET DEFAULT nextval('public.follows_following_id_seq'::regclass);


--
-- Name: follows follower_id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.follows ALTER COLUMN follower_id SET DEFAULT nextval('public.follows_follower_id_seq'::regclass);


--
-- Name: kyc id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.kyc ALTER COLUMN id SET DEFAULT nextval('public.kyc_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);


--
-- Name: refreshtoken id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.refreshtoken ALTER COLUMN id SET DEFAULT nextval('public.refreshtoken_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Name: skills_category id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.skills_category ALTER COLUMN id SET DEFAULT nextval('public.skills_category_id_seq'::regclass);


--
-- Name: stripe_account id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.stripe_account ALTER COLUMN id SET DEFAULT nextval('public.stripe_account_id_seq'::regclass);


--
-- Name: suggest_skills id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.suggest_skills ALTER COLUMN id SET DEFAULT nextval('public.suggest_skills_id_seq'::regclass);


--
-- Name: suggest_skills user_id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.suggest_skills ALTER COLUMN user_id SET DEFAULT nextval('public.suggest_skills_user_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: verifyemail id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.verifyemail ALTER COLUMN id SET DEFAULT nextval('public.verifyemail_id_seq'::regclass);


--
-- Name: withdrawal_methods id; Type: DEFAULT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.withdrawal_methods ALTER COLUMN id SET DEFAULT nextval('public.withdrawal_methods_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.account (id, user_id, spark_token_balance, cash_balance, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: billing_methods; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.billing_methods (id, user_id, card_number, expiry_date, cvv, address, city, postal_code, created_at, updated_at) FROM stdin;
1	1	9876537383833773	29-2028	232	73 allen ikeja	lagos	98762	2024-12-31 13:33:02.890913	2024-12-31 13:33:02.890913
5	5	7888009990009900	02/22	287	N0.20 new anglican road	lagos	1290	2025-01-16 23:17:49.11037	2025-01-16 23:17:49.11037
6	1	3333333333333333	03/33	333	123 New Street, enUGU	lagos	1290	2025-01-17 22:35:54.825397	2025-01-17 22:35:54.825397
7	1	9992222222222333	02/22	222	N0.20 anglican Rd, Nsukka	abuja	209	2025-01-17 22:38:48.614479	2025-01-17 22:38:48.614479
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.bookings (id, skills_id, booking_user_id, booked_user_id, title, description, booking_location, booking_date, file_url, status, created_at, updated_at) FROM stdin;
6	18	28	28	Experience Dog Walker Needed	I need a skilled and experienced dog walker to take care of my dog. The walking routine has been disrupted for a few days, and my dog is getting restless. The walks are essential for their exercise and well-being. Additionally, I would like the walker to check on any other needs or concerns for my dog during the walk. Please respond as soon as possible, as this is an urgent matter	New York	2025-02-06	testapi.humanserve.net/routes/uploads/files/1738618329600-355820495.jpeg	accepted	2025-02-03 16:32:09.938968	2025-02-03 16:32:09.938968
15	23	28	30	Booking for Drywall Installation and Repair	Just simple installation and repair...\r\nNothing much	Enugu, nsukka 	2025-02-22	testapi.humanserve.net/routes/uploads/files/1739006630935-938117188.jpg	pending	2025-02-08 04:23:51.126403	2025-02-08 04:23:51.126403
12	19	28	5	Booking for Plumbing	kitchen plumber	Abuja	2025-02-14	testapi.humanserve.net/routes/uploads/files/1738715423779-917450203.jpeg	accepted	2025-02-04 19:30:23.823662	2025-02-04 19:30:23.823662
2	24	28	28	Urgent Plumbing Service Needed	I need a skilled and experienced plumber to fix a leaking pipe in my kitchen. The issue has been ongoing for a few days, and water is starting to seep into the cabinets. The leak is coming from under the sink, and I believe the pipes need to be replaced or sealed properly. Additionally, I need help installing a new faucet and checking for any other plumbing issues in my home. Please respond as soon as possible, as this is an urgent matter.	New York	2025-02-05	testapi.humanserve.net/routes/uploads/files/1738599909600-115807500.jpeg	accepted	2025-02-03 11:25:09.806555	2025-02-03 11:25:09.806555
1	26	28	28	furniture Installations	Do all my furniture installations	72, alen ikeja lagos	15-02-2025	testapi.humanserve.net/routes/uploads/files/1738538811795-895185657.jpeg	accepted	2025-02-02 18:26:51.912297	2025-02-02 18:26:51.912297
3	25	28	28	Booking for House Cleaning	Ah, got it! If you're writing about yourself, you could say:\r\n\r\n"For cleaning my house, I need a broom, mop, vacuum, cleaning cloths, all-purpose cleaner, glass cleaner, disinfectant, trash bags, sponges, and gloves."	Nsukka, Enugu	2025-01-29	testapi.humanserve.net/routes/uploads/files/1738602562893-814210728.jpeg	pending	2025-02-03 12:09:22.967216	2025-02-03 12:09:22.967216
4	24	28	28	Booking for Bathroom Remodeling	for stuff	enugu	2025-02-05	testapi.humanserve.net/routes/uploads/files/1738603047492-926417600.jpeg	pending	2025-02-03 12:17:27.548179	2025-02-03 12:17:27.548179
5	24	28	28	Urgent Dog Walker  needed	I need a skilled and experienced plumber to fix a leaking pipe in my kitchen. The issue has been ongoing for a few days, and water is starting to seep into the cabinets. The leak is coming from under the sink, and I believe the pipes need to be replaced or sealed properly. Additionally, I need help installing a new faucet and checking for any other plumbing issues in my home. Please respond as soon as possible, as this is an urgent matter.	New York	2025-02-05	testapi.humanserve.net/routes/uploads/files/1738617916443-274584522.jpeg	pending	2025-02-03 16:25:16.693489	2025-02-03 16:25:16.693489
7	18	28	1	Experience Dog Walker Needed	I need a skilled and experienced dog walker to take care of my dog. The walking routine has been disrupted for a few days, and my dog is getting restless. The walks are essential for their exercise and well-being. Additionally, I would like the walker to check on any other needs or concerns for my dog during the walk. Please respond as soon as possible, as this is an urgent matter	New York	2025-02-06	testapi.humanserve.net/routes/uploads/files/1738695691957-890967160.jpeg	pending	2025-02-04 14:01:32.007573	2025-02-04 14:01:32.007573
8	18	28	1	Experience Dog Walker Needed	I need a skilled and experienced dog walker to take care of my dog. The walking routine has been disrupted for a few days, and my dog is getting restless. The walks are essential for their exercise and well-being. Additionally, I would like the walker to check on any other needs or concerns for my dog during the walk. Please respond as soon as possible, as this is an urgent matter	New York	2025-02-06	testapi.humanserve.net/routes/uploads/files/1738695720314-890101290.jpeg	pending	2025-02-04 14:02:00.38137	2025-02-04 14:02:00.38137
9	18	28	1	Experience Dog Walker Needed	I need a skilled and experienced dog walker to take care of my dog. The walking routine has been disrupted for a few days, and my dog is getting restless. The walks are essential for their exercise and well-being. Additionally, I would like the walker to check on any other needs or concerns for my dog during the walk. Please respond as soon as possible, as this is an urgent matter	New York	2025-02-06	testapi.humanserve.net/routes/uploads/files/1738695854249-975556969.jpeg	pending	2025-02-04 14:04:14.324058	2025-02-04 14:04:14.324058
10	18	28	1	Dog Care and Walk	just few millmeters	Enugu	2025-02-06	testapi.humanserve.net/routes/uploads/files/1738696026035-506327316.jpeg	pending	2025-02-04 14:07:06.15769	2025-02-04 14:07:06.15769
11	24	28	28	Booking for Bathroom Remodeling	remodellin	enugu	2025-02-14	testapi.humanserve.net/routes/uploads/files/1738715043326-519097264.jpeg	pending	2025-02-04 19:24:03.382212	2025-02-04 19:24:03.382212
13	26	26	28	Booking for Cabinet Installation	I have [mention the type and brand of cabinets, if applicable] that need to be installed in [kitchen, bathroom, office, etc.]. Please let me know if you need any additional details about the cabinet specifications.\r\n\r\nMeasurements & Layout:\r\nThe space where the cabinets will be installed measures approximately [provide dimensions]. If necessary, I can provide drawings or plans for reference.\r\n\r\nOld Cabinet Removal: [Yes / No]\r\n\r\nIf there are existing cabinets, I would like them to be removed before installation.\r\nPlease confirm if you provide disposal services or if I need to arrange for old cabinet removal separately.\r\nInstallation Date & Time:\r\nI would like the installation to be done on [preferred date and time]. Please let me know if this works with your schedule, or suggest the earliest available date.\r\n\r\nAdditional Details:\r\n\r\nI would like the cabinets to be securely installed and leveled properly.\r\nIf any modifications are needed (e.g., cutting for plumbing or electrical access), please let me know in advance.\r\nLet me know if I need to provide any materials, or if you will be bringing everything needed for installation.	Lagos	2025-02-07	testapi.humanserve.net/routes/uploads/files/1738728719741-325117769.jpeg	pending	2025-02-04 23:11:59.875913	2025-02-04 23:11:59.875913
14	24	28	27	Booking for Bathroom Remodeling	just small workkss	odenigbo, Nsukka , Enugu	2025-02-13	testapi.humanserve.net/routes/uploads/files/1738854441568-361244144.png	pending	2025-02-06 10:07:21.676886	2025-02-06 10:07:21.676886
16	24	30	27	Booking for Bathroom Remodeling	i want this service	Ogba, Lagos	2025-02-12	testapi.humanserve.net/routes/uploads/files/1739278200319-902727139.JPG	pending	2025-02-11 07:50:00.451365	2025-02-11 07:50:00.451365
17	23	28	30	Booking for Drywall Installation and Repair	aulex booked 	kano	2025-02-05	testapi.humanserve.net/routes/uploads/files/1739278795608-802599097.jpeg	pending	2025-02-11 07:59:55.718907	2025-02-11 07:59:55.718907
20	24	28	27	Booking for Bathroom Remodeling	oakyy	enugu	2025-03-04	testapi.humanserve.net/routes/uploads/files/1740820299746-483982457.png	pending	2025-03-01 04:11:40.072491	2025-03-01 04:11:40.072491
19	27	43	31	Booking for Plumbing	to repair	14 babs ladipo abulegba	2025-03-01	testapi.humanserve.net/routes/uploads/files/1740773323568-528731815.JPG	pending	2025-02-28 15:08:43.664334	2025-02-28 15:08:43.664334
18	23	43	30	Booking for Drywall Installation and Repair	i need you	14 babs ladipo abulegba	2025-02-16	testapi.humanserve.net/routes/uploads/files/1739739415245-180103685.png	accepted	2025-02-16 15:56:58.975436	2025-02-16 15:56:58.975436
21	24	28	27	Booking for Bathroom Remodeling	hhh	lagos	2025-03-13	testapi.humanserve.net/routes/uploads/files/1740820924280-755200938.png	pending	2025-03-01 04:22:04.557029	2025-03-01 04:22:04.557029
22	27	28	31	Booking for Plumbing	paymennttt	lagos	2025-03-28	testapi.humanserve.net/routes/uploads/files/1740821252577-514893680.png	pending	2025-03-01 04:27:32.942199	2025-03-01 04:27:32.942199
23	27	28	31	Booking for Plumbing	make payment	abj	2025-03-15	testapi.humanserve.net/routes/uploads/files/1740822918936-445387104.png	pending	2025-03-01 04:55:20.580465	2025-03-01 04:55:20.580465
24	30	28	43	Booking for Bathroom Remodeling	jj	delta	2025-03-12	testapi.humanserve.net/routes/uploads/files/1740829228189-317024372.png	accepted	2025-03-01 06:40:29.342175	2025-03-01 06:40:29.342175
25	24	28	27	Booking for Bathroom Remodeling	Nawa oooo	Ijapaaa	2025-03-01	testapi.humanserve.net/routes/uploads/files/1740833857901-966925021.jpg	pending	2025-03-01 07:57:38.989192	2025-03-01 07:57:38.989192
26	24	28	27	Booking for Bathroom Remodeling	Noq	Kogi	2025-03-02	testapi.humanserve.net/routes/uploads/files/1740874321017-955183800.jpg	pending	2025-03-01 19:12:01.286617	2025-03-01 19:12:01.286617
27	23	27	30	Booking for Drywall Installation and Repair	just chillinf	kano	2025-03-29	testapi.humanserve.net/routes/uploads/files/1740914530850-871750810.jpeg	rejected	2025-03-02 06:22:10.973003	2025-03-02 06:22:10.973003
28	23	27	30	Booking for Drywall Installation and Repair	nnawaaaaa	abuja	2025-03-29	testapi.humanserve.net/routes/uploads/files/1740917132601-444793815.jpeg	pending	2025-03-02 07:05:33.615514	2025-03-02 07:05:33.615514
29	30	34	43	Booking for Bathroom Remodeling	new bath	Victoria Island 	2025-03-02	testapi.humanserve.net/routes/uploads/files/1740923209384-626460540.jpg	accepted	2025-03-02 08:46:54.525703	2025-03-02 08:46:54.525703
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.follows (id, following_id, follower_id, created_at, updated_at) FROM stdin;
2	1	2	2024-12-15 13:01:16.477776	2024-12-15 13:01:16.477776
3	1	1	2024-12-15 13:29:01.134544	2024-12-15 13:29:01.134544
4	28	27	2025-01-28 06:01:24.806783	2025-01-28 06:01:24.806783
5	28	1	2025-01-28 06:05:10.306974	2025-01-28 06:05:10.306974
6	28	7	2025-01-28 06:06:46.832679	2025-01-28 06:06:46.832679
7	27	28	2025-01-28 06:08:33.263988	2025-01-28 06:08:33.263988
8	27	1	2025-01-28 06:40:46.898409	2025-01-28 06:40:46.898409
9	28	28	2025-01-29 18:37:03.845725	2025-01-29 18:37:03.845725
11	28	5	2025-02-01 23:55:18.547994	2025-02-01 23:55:18.547994
12	30	1	2025-02-02 04:18:36.56022	2025-02-02 04:18:36.56022
14	26	28	2025-02-02 15:40:37.010373	2025-02-02 15:40:37.010373
15	28	26	2025-02-11 09:09:45.649133	2025-02-11 09:09:45.649133
16	42	28	2025-02-15 00:40:21.785319	2025-02-15 00:40:21.785319
18	43	27	2025-02-16 15:54:58.952413	2025-02-16 15:54:58.952413
19	28	31	2025-02-17 10:00:50.652085	2025-02-17 10:00:50.652085
20	28	42	2025-02-17 10:09:42.142326	2025-02-17 10:09:42.142326
21	43	31	2025-02-28 15:26:03.045045	2025-02-28 15:26:03.045045
22	43	34	2025-03-01 10:32:02.592284	2025-03-01 10:32:02.592284
23	34	43	2025-03-01 11:17:40.207209	2025-03-01 11:17:40.207209
24	30	27	2025-03-03 02:10:42.544595	2025-03-03 02:10:42.544595
\.


--
-- Data for Name: kyc; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.kyc (id, user_id, kyc_method, kyc_id_type, document_url, approval_status, created_at, updated_at) FROM stdin;
3	1	utility-bill	utility-bill	testapi.humanserve.net/routes/uploads/files/1735652356357-344441304.pdf	pending	2024-12-31 08:39:16.453917	2024-12-31 08:39:16.453917
4	1	identification	driving-license	testapi.humanserve.net/routes/uploads/files/1735653929426-449160166.pdf	pending	2024-12-31 09:05:29.65659	2024-12-31 09:05:29.65659
5	1	identification	driving-license	testapi.humanserve.net/routes/uploads/files/1735654011192-258798940.pdf	pending	2024-12-31 09:06:51.245645	2024-12-31 09:06:51.245645
1	1	identification	residence-permit	testapi.humanserve.net/routes/uploads/files/1735651930757-35058432.pdf	approved	2024-12-31 08:32:10.930922	2024-12-31 08:32:10.930922
2	1	utility-bill	utility-bill	testapi.humanserve.net/routes/uploads/files/1735652124425-135651930.pdf	approved	2024-12-31 08:35:24.625681	2024-12-31 08:35:24.625681
7	1	utility-bill	utility-bill	testapi.humanserve.net/routes/uploads/files/1737081531673-750214754.jpeg	pending	2025-01-16 21:38:51.713033	2025-01-16 21:38:51.713033
8	1	identification	residence-permit	testapi.humanserve.net/routes/uploads/files/1737172006080-314145279.jpeg	approved	2025-01-17 22:46:46.342196	2025-01-17 22:46:46.342196
6	1	identification	residence-permit	testapi.humanserve.net/routes/uploads/files/1737081018720-356006116.svg	rejected	2025-01-16 21:30:18.813917	2025-01-16 21:30:18.813917
14	28	identification	driving-license	testapi.humanserve.net/routes/uploads/files/1738425474766-617490930.png	pending	2025-02-01 10:57:54.940762	2025-02-01 10:57:54.940762
16	43	identification	driving-license	testapi.humanserve.net/routes/uploads/files/1739738527869-758283413.png	pending	2025-02-16 15:42:08.091618	2025-02-16 15:42:08.091618
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.messages (id, sender_id, receiver_id, content, created_at, updated_at, mark_as_read) FROM stdin;
2	1	5	let know when we can talk	2025-01-05 03:59:21.818411	2025-01-05 03:59:21.818411	f
1	1	5	hello, are you there?	2025-01-05 03:58:24.888002	2025-01-05 03:58:24.888002	t
3	1	7	Thank you so much for the guide	2025-01-21 23:03:25.589679	2025-01-21 23:03:25.589679	f
4	1	7	I will reach back again	2025-01-21 23:04:07.630924	2025-01-21 23:04:07.630924	f
5	1	5	Hello there	2025-01-21 23:04:56.84481	2025-01-21 23:04:56.84481	f
6	1	5	I need your assistance	2025-01-21 23:05:16.763058	2025-01-21 23:05:16.763058	f
7	1	13	Are you there?	2025-01-21 23:05:35.164276	2025-01-21 23:05:35.164276	f
8	13	1	Yes sir	2025-01-21 23:06:02.755618	2025-01-21 23:06:02.755618	f
9	7	1	thanks	2025-01-21 23:06:35.372617	2025-01-21 23:06:35.372617	f
10	14	1	Hello sir	2025-01-21 23:06:53.125678	2025-01-21 23:06:53.125678	f
11	1	14	How may i help	2025-01-21 23:07:16.748013	2025-01-21 23:07:16.748013	f
12	13	14	Hello there	2025-01-21 23:10:01.468245	2025-01-21 23:10:01.468245	f
13	14	13	Hi	2025-01-21 23:10:16.427853	2025-01-21 23:10:16.427853	f
14	14	13	what's good?	2025-01-21 23:10:29.127486	2025-01-21 23:10:29.127486	f
15	14	7	Hello bro	2025-01-21 23:10:50.62	2025-01-21 23:10:50.62	f
16	7	14	Hi boss	2025-01-21 23:11:08.734074	2025-01-21 23:11:08.734074	f
17	7	5	Hello boss	2025-01-21 23:11:29.329609	2025-01-21 23:11:29.329609	f
18	5	7	What's happening?	2025-01-21 23:11:55.83634	2025-01-21 23:11:55.83634	f
19	28	27	Hello, how are you?	2025-01-29 19:08:30.747203	2025-01-29 19:08:30.747203	f
20	28	27	Hello, how are you?	2025-01-29 19:08:35.148672	2025-01-29 19:08:35.148672	f
21	28	7	Hello, what are you?	2025-01-29 19:11:43.158736	2025-01-29 19:11:43.158736	f
23	27	1	helllo skiilovai	2025-01-29 20:12:10.004986	2025-01-29 20:12:10.004986	f
25	27	5	guyyyy	2025-01-29 20:24:55.717945	2025-01-29 20:24:55.717945	f
26	28	27	my man how far na	2025-01-29 20:36:27.412351	2025-01-29 20:36:27.412351	f
27	28	28	hello	2025-02-01 09:25:50.521473	2025-02-01 09:25:50.521473	f
28	28	5	helllo	2025-02-01 09:57:20.90655	2025-02-01 09:57:20.90655	f
29	28	1	hello	2025-02-01 09:58:05.43755	2025-02-01 09:58:05.43755	f
31	28	5	nawa oo	2025-02-01 23:48:31.716193	2025-02-01 23:48:31.716193	f
32	28	27	i just dey oo	2025-02-01 23:59:10.009746	2025-02-01 23:59:10.009746	f
35	30	5	how are you doing today	2025-02-02 11:08:14.30338	2025-02-02 11:08:14.30338	f
22	27	28	hhh	2025-01-29 20:11:34.72551	2025-01-29 20:11:34.72551	t
24	27	28	okk	2025-01-29 20:24:16.508094	2025-01-29 20:24:16.508094	t
30	27	28	k way G	2025-02-01 22:42:51.906426	2025-02-01 22:42:51.906426	t
33	30	28	helllo 	2025-02-02 04:30:47.682387	2025-02-02 04:30:47.682387	t
34	30	28	how are you	2025-02-02 11:07:56.356698	2025-02-02 11:07:56.356698	t
36	28	28	hhhh	2025-02-02 15:55:14.96548	2025-02-02 15:55:14.96548	f
37	27	28	Hello	2025-02-02 15:57:22.415184	2025-02-02 15:57:22.415184	t
39	28	26	awfa man	2025-02-02 16:15:33.51004	2025-02-02 16:15:33.51004	f
40	28	26	awfa man	2025-02-02 16:15:33.549002	2025-02-02 16:15:33.549002	f
38	27	28	My man	2025-02-02 15:58:39.99105	2025-02-02 15:58:39.99105	t
41	28	26	hhhh	2025-02-02 16:21:28.661939	2025-02-02 16:21:28.661939	f
42	28	26	hhhh	2025-02-02 16:21:29.179898	2025-02-02 16:21:29.179898	f
43	28	26	jjjj	2025-02-02 16:21:32.490581	2025-02-02 16:21:32.490581	f
44	28	26	jjjj	2025-02-02 16:21:35.003832	2025-02-02 16:21:35.003832	f
45	28	26	jjjp	2025-02-02 16:21:39.137508	2025-02-02 16:21:39.137508	f
46	28	26	8899	2025-02-02 16:21:46.596488	2025-02-02 16:21:46.596488	f
47	28	26	8899	2025-02-02 16:21:47.033461	2025-02-02 16:21:47.033461	f
48	28	5	my guyy	2025-02-02 16:24:39.514223	2025-02-02 16:24:39.514223	f
49	28	5	999	2025-02-02 16:25:56.176526	2025-02-02 16:25:56.176526	f
50	28	1	hh	2025-02-02 16:35:25.388359	2025-02-02 16:35:25.388359	f
51	28	1	999	2025-02-02 16:35:56.534421	2025-02-02 16:35:56.534421	f
52	28	1	kk	2025-02-02 16:35:58.049696	2025-02-02 16:35:58.049696	f
53	28	1	0000	2025-02-02 16:36:04.81893	2025-02-02 16:36:04.81893	f
54	28	1	000	2025-02-02 16:36:06.851308	2025-02-02 16:36:06.851308	f
55	28	1	00	2025-02-02 16:36:08.07777	2025-02-02 16:36:08.07777	f
56	28	27	my guyy	2025-02-02 20:26:44.808808	2025-02-02 20:26:44.808808	f
57	28	13	hello	2025-02-04 23:14:00.710912	2025-02-04 23:14:00.710912	f
58	28	26	helo	2025-02-04 23:14:43.905062	2025-02-04 23:14:43.905062	f
59	28	28	Fgh	2025-02-10 22:31:55.283494	2025-02-10 22:31:55.283494	f
60	43	26	hi aulex, can you come and help me fix my freezer	2025-02-16 15:45:47.815737	2025-02-16 15:45:47.815737	f
61	43	26	and how much will you collect	2025-02-16 15:45:58.510467	2025-02-16 15:45:58.510467	f
62	43	26	also can i know where you stay	2025-02-16 15:47:03.083458	2025-02-16 15:47:03.083458	f
63	43	26	also can i know where you stay	2025-02-16 15:47:03.463731	2025-02-16 15:47:03.463731	f
64	43	34	hi	2025-03-01 10:32:50.436924	2025-03-01 10:32:50.436924	t
65	43	34	hi	2025-03-01 10:32:51.998622	2025-03-01 10:32:51.998622	t
66	30	43	hiii	2025-03-03 01:59:14.638326	2025-03-03 01:59:14.638326	f
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.notifications (id, user_id, title, description, mark_as_seen, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.password_reset_tokens (id, user_id, token, expires_at, created_at) FROM stdin;
1	23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIzLCJpYXQiOjE3MzkyNjQ4MTQsImV4cCI6MTczOTI2ODQxNH0.4O-STf8Xdkhlto621zafSEM2CJvDhZ_VGFeajfUNP_Q	2025-02-11 05:06:54.753141	2025-02-11 04:06:54.753141
2	23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIzLCJpYXQiOjE3MzkyNjYwMTUsImV4cCI6MTczOTI2OTYxNX0.vHxPPezVTXF2S4mBIQwcmx3k3Cnt6uwMiNdROA8rTIk	2025-02-11 05:26:55.677101	2025-02-11 04:26:55.677101
4	23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIzLCJpYXQiOjE3MzkyNzc1NzEsImV4cCI6MTczOTI4MTE3MX0.hJos6-eIKS42jtbv9RidiwGDTESHG1kIQxG5B7MRE4I	2025-02-11 08:39:31.777961	2025-02-11 07:39:31.777961
5	28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjI4LCJpYXQiOjE3Mzk0NDMwMzcsImV4cCI6MTczOTQ0NjYzN30.M786ryOEvvsi70vPXqlt89SAEVJGp4sJui9CbknzLYY	2025-02-13 06:37:17.281202	2025-02-13 05:37:17.281202
7	34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjM0LCJpYXQiOjE3Mzk3Mzg4NDMsImV4cCI6MTczOTc0MjQ0M30.x_4MlIM49TtFx41dgd3W2sznnYoHC2FZH03IRhvn0gE	2025-02-16 16:47:23.736854	2025-02-16 15:47:23.736854
\.


--
-- Data for Name: refreshtoken; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.refreshtoken (id, token, created_at) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDE1ODM0Nn0.T6znGJpFPyEKk5exBqQUzPUWwyZvrFnxTFGiiMXDbsw	2024-12-14 01:39:06.786053
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDE1ODc0M30.x_HIpB_s6pHPbFqi-z5G0xW3NYetibOkpTskU9FjVsU	2024-12-14 01:45:43.05206
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDE4NTgyNH0.IzAyHXn46y2Nup-YT9DIgAAR7gThrerIq4JpQcaHM7g	2024-12-14 09:17:04.714046
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDI1NDAxNH0.V--6tuQs0Ku3-TsJj_ZHJEZkAyKNUmKDLkOKdtQ9EMw	2024-12-15 04:13:34.241144
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDU1NjczMn0.WXQsE0l_ijsheCo9ij9M2x1zn_-HK-UFvMltWKRgsoA	2024-12-18 16:18:52.043572
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDU1NjkzNX0.8VQY4n0RhcqGCYQZcTtX5UHG99DG9ehbJxV3w7O35hI	2024-12-18 16:22:15.286867
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDYwODY3MH0.ffw4fnNaHCyOlRCy_iUXSlKnLogXfQqQhlHsD98rqeA	2024-12-19 06:44:30.776057
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDYwOTM5Mn0.iqHnn8q7Dso1e9DKpCFZYKwQQ_p9cRnVULoePnW8CKA	2024-12-19 06:56:32.600715
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDcxMTE5OH0.snvTCBrlgOao2CV5PeS0J6EcGyGKSDnNyMtPMFXBn8M	2024-12-20 11:13:18.537608
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDczODA2OH0.8efLqK9gSAmNbJBq7ERLWXhS_Z4VlKIRKDmMLA-YHC8	2024-12-20 18:41:08.489382
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDczODQwNH0.KlZBeBBlQaUsUmFvMqirT1FfmMQaIZ2VFfyo8u1az90	2024-12-20 18:46:44.533846
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDczOTAyOX0.wtepLVKeI5DByDLq9zAHw8YO8u9ApF614UOfVQDkcBM	2024-12-20 18:57:09.193784
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MDc4Nn0.QyCcm9Grfdlovki250eh9_LBVCUgBcv3vb-zdjxoWrg	2024-12-20 19:26:26.782808
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MjA1OH0.Ol-2opAgP2ulmz0aD7EXmvs7bMaji4fBAnm5LONdBdU	2024-12-20 19:47:38.364343
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MjMyM30.xoi3s9hazByiz9cjjhOWRO_Iwg4Rep-gI5RsQcguOS8	2024-12-20 19:52:03.350151
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MzMyOX0.Q3oepwuFNXDFrroSy2fHCKTsWpTWgarspipTKeQ5VA8	2024-12-20 20:08:49.722885
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MzYxMH0.plQ2qP9iQjaJyiNjAc7HwQK9OmxGFhNLPh9iUZ_16X0	2024-12-20 20:13:30.329373
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MzcxNn0.qli2MiyvPPoxCC6GjjYTwq8GcRFDM0qy8vhyHbrSttM	2024-12-20 20:15:16.384326
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MzgzMH0.NH5fvHsl0s3CZwpUBouAIWWTk-k1dKcj1HHUpBad1Fo	2024-12-20 20:17:10.998417
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0MzkyNn0.BXKNvC5Q4KA9Hlg_vQS90cWoQ9wYb73cR1bEl526VpQ	2024-12-20 20:18:46.237055
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0NDMxMn0.dMj2fehfQNjZP1nqjZHaoLnc-544JW6gPWw2wC2PXZA	2024-12-20 20:25:12.772423
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc0NTMxM30.5Uh_xwp6GKTncL0Tx57xboPr0cdcBI0pIfiPFL-x_yk	2024-12-20 20:41:53.538555
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDc2NjMzMn0.HHQ20yWVrYFRnlqR5U7BftcThyTM4aGDsjHvF6RQEDM	2024-12-21 02:32:12.474806
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDk1NDc4Nn0.7oKIu2BnXRwG-X7GTZeFtGI4E7ATGtMCE7KVY8GDn4s	2024-12-23 06:53:06.803751
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDk1NTk0NH0.t8d8aWh36BSNm9MoAKmkWMgHqeDmCUvRleTdSDsApBg	2024-12-23 07:12:24.083028
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNDk1NjI1MX0.tAsmHFsyUv70V76pWZRcsYE_KOdXUh_FCtyPsYIHjmE	2024-12-23 07:17:31.300169
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNDk1NjQwNn0.Xi1i5KIlamBY6REOiYjEYr04SEIJ3xBjiw2u68TjeKw	2024-12-23 07:20:06.572067
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNTU1NTk2Nn0.fxH9hla-QpDbnLabpLXkfVmPXe1vz-ms1Sxx954Xp5s	2024-12-30 05:52:46.548289
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNTYyMjU2Nn0.BKzUtmC52IMX2lzg0Epl54VNoWRYjvq6LISzuJCxqJk	2024-12-31 00:22:46.984263
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNTYyMjU3M30.u2NkVDvNwhBGBYhf6Bbp8rxsQ5lj7RIlCX1-37oXrWA	2024-12-31 00:22:53.666867
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNTYyMjU4Mn0._jNN7fXluGVgRzyRraYS1ebSEdHn6pUP_4V43Q7o9p8	2024-12-31 00:23:02.964838
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjA2NzEzN30.Yoz6lS9vsmVwrmFmYOh9al7sDMm30BKDBxnG3WD-I1s	2025-01-05 03:52:17.623275
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjQzMTAwMX0.Kf4Q7uvUQFpe9udZJgul3l567tCWbQyzMUM1xheI38c	2025-01-09 08:56:41.862122
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjQzMTAxM30.RRw-Ml4pzL3J9B5pO5TX-Q7aPvPI_LK7UIOoDu5kaoc	2025-01-09 08:56:53.26435
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjU4ODIxOH0.wEmRee5rJcHWgJv47pT0RkLkcGsxbmwCDu2jrd8qIyY	2025-01-11 04:36:58.166077
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjU4OTAwOX0.ESmJ_B3yhJZHkS8DSz8N8UUplVPqo0avwzJ3hss10eM	2025-01-11 04:50:09.362305
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNDIxM30.-wp-XzmvmyZlFU-R8RK2EIJfkKCFqMuxjuSz7vkPdPQ	2025-01-11 09:03:33.616206
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTI2N30.oF8jBd9yjw1gOt8kOyYmNRnAxZmT__lqZ6v2GPIgnX4	2025-01-11 09:21:07.479711
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTMwNH0.AN-lTiHXojToTWxzQ9Q4ChG4pgrLrp1SRoEhMGFXjTM	2025-01-11 09:21:44.139286
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTMxM30.CfAwJnIITUo46LXRdkwRSPNlVtQgzr4jHIdswank_J0	2025-01-11 09:21:53.04775
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTMyM30.t4gEi0fBZoxW9oDBDTGSHuP6fb2h7ImE89l0F1Bswco	2025-01-11 09:22:03.371818
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTM4M30.3GSmViFKRH_M7Xo_kEYo8f9M3VDFF896em5MGVaYyxs	2025-01-11 09:23:03.131771
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTM4Nn0.YjU9-T0A9FNgls5ZuyvDhoTxybGR4lbslwth-Exl7-8	2025-01-11 09:23:06.677151
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTQyMX0.dRM1TL6wcCx8sL5dNbAkIBa36T0bWfNjOJ3yjanr_Ko	2025-01-11 09:23:41.25214
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTUxNX0.XjCV0XfVjYgx-bXGdBS8aqBCPgObxXwNO2EJuPJa5_w	2025-01-11 09:25:15.232889
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTU2NX0.pxpRqLDc558tsD8gaPBfaxOAZiusChknJgZ0IixbYLU	2025-01-11 09:26:05.675895
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNTYyMX0.hwW9TbiIV96MB8-PoVBDb46iGFHWKW-GXQF2ZROf-Hs	2025-01-11 09:27:01.906691
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjYwNjQyNX0.iEcfrK6aRMQsl4pH6IkTMaKVDJrfw_p7ost6YfkSyGI	2025-01-11 09:40:25.994695
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNzE4NH0.nM_jZZ-ZxwUyrO38jzWNgFajEyHKeG7uBK393GpjD8w	2025-01-11 09:53:04.275743
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjYwNzY2OX0.cVPCq70WdXX7YYjo7SjMdPulVFUKH4SebBtv8hgyLoI	2025-01-11 10:01:09.737214
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjY5NDk5M30.hEAYGB-gmO0Q5289XjDGtW2kWxpMNqGmzbsx-PH_NR8	2025-01-12 10:16:33.160409
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjY5NTc4NH0.zgKmW2K5qPhAd-EmGxVFNBWV0prx1ehmzRxx-3MTDDg	2025-01-12 10:29:44.877127
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjcwMzQxM30.qhP5xTRuXcriCudFbcWJsSkurJrZo41mjJO7CRrme04	2025-01-12 12:36:53.735405
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjczMzg3NX0.G5uP19IvqNXwRV6ghfUXgmVmb5zciSComIY48sNObPI	2025-01-12 21:04:35.466713
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjczNDA0Mn0.hIU2XF3CvLTSwVMrbs7_PC_FLMj2d1D9YCkSuEAiRI4	2025-01-12 21:07:22.019352
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjczOTM2M30.4U-GUn1zAewNcMAfSdDoDWgf_CV0-myj-xSjmezTiM8	2025-01-12 22:36:03.401701
57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0Mjk1N30.8Uw4cD9EJv-ZFf4cdByPD7JlKQ9snATPlz-eD-kV8ZA	2025-01-12 23:35:57.66754
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0ODE0Nn0.iy21A5LTGZC9v2-HRJ-fA3pdvdLM4a2KGjAjyyoCkW4	2025-01-13 01:02:26.490236
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0ODM0Mn0.oIwHbejL4CGUQ2iVNYSFtVp0P8XIkA4PhpWLe_6wDv8	2025-01-13 01:05:42.617638
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0OTUxM30.dCxHW4mUg6qMQVOGZnx91OcrtisC6pNe3fT2jXRu6d0	2025-01-13 01:25:13.836481
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0OTU0NX0.q3dzWI4eCSi5Y1NJkMYOuZBlKQPBKwaZi5wX_IIsFHI	2025-01-13 01:25:45.5766
62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0OTgyNH0.-KSLP19IRfzUuaN0Eu_8s5Zbq5xMhYKtt4POjM7hBEI	2025-01-13 01:30:24.433706
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0OTg0NH0.01C6nu6zPYO5mQ74dsKo2gI_4CI5SpPaBOJqbatjSqA	2025-01-13 01:30:44.478193
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc0OTkxMX0._XE6_Iwu58385F33kzO_3xyYXJwuNDh7_BfXtmT4qZM	2025-01-13 01:31:51.184328
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjc2MTA1N30.63_evAfXU0tVybEjBmBHT6F3Fz47iMiViJVITmZ7Kg8	2025-01-13 04:37:37.1232
66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjc3MDgyOX0.Rx7OWdmpySFlUqa0gpXVVlvPsLPGjrQF-kShA1lnWrE	2025-01-13 07:20:29.131326
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjgzNzgyMn0.RtIBed0FvQ7usD3yXqLE7JxWmduTetArHS_Dmczcsg0	2025-01-14 01:57:02.723664
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjg0NDk2Mn0.O_iYpxNz0U0drGKJlflqn0jLvxj9UGfjT2O91t31e2I	2025-01-14 03:56:02.480089
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNjg2ODE0NX0.DJfbxoP8ACdwK_2FegeiiHtNm2HO5sdPTaMwXliNIJE	2025-01-14 10:22:25.941092
70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNjg4MDAxOX0.NWr66SW73eppb5Jj3UmMJDNtfnpx-JYkZhFbkgf67c0	2025-01-14 13:40:19.3499
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA3Njc2MX0.Scbq8_F5waO2zp--xlReoWw604KZWqthiDMv-CbwweE	2025-01-16 20:19:21.259456
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA3NjgwOH0.oMk9U9x8qT4TgRLJOTXdCXDEJUvvG1_arWFTlzAFvFY	2025-01-16 20:20:08.982719
73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA3NjkzMX0.i1rrS6r2dwfSrZF6QC7XsS7gAsgHosUq-XdUYZjXQVE	2025-01-16 20:22:11.475364
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA3NzQzNX0.fCm_lhpmkn6EKURXjXqLcHpHTNRpI_FfYYRJ7BWyx8E	2025-01-16 20:30:35.558273
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA3Nzk2OX0.xTxKid6TmMd4ogQJ6GBXmMPA-Ju58_wDl54j9sPEy-I	2025-01-16 20:39:29.076008
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA3ODI5N30.CLiiMM7Dtu84CXtbyJdyb9t220Nvxp0hBfCZt8rD6Is	2025-01-16 20:44:57.898887
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA3ODM3OH0.FzsGDyzH720OTQyy9ZlLq3UMTC9QXhCVYrMp-p7oURg	2025-01-16 20:46:18.577211
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA3OTAxN30.MmZReFequklOLlTpHx0ccWaoE7xlAFNc6xmC2X4cPhA	2025-01-16 20:56:57.875136
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA3OTc0OX0.fki1tDLDl8c48yd5daFdUS18WbfGpeMVo4c91rnRk_Q	2025-01-16 21:09:09.883123
80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4MDY0OH0.9e0_xnwMobWYw6LNw9sffjGuRPQORdMmhyeQFCxPYp8	2025-01-16 21:24:08.051504
81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4MDczNH0.Rc2pbDwezuqjjRl2w5aoejkO0bfkwUJeiJVq5x6euBo	2025-01-16 21:25:34.121072
82	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4MTQ5MX0.JRpDgYiwQsh-mpic3d7lPGVF2yr__bQkHpT6QxeUV_8	2025-01-16 21:38:11.108588
83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4MTYyMH0.1i1wITHjZ9Xb-rlUJxnRw7bgsSs-tAwR_2rQ1aQlWf4	2025-01-16 21:40:20.852649
84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4MjgyOX0.IyUEbnwrmmA8OTB5q_GwaDxKfAy8Z3Qwz8ojSahW5i4	2025-01-16 22:00:29.100601
85	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4MzM0Nn0.ePHxSf4WIqQpVZ5l1KyVL5dbcXkiPQ3qIkrGfV2Vc60	2025-01-16 22:09:06.772812
86	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4NDEzOX0.6Uq0KRbZbTXgqlILYdhmwrQj2DqiTJ2RYQhgG5Gcs1c	2025-01-16 22:22:19.192719
87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4NDI0MX0.kot0OJbRqCQUoHyxWGw7mlUuOL034cdfW69dcagzr4s	2025-01-16 22:24:01.010206
88	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4NDM4OH0.qRoXq7pVtw8GSfX7TtIA-6vwMF5Ld0ueBStVwV3UaPs	2025-01-16 22:26:28.368505
89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4NDc5OX0.exS5Uuc2yhXWDemR2PizzLFM74LXNo58OJex3gPQPyw	2025-01-16 22:33:19.740709
90	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4NTA5Mn0.jkEp9LM8UhKQ56yD_RPWvxkpNXspPwXeyVEpX8E5448	2025-01-16 22:38:12.779534
91	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4NTQ3OH0.YLi09zb_GB6kUaqILxCNZ6JMqj5zh_own34r2S1Yfzo	2025-01-16 22:44:38.450199
92	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4NjE3OX0.86B7IyJmkQMC_3ZCJPqePgwP4rrtuDzN1cj0S0dnC58	2025-01-16 22:56:19.689328
93	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4NzEyNX0.mDYh5O5axykl_Q5Pyn0Q9HM5tTOfhwG6B7LLGdUIv1g	2025-01-16 23:12:05.789622
94	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4NzI5MH0.CrA6WAnm6HcOQOQdVcM_oNFyfpwdRm3Yjulm4X8_Iys	2025-01-16 23:14:50.707218
95	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzA4ODI0OH0.zonAxzHLGAQNW2luQgerT6lLGCRIjMgm2dDdUJeveeU	2025-01-16 23:30:48.947382
96	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4ODMwNn0.OijpXnaL_VYvq8jAzMaLxsl9ZiN_kQDEdmOicU6284k	2025-01-16 23:31:46.879862
97	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzA4ODg3NX0.033O0LrI01pEnrbJxQipGHPcjmxg_EFRUTZ8anXqz5c	2025-01-16 23:41:15.713144
98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzEwMTc0NH0.3S_pLaymt172oiNhLq-ufecCRkqUI7ctyb9pYQqPRQo	2025-01-17 03:15:44.608251
99	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwMjExMX0.7gLACD9eU65L5Rtz4NHEdsnE5ScWvR74EAKSAr8Uroc	2025-01-17 03:21:51.085665
100	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwMzI4OH0.q04Exdj9Wp-XYS-vS2U4bY-gp5oaGtTLe7bkCIFzbRg	2025-01-17 03:41:28.660952
101	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwNDA4Mn0.51TJT13ic4GUDCikuidzf-_M_5ZOyuM8-gu9mP33FDc	2025-01-17 03:54:42.867888
102	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwNDM5Mn0.FF0C_KcCHrMEq09JJlveM-NoZyCfk4uw8FDtNeGsaxE	2025-01-17 03:59:52.256421
103	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwNTQ1OX0.eWTz59oYPYuJ5iAJrn6OF9rH_VRpure3bTCjXFnFaAo	2025-01-17 04:17:39.393652
104	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwNjE3M30.HGTcrcZMLkOJcna4espdfCcr8Ckry8v2VxwEHcVMxjY	2025-01-17 04:29:33.866418
105	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwNjkzMX0.u7imZaOqQhoF_DfUzxsTKlZ-KgIjFqsiyowvWdQ0ACE	2025-01-17 04:42:11.707363
106	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwODEzM30.V665_cayM6rwhB8157jqERseKoVUicoo3dmsIsaBz2A	2025-01-17 05:02:13.190551
107	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEwODg1N30.dfYEdORh_DUQB0tTUFdSZ7iS_9fn_S4hxu7KGVZwRE4	2025-01-17 05:14:18.000008
108	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzEwOTkwNX0.YtM-P6UYAorGCSFlM5Rgs9j2KaT4hPvHZBgt_xBu8Rc	2025-01-17 05:31:45.967915
109	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzExMDA4OX0.OQf-xd3MoFMtrtr6MK48xyiylrC8GepnW8382hB9UHk	2025-01-17 05:34:49.096496
110	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzExMDc0NH0.H8h1zshW9KMIQwwNvR4e90dfSI7KeUSjOONEqpenWys	2025-01-17 05:45:44.65186
111	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzExMTQzMH0.8de6GFDl0kHZZls63zONDBnJnY-xhGLuQyoMU1jBOWc	2025-01-17 05:57:10.309468
112	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzExMzA4MH0.sxnCm8HBfYIaHDQSDFXCkbBR445DztyKdQqJRPBsyuc	2025-01-17 06:24:40.779106
113	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzExNDY0Nn0.1NHUmYPfWEfJkDmbtyZmje9GDiHepbYJGQTANXg0DvE	2025-01-17 06:50:46.390055
114	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzExNTE3Nn0.4pjTbdTA2g9tZhz5UXHmanDse5IX_zYAuMCVS1bEZf0	2025-01-17 06:59:36.391825
115	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEzMjM4MH0.bcRoQPB8wP2OhqAhaTMyOnsONMYan1gR6Q59EDiwvNU	2025-01-17 11:46:20.877408
116	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEzNDQ5Nn0.d2SW-MpN0Ck180OaROqBWNbD4PMA8mbPj4lL_yLUdyM	2025-01-17 12:21:36.453314
117	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEzNTU1Mn0.Yu0p0gbfiGZ1OODw1qhbhEQhyBxWfMt1-yc3vWYNMoE	2025-01-17 12:39:12.799161
118	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEzNjYyMX0.jZVbvsyeQ9toqiDZ0KH9M3KTOtEMeQ-S3E0CX1_0hRE	2025-01-17 12:57:01.079357
119	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEzNzQzN30.HYBJwbyZUgrn3qA-g4vCibtauwcdL0OCj3Jsx7S5710	2025-01-17 13:10:37.677583
120	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEzODU1NX0.ihpdgLXDfHqC85bC_uw_uQJBmudrg3R983x8CdzHSMM	2025-01-17 13:29:15.962402
121	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzEzODgxMX0.onySLuX-nENSuP6zWJ1spww9wbAVIX4fxjeNODW9ruM	2025-01-17 13:33:31.833213
122	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE2Mjg4MX0.o4_blGIMEP9YUuE84IqTHP_c49jiVLl4JnFI4DelEO0	2025-01-17 20:14:41.137019
123	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE2Mzk4OH0.z-wSXG6wmYr6tdxpDiQUlIVmtjAcJkWqpEtqIs6CJu8	2025-01-17 20:33:08.457938
124	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE2NDYyM30.J2eeqX456Q2i63VuTDs8-6vTGKYaR6O-i_2SfFXnKTo	2025-01-17 20:43:43.297655
125	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE2NTU4M30.hyrGqo6ot4FSmss68XlEjJHdDYoUErZFxhSzd8Z1v7Q	2025-01-17 20:59:43.076682
126	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE3MDA4MX0.-pBvwLbsXj_FpbFnCC29a4vHQi8AcGkIQKHATwjxdjg	2025-01-17 22:14:41.228443
127	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE3MDgxNn0.SApqwxGYkhbaF8TIb6iPZNI5Aj34C9qEKvK2b6OTGsg	2025-01-17 22:26:56.216288
128	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE3MTIwMn0.Jb9RQgiwe2NPWNuiRiVm4TXnhHu8BRLjk7_LWGJRi6Q	2025-01-17 22:33:22.498713
129	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE3MTk2M30.JbI4NWLGs6d23q-tXmlAiPPRcphZ6h58qqY8N6BOYxw	2025-01-17 22:46:03.471721
130	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE3MjgxNH0._2ktKH5YSTxTYfvIYG3KZkOgt9TyCdQcuQN0lO1q4pU	2025-01-17 23:00:14.83633
131	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzE3MzQ0MH0.0Hpxgao-p6zplLJL4gG42bthL6-BBr4T8b43WeuYj0A	2025-01-17 23:10:40.8447
132	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIwNDA4N30.LH47h89c2rKfPAZGOqqtzXzhFMmNqYRyMwroeLj8m9M	2025-01-18 07:41:27.908213
133	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIwOTE4MX0.xRuP-JpexgMF29tJYtzT3ENwwqHBH2C9HReTrd2rfIs	2025-01-18 09:06:21.875515
134	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIwOTg5MH0.vUGRXeszD0DAsQThPO3NTlKe_Y7BzFdY70nQVQOkBcQ	2025-01-18 09:18:10.13507
135	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIxMDg1NX0.OYx24QPuljiSJSFpTPQC1jBGgvGiUIzxAKQ66cdnRAQ	2025-01-18 09:34:15.297496
136	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIxMDkyNX0.a-oE3Kkc2lou2DtblBuXtQ8prhY5af3xueih4ej1ZSo	2025-01-18 09:35:25.690438
137	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIxMTU1Nn0.7rnHey0FZdwitXw1hBx3h_oDfE7x_AR9Qm9iCCV1Jhk	2025-01-18 09:45:56.266538
138	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIxMjQ1NX0.0X06pNj4sm51mh_aSlUT23u9HnYVYXkqKmNEyNYlIJ0	2025-01-18 10:00:55.188698
139	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIxMzExNH0.TeSASQl2G0tvTM9fNXzQQnSUkrLlgrPv2qUngXvrEzk	2025-01-18 10:11:54.92635
140	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzIxNDEyNX0.7urNROQfOgOzjjRoC1klII_UMFe6G-R1eKy6i5F2Rh8	2025-01-18 10:28:45.542825
141	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI2NjUzOH0.rJlLYz9Z2mD23yz7e8f7tOnDvicVQpM7LOFQZLylAzA	2025-01-19 01:02:18.27916
142	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI3OTM3M30.lGLeFrfyaDiFZGgvuUavR6yqSbrNPngOzdpjqMyb1ps	2025-01-19 04:36:13.988352
143	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI3OTk0NX0.6JrpIuTn-_iGiFKnCVPUQevpkop8owwikwc-f4VwvWw	2025-01-19 04:45:45.474935
144	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4MDExMH0.3pU71vORIbjkmppiVtm6gVrG0OXA2NU2gCDglzh7Cno	2025-01-19 04:48:30.281947
145	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4MDM4M30.koHCaihfwmCcAUAszY6PbGZ2rbEDaDqe7JXbIiHAApo	2025-01-19 04:53:03.632781
146	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4MTAxMH0.ugIqblq7MBZcWbggTdpevhGkwD8udKTWVgdysAg90zk	2025-01-19 05:03:30.391216
147	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4MTY1MH0.yIhBfeaYDj-SPTkHffkmhzh1Xb8NjAOe0homQR-m1Hg	2025-01-19 05:14:10.508805
148	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4MjMyM30.r79oDOQUDBlXUmF05GxlKMslh7TpsQgJi9W5Pl8y5HU	2025-01-19 05:25:23.032494
149	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4MzE5Nn0.EjAkw0p_inosAXbH9FF6yJG8gF86scGNMC82NoQWzg4	2025-01-19 05:39:56.479534
150	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4MzM2Nn0.3MOghowRa2myftCa9sDo0-9t8KdrPfAgBlRkbhqbCbQ	2025-01-19 05:42:46.662864
151	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4Mzg5Mn0.8jsdkXjg_NhmLbsOdqMd5tKJU4Xt1cMZsKtZWebqTl0	2025-01-19 05:51:32.818165
152	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4NDI3Nn0.mLaGuJElRzIwHeDjBiJLA0qgDlMxOon_1KJ87wcbBWA	2025-01-19 05:57:56.859853
153	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4NDY3NH0.tOupLbo6gksxrtbfiC63A15mOoVGYOaxlA-_e2QHEvA	2025-01-19 06:04:34.937749
154	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4NDczNn0.0v5xpkJH0haAfHrr3pnL8O-hARVEqI4Pe704bG6AR2g	2025-01-19 06:05:36.983162
155	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4NTM3OX0.bxWSML-broT2ZeBKjYyzfaUUvGwVIEG6oN_ih92C0qo	2025-01-19 06:16:19.277619
156	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI4NTYzNn0.h989BmDBWwjYaznK9kYNge718Qt0NPfiU4V15fTvNso	2025-01-19 06:20:36.479072
157	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI5NzYxMX0.l3hOwKJjiEhVK41pl9JSRQgtNhK6SO3BjRXe-9z8u9s	2025-01-19 09:40:11.708626
158	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI5NzcxOX0.DJMIyRSrmETB5KUe_VLcfn1UoC-_EDPA88rQOn19dkg	2025-01-19 09:41:59.652873
159	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzI5NzczNH0.-RKyInfzSMPJtOptkjbJ5qOeqbNC3KGcflSC5bF6cxQ	2025-01-19 09:42:14.832122
160	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzMwODUwMH0.GpL--kLmSFQEaZh6ZOVrw8_xFz2GefkoY_4ZDlmeE9k	2025-01-19 12:41:40.885798
161	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzMwODk0Mn0.rT_6C5pLFqG9LdxbDzdHxLDI-bhTdhS3rqDRymKz6OY	2025-01-19 12:49:02.898182
162	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzMxMDg0MX0.KqrMmked6Y0zNI615F8skmwr_DA_SxDOW0EJ7mLT6SM	2025-01-19 13:20:41.699169
163	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzMyOTM1Nn0.IePa0XQOywxRUftZC7D0wMSawYDwYanJzpjmRyjwF64	2025-01-19 18:29:16.36311
164	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzMzMzA3OH0.On3RDbZ4UaeAn7D3JXxRqmn4nxGCBMGkFSMHraU9fAQ	2025-01-19 19:31:18.412291
165	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzMzMzE5OH0.eymJXg4H4RtKfX8qJuSz0RSCmxYivRec29QbY1WPGvk	2025-01-19 19:33:18.357494
166	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzMzMzMwMn0.cBRB4a-BO-ipASAIzTs5Nb5QG_Owf41t_3Xj5Yhk9k0	2025-01-19 19:35:02.504902
167	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzMzMzM0OX0.d3X5v_BrIdY4dUsq8qetBki1e7UnmpkO8Ip3IFHK13Y	2025-01-19 19:35:49.349009
168	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzMzMzc3Mn0.e1bCRbyBL0ZdNB-5uQRZQ6WVsUJcZFQFuINJcvXgjWE	2025-01-19 19:42:52.567773
169	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzM0NTg0OX0.WBczF4cuAKqb-UIVAvJlzvMcolulRKZrtGDjEjzi4ts	2025-01-19 23:04:09.946826
170	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzM0NjU0NH0.2eM0ep6NxSSPc1Z-RM685CNOVjsi1tjFX6t4Lk5iWpM	2025-01-19 23:15:44.554114
171	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzM2OTc3M30.99l6MGRKu_MHPkB8WgjweDPY3uLldWGLIkMIggd2rdw	2025-01-20 05:42:53.738942
172	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzM3MDUxNn0.8PYg0HokUTJYJVQbjL57LOJkDrBB7Jh8T6WYkZnopeI	2025-01-20 05:55:16.309944
173	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzM3NzE0NX0.bAUrl_OsJrFOtS_EtAODZePw66TjKKkgOvzv18P660c	2025-01-20 07:45:45.343601
174	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzM3NzIwMH0.Ic-NvNfVFX_675v7B2BVWB04-JPCFsY9z7jUH7vtb8k	2025-01-20 07:46:40.108703
175	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzM3NzI0OX0.7GqmgRvjmAT_8jasqmjJWUbzGWFCZmXugKXXbBW63Uc	2025-01-20 07:47:29.011318
176	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzM3NzM1Mn0.T0aSCEBCtWlRglULvCTeOeshajJYLlc1uHY9UtlwhHg	2025-01-20 07:49:12.888611
177	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzQ1MzkzOX0.Xmc3tZrlSTUeR9L8UCF-QE050NlvUia0CAoHyCWPPvc	2025-01-21 05:05:39.268011
178	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzQ1NTcxNn0.7914hPDbH8UTtJG_lp50dhyLVc-p8igCaiGBujj1eNI	2025-01-21 05:35:16.471868
179	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzQ3NDYzNX0.NvhGSo7_ASSnst3dsMdz2qjA4lO0y6961OFRJgHjPvo	2025-01-21 10:50:35.731199
180	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzUxNTMxN30.ykJ9odrEuslNRvNpIlFBERV8Rb7RYHF3SvUuXF_0B50	2025-01-21 22:08:37.653357
181	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzUxNTU5Nn0.uhcVR5OIQ198cXMaS8YFZBtEOUmFi6cZO2iQ3h9cG00	2025-01-21 22:13:16.980966
182	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzU0NDgwOX0.nZLs9N-FS_NqcWaQwiSB2hfUZqtZSAHE8eu7v_FkKgA	2025-01-22 06:20:09.232635
183	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzU0NTQwMn0.4mQY1jzGHIbjQuZnYF41fvon5V9vj6_EPtLob8VDuLI	2025-01-22 06:30:02.6303
184	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzU0ODQ2OH0.xUxfmA_6C4aVN_w-hbya6PG9j_dtp2kB6iqz6yjxK78	2025-01-22 07:21:08.057772
185	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzU2MzgxN30.8z3tpr_DNHKe_mY37qAKsbwD6wjA9MHzOVEWqRPT2WQ	2025-01-22 11:36:57.501489
186	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzYyNjczNn0.vUEczcUlsJSh_u6LMJ7tdDP-LJ_fsMemD9CC0BplgBM	2025-01-23 05:05:36.469674
187	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzYyNzIwNH0.cbfSv_S7FZiYpGw4O3zqww8cXjGgs6G-L47wL6GuzXY	2025-01-23 05:13:24.866963
188	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiYXVsZXgwMEBnbWFpbC5jb20iLCJwaG9uZSI6IjA4MTU4NzcyNzE1IiwiaWF0IjoxNzM3NjI4MjY4fQ.jKaEzzM8shJcx1hxRXurca9-lPOBqfKbQQqB_A9n3ms	2025-01-23 05:31:08.489863
189	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiYXVsZXgwMEBnbWFpbC5jb20iLCJwaG9uZSI6IjA4MTU4NzcyNzE1IiwiaWF0IjoxNzM3NjI4MjkyfQ.BzJSEUOvxB0mvlj3GSN6TYydKsR-c7LduYlNpgt0JLI	2025-01-23 05:31:32.056073
190	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiYXVsZXgwMEBnbWFpbC5jb20iLCJwaG9uZSI6IjA4MTU4NzcyNzE1IiwiaWF0IjoxNzM3NjI4MzM5fQ.BjBX-DgoNdC2iQ_NI_tlmILYmDHzrnNwmOKETTrIxa4	2025-01-23 05:32:19.912268
191	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzYzMzgxNH0.c3VXLVCMmWEM_m1mIoXUu6EYDO4Oo21PtbsP6PsU75o	2025-01-23 07:03:34.499179
192	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiIwODE1ODc3MjcxNiIsImlhdCI6MTczNzY0MjM3N30.dA5FO9u3HQ1zB0Vv9WMWzGIIwgw9_BvP9n_kVHssouI	2025-01-23 09:26:17.665043
193	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiIwODE1ODc3MjcxNiIsImlhdCI6MTczNzY0MjQzMn0.eA6gqVB18l16iCp7UWNCwnTvYqEOTB0O65UHSFfVm4o	2025-01-23 09:27:12.857548
194	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoiZ2lkZW9uY29ubmVjdEBnbWFpbC5jb20iLCJwaG9uZSI6IjA5MDAwNzczNjQ0IiwiaWF0IjoxNzM3NjY5NjE1fQ.V7HY0IlzM8iZI-3gpN829TKLN9OBm3n-SzVkdbc3KaY	2025-01-23 17:00:15.133339
195	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiIwODE1ODc3MjcxNiIsImlhdCI6MTczNzY5MDcyOH0.Clo1r6WejijaX15UqPtInXEtALYHK3VtZwtSQXQKrDo	2025-01-23 22:52:08.586574
196	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoiYm9uaWZhY2VwYXVsNTAwQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNTg3NzI3MTMiLCJpYXQiOjE3Mzc3MDEyNjh9.OO1lIOoEFpshRlZTFq-fXoWng_twNsvvBIm8pZPlr-E	2025-01-24 01:47:48.171904
197	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM3NzAxNDM4fQ.XPA8hY-ail0RcVNT9NW2UHB2-8rBb1SF4nkH60D9SiI	2025-01-24 01:50:38.135561
198	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczNzcwNDc0Nn0.yGhZku-AqqRF0Uffu9KA6LRFdBdXzoQnYy1SueoeG0w	2025-01-24 02:45:46.90633
199	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM3NzA2ODcyfQ.zypjs7Cn2ms1qXXm77UcRHRUF0WYtzlN5jgfiDGvXUI	2025-01-24 03:21:12.379509
200	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImlhdCI6MTczNzczNDQ2N30.tS-MdZTsuspbtLJOUTUgF_P6Aba7Trq4KOByQlvzEA4	2025-01-24 11:01:07.604235
201	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM3NzM3MTEzfQ.g0Hm7FQvRVf6me5eDmARHsPcdoHbqt8m2b2bewK0CLM	2025-01-24 11:45:13.06141
202	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsImVtYWlsIjoiYXVsZXhjNGQyQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNzc3OTAwMCIsImlhdCI6MTczNzc1MjQ4MX0.fuKliK9M9RS936LSTkyA4yW02dqsZyfZtELYbworEg8	2025-01-24 16:01:21.813466
203	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImlhdCI6MTczNzgzNTc3NH0.XprpzEKP7qaacPQIP0kNY5k54m7b--lvps6rlW0M6Ts	2025-01-25 15:09:34.99418
204	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoiZ2lkZW9uY29ubmVjdEBnbWFpbC5jb20iLCJwaG9uZSI6IjA5MDAwNzczNjQ0IiwiaWF0IjoxNzM3OTA0NTg5fQ.3Orjx3eGVLYMAw2W8e_xaPmyDQw904zwz5owgPbgPok	2025-01-26 10:16:29.064565
205	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoiZ2lkZW9uY29ubmVjdEBnbWFpbC5jb20iLCJwaG9uZSI6IjA5MDAwNzczNjQ0IiwiaWF0IjoxNzM3OTA0ODcxfQ.-9n0WIhKSg-RO01_A4jEpE1RbpdvUbjgIDJuG6zRYTw	2025-01-26 10:21:11.563244
206	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoiZ2lkZW9uY29ubmVjdEBnbWFpbC5jb20iLCJwaG9uZSI6IjA5MDAwNzczNjQ0IiwiaWF0IjoxNzM3OTA0ODc0fQ.jzFu4pxz159QfZtDutw-XZk6UGQy33x1rphgqlaBoeo	2025-01-26 10:21:14.530709
207	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoiZ2lkZW9uY29ubmVjdEBnbWFpbC5jb20iLCJwaG9uZSI6IjA5MDAwNzczNjQ0IiwiaWF0IjoxNzM3OTA1MjY0fQ.7ZH97cbMHxGhyJiOvWW-lG5k0cRUP-moxja-RhAgJDM	2025-01-26 10:27:44.102639
208	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoiZ2lkZW9uY29ubmVjdEBnbWFpbC5jb20iLCJwaG9uZSI6IjA5MDAwNzczNjQ0IiwiaWF0IjoxNzM3OTA3NzQ3fQ.eFJFGEemxOuUGbJjlSAvyasFiXMdGlTbZBPOLlVG8xg	2025-01-26 11:09:07.277266
209	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImlhdCI6MTczNzkxMzM3MH0.y2_Ht67x2FbkCVtlq5wDawdLrKy91tk9WxGbC-pLtgY	2025-01-26 12:42:50.977334
210	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzkxMzM5OX0.3_LIy8FifI2C6XMhrdGcP9QMuR9_OGNow9dCB4VzzG4	2025-01-26 12:43:19.291169
211	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiZW1haWwiOiJ0ZXN0MDJAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMSIsImlhdCI6MTczNzkxMzQwM30.1SuzUotNJlvcs814Ku1Cig0y0NcOVzR4HxoPljyblHg	2025-01-26 12:43:23.824443
212	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzkxMzQxNn0.oneJzfKbInbZo0zeUMlvsEjD4n6PTSFI6krMZ5B7wrc	2025-01-26 12:43:36.699665
213	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczNzkzNDQzNn0.dk2ZDcoOGnySnWecj3wySGxwGgY3AhO4FbunwBGicWs	2025-01-26 18:33:56.112242
214	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczNzkzNDQ0NX0.Q7800OwyYTBnu4b7sohfumScQIV1p-g6bet72vyXqqM	2025-01-26 18:34:05.219966
215	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczNzkzNDY0M30.fIzibSx8VairxAOPuM2WhxmHv60k7SvCHMIOie6fAXY	2025-01-26 18:37:23.938709
216	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczNzkzNDY1MH0.ojqmsBjbdu2kQpX3Py9RL0vUvH6lmsOBJFBkN01fex0	2025-01-26 18:37:30.782432
217	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM3OTM0NjY5fQ.kPwnVjgKAdQ_YmF2UUN9n4AjL8cL_wKcu7tZYs88Hsg	2025-01-26 18:37:49.582564
218	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM3OTc0NjExfQ.BDP0zPwWDW9DIJFoUfH1nFAxGfIUfS8mxOTMD4iQxjE	2025-01-27 05:43:31.640137
219	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3NTI2N30.jsD7s8miQmqdHaj6PAXVepAdTEg1bJRzLJp0J4IJZZM	2025-01-27 05:54:27.279725
220	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3ODQwOX0.PorLdSlXbogbKz-r3I26HAdqotw4mG1bTewuESk0e_E	2025-01-27 06:46:49.870793
221	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3ODU0MH0.jNGAH12WURssPRocldjSXcxjnWXBup4hDkW0apiBfFY	2025-01-27 06:49:00.176206
222	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3ODU0NH0.P2FmYo2nj1HmoerBzkr6Kkw_wnyNuSvFowumBPtN2cI	2025-01-27 06:49:04.251645
223	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3ODU0N30.1OkvUz6GXQ5CS4ycW8hwMOKpmdE0YTpMF5HWzZ6EzqM	2025-01-27 06:49:07.207672
224	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3ODcyNH0.XxhCqO5TY1x-7VAOAHNqDQFNxMWiGJ9wVcqKwfGoIPw	2025-01-27 06:52:04.03689
225	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3ODcyN30.Oi4LanxB8HcqdtY1wNiAKQxB7lBDmpoaUGlYmZPvPYs	2025-01-27 06:52:07.457855
226	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk3OTI2N30.nrTy3Ea7i6625aFhfdampnRvX3guJYB_DeewQvr3tvg	2025-01-27 07:01:07.367746
227	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MDM1Nn0.__awXBL7NJtn7kiTriVoylrTa6tvwTxyDudmmZrh5mI	2025-01-27 07:19:16.880588
228	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MDM2M30.FwE9cPOpiUGqXOqLgQMpBt76LgWaEDNpMMQAdlbtcKM	2025-01-27 07:19:23.439182
229	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MDYxN30.Fxd2iKB5LX2684HeKkPVzOO7Yo2ua77U2KffdhLRd9I	2025-01-27 07:23:37.891024
230	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MDYyM30.xLAi2vC1cq9MnXDhdpcUsO0Bt9dyHLgdCo-m5O2A-TM	2025-01-27 07:23:43.675218
231	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MDgwNn0.YOw3DUzmRWdyNqmH0jl0Q-pM-b1gxY-ePbdqG-sdpvs	2025-01-27 07:26:46.563893
232	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MDgxMH0.6ldWRNtBRE9k0RUjcBh9qmjv17ZYafCBFQYv6Ha5QYU	2025-01-27 07:26:50.933952
233	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MTIzMX0.HTZq2nA-eMwOFiw4eKErJPmRwRlEZW29CSaTpZi_VO0	2025-01-27 07:33:51.769616
234	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MTY2Mn0.hcXS492Rpkw7797lwi8KZ1Qnf6MFjaisdkRAL23lYMw	2025-01-27 07:41:02.509107
235	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MTg0Mn0.bCmik85XtRS6X29KobdmujQn6NiMiPzy7sAkXM9Gg5E	2025-01-27 07:44:02.460105
236	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MTg0Nn0.p_Y1_8n99nTxwRMDQCXP7drxMOa85iczh6dZRoCexXo	2025-01-27 07:44:06.928415
237	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MjA5N30.B0n59mBiyY1rpjgBLnk4f7mfL4L_Ly-RFLLMJ5wwXJQ	2025-01-27 07:48:17.781157
238	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MjEwMn0.wDaZLw0z7EtYg6CSiQJT7Huty12V7PX6h1H0TBrdZkw	2025-01-27 07:48:22.140468
239	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MjI4NH0.ltcuOzfQz-R6L_mgju3uSpEo6EncmPEnh2l8k3jbhug	2025-01-27 07:51:24.674726
240	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MjI4OH0.25N0a11-o7xalI7R38rjto8wkSxjj-9HcggJ0rT_UxA	2025-01-27 07:51:28.834294
241	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MzA2NH0.7XaC47rHwROyAloFIObmwORyCchACdJJD2EV49N99Ag	2025-01-27 08:04:24.166648
242	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4MzA2N30.z08AvKBEucA00PNuQbZK3l_14ncKXnV2ShHQN5MxoAM	2025-01-27 08:04:27.571557
243	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NDA0NH0.T7Cc7bzDFGZ1RvnL6EjqpH7ghxmluevEj2IGKutAnaY	2025-01-27 08:20:44.765673
244	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NDA0OH0.qxMD9-rwEtLgN_U8DN4ugh55hb7Hvanx0YJHr-YPzbQ	2025-01-27 08:20:48.59077
245	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NDE5NX0.3uPvWYJfW1gjQNEc8i32mjY7mYfDSSJdAHZb6lDfxFg	2025-01-27 08:23:15.407623
246	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NDE5OH0.mQyV-iN2qrPYb6Apo9BIzSk6Lqv09MVjn2oOoT3z-0Y	2025-01-27 08:23:18.36659
247	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NDQwMn0.6WNH6orE68WVD93y7Qv-7LviNSmL5jeB2pFc4-0ky3A	2025-01-27 08:26:42.126092
248	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NDQwOH0.69RtcY0hiZ-dgrQn7AwdIe1dub_OtGDkyFLkzQlw9I8	2025-01-27 08:26:48.319174
249	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NDYxOH0.prCa0aft7DI64wy7upGIBqH4qJ-LPnkAyAnaF6WS7Ws	2025-01-27 08:30:18.14998
250	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4NzMzOH0.hNuZdrbZpIpqUi-oJgwAQnibTEPq2oPtmLcIFb92jJY	2025-01-27 09:15:38.263715
251	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4ODkyMH0.SblWuz7GfdsDYHuPbY3Okfn1V0GzHKGh3XKm5LmPriM	2025-01-27 09:42:00.057243
252	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczNzk4OTE3Mn0.dN8Z4bxUMU1x7QsElA5r1lJoqPOMH0IwqFXSWu3VHA4	2025-01-27 09:46:12.196264
253	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MDA1ODQyfQ.cuMesfDL1L86MP_uzR2YI5j_oYTE5wjWH3bMOOy-Tdo	2025-01-27 14:24:02.705588
254	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MDA2MDY3fQ.sRAj_KdUFxeoBjSF104hO8WdqdDL1xpYjJnd0nlY1LM	2025-01-27 14:27:47.55102
255	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODAwNjQ1NX0.nPm1rbEZyFU4TpIh2pbGkqL60bdhCTqa_cRsR9boJTs	2025-01-27 14:34:15.535257
256	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODAwNzYxOH0.neIfFqR6A0yl6fG8YAl3h_xhA5yA1xYES7qmI2Mw3F0	2025-01-27 14:53:38.275011
257	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzQsImVtYWlsIjoid2lsbGFydGh1cmZvcmJlc0BnbWFpbC5jb20iLCJwaG9uZSI6IjA3MzExMzM0NDM2IiwiaWF0IjoxNzM4MDA4NTI1fQ.lldquk04dtFNIU-eC3mgm0l8m4Ccp8L1MujRSK7zpVw	2025-01-27 15:08:45.012967
258	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODA1NjMzNH0.ZPMgbr1wGnlcDNRKBR-P4D9SL7rM-iX8DZg58xR-XDs	2025-01-28 04:25:34.82518
259	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MDU5MjAzfQ.8gsKsyIV6xph5yNxk2eaOQ3LpTAOE0nrBOx3uN2G4Og	2025-01-28 05:13:23.669237
260	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODA1OTkzMX0.2B5-R6JDnjvvLZXQHvtrny_7esVh8HXo5cuaGIZJeJE	2025-01-28 05:25:31.984225
261	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODA2MjIyN30.ksCD9lGghZewRclDTGCh7qkuCDrgUSIs9Om0NpQq24g	2025-01-28 06:03:47.631874
262	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MDYyNDc1fQ.pfC4PlQDhovARmNh_WVvKXO4pcXBsfFDgb7YCm_mr40	2025-01-28 06:07:55.696606
263	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODA2MjU1Mn0.qDJ282IElqOTxyXFsyaBOJMDQV1QbuAm_ljycTuixCQ	2025-01-28 06:09:12.840926
264	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODA2NDE5OH0.dgBBGUJBfKeB6kTzkm4JHBYWZgip2f00BTyen2SqvDs	2025-01-28 06:36:38.253977
265	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODA2NDM0OH0.gdIwNQywBPNyND--ISRwSsIspjY7XJ3Rtjd_sBF2tmI	2025-01-28 06:39:08.022744
266	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MDY0Mzc2fQ.5yO1ACp0rl1kQFUDCUCyK-9c6ICBky2V90x5ZibDXN8	2025-01-28 06:39:36.552516
267	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODA2NDUyNH0.UIT-yKxoqjy5SN5vQv2QtnWxtQzvmh_3bYyXoLbB-Ac	2025-01-28 06:42:04.827997
268	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczODA4NjM0Nn0.QeM3X0JtuH81S-P9BRqQv7Q97OtA3WI1jveJ4yllp_Y	2025-01-28 12:45:46.42646
269	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MTExNDIxfQ.DsXqf40CgNOUP_G7jzeP2WycrfTLdiUXzUTW0cY0FDY	2025-01-28 19:43:41.184531
270	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODExMTUyMn0.Irzacpb5B2mCW9hdmkiwaRkIL_vj5FbzU7GGCjO1aYg	2025-01-28 19:45:22.762679
271	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MTExODY3fQ.Rl9ruu2LwDGZ0AOvmbkpCYxu-XuxPALyWqYs1ZE-LAE	2025-01-28 19:51:07.681626
272	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MTUyNTM0fQ.BNwvOxW78FwtOh5Z1e_1PQOBIHZyPxr8CCAa7KjvLPo	2025-01-29 07:08:54.975894
273	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODE5MjU0M30.kgZKWxmbsdJvK84Q6j8zOQmiHEyqf1GrW6vi6GRZc9U	2025-01-29 18:15:43.020403
274	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODE5MjY5NX0.EofUCcd3T9Excs4Nhc_oo1ER2M63zXVOa8fjliKmdg4	2025-01-29 18:18:15.815079
275	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODE5Mjc4NH0.oO8AKnhEatTrKTD9PPoUqnufEM84CZsl2Ufn3sUOyjg	2025-01-29 18:19:44.128824
276	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJ0ZXN0MDNAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMiIsImlhdCI6MTczODE5MzY2OH0.jDaOy3Q8tgFuh1FiHVInWQj6-YGOr7sesVHReY4iNio	2025-01-29 18:34:28.927663
277	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwiaWF0IjoxNzM4MTkzOTQ0fQ.A_U4_nGWVCpu81GEY2wEGr5FzI9GapBnuf67z7qsDDo	2025-01-29 18:39:04.342373
278	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImlhdCI6MTczODE5NDc2M30.vs0KlAtzCOf_CooC4cRfiiIsVFto3L-uhAARKGSVEjw	2025-01-29 18:52:43.112611
279	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczODE5NTA0NH0.Ttf4rM9g0grwO-3CDzAm7OHOBqFG1hD_bSlCS8hF14E	2025-01-29 18:57:24.847678
280	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODE5NTYwM30.QIn2CV9tmgtkTdxMia3IG0MMxjEP24VtU2pxAENVby8	2025-01-29 19:06:43.863748
281	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODIwMDk2N30.ul5RS08X2WDcLd09JETGguEhMexYS8t7tMUnQwwdoVM	2025-01-29 20:36:07.938561
282	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwibGF0IjozOC43OTQ1OTUyLCJsb24iOi0xMDYuNTM0ODM3OSwicm9sZV9pZCI6MywiaWF0IjoxNzM4MjAxMDM4fQ.uytRubQl_I5Q5ktiiLvNAMknXI9Uhmers9waEhJ3GBs	2025-01-29 20:37:18.817777
283	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImxhdCI6bnVsbCwibG9uIjpudWxsLCJyb2xlX2lkIjozLCJpYXQiOjE3MzgyNjI5Njd9.4I3vd7ERMxtxjv_pGisLV0N9VI3qPhxViATVt1ExMNs	2025-01-30 13:49:27.103531
284	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzQsImVtYWlsIjoid2lsbGFydGh1cmZvcmJlc0BnbWFpbC5jb20iLCJwaG9uZSI6IjA3MzExMzM0NDM2IiwibGF0IjpudWxsLCJsb24iOm51bGwsInJvbGVfaWQiOjMsImlhdCI6MTczODM1NDE4Mn0.XByuxFxdGRJJZEdLHcHwxh1VnrOjK2qruGZFQ-74xXc	2025-01-31 15:09:42.10643
285	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczODQxMTMxMn0.MjFhNU-4COfGJ1NmabiOlP09c5fd5BUBe3tjn2XCPoQ	2025-02-01 07:01:52.956276
286	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODQxOTg4MH0.IYKamRNvugsO8Ptyw7Ov6ugcg-HJd-OJfN4ZTs8sp6k	2025-02-01 09:24:40.191234
287	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODQzNTI5NX0.jAZGcnZk6z0csHQbtP7X26aOycSXh7OInWvxeV2JK8c	2025-02-01 13:41:35.152313
288	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwibGF0IjozOC43OTQ1OTUyLCJsb24iOi0xMDYuNTM0ODM3OSwicm9sZV9pZCI6MywiaWF0IjoxNzM4NDY3NTQyfQ.49FcECvH-D537Jopki4z0kVlg-P0xJpo99SG2Mjd7FU	2025-02-01 22:39:02.235208
289	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODQ2NzgzOH0.xLc3GSSB4ZdlAz9rwp44NWHYOd5JcGbjYGF-bGpI2BA	2025-02-01 22:43:58.33882
290	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODQ3MDc4Mn0.IYcmiZqOtIeMPU-xA8rWTNkgo9GZNqLH6kPg0U-kdiY	2025-02-01 23:33:02.40394
291	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODQ4NzY2Nn0.7vgXNxlUPWiK81KEG2dr1FwyVH8WEiTyXtUaa7AOFNM	2025-02-02 04:14:26.974856
292	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODQ5MDA1MX0.qMAEXAFMTzXMah85hU5-4cq7bwjCe7f1bsf_k_Fz6Cg	2025-02-02 04:54:11.457107
293	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzQsImVtYWlsIjoid2lsbGFydGh1cmZvcmJlc0BnbWFpbC5jb20iLCJwaG9uZSI6IjA3MzExMzM0NDM2IiwibGF0IjpudWxsLCJsb24iOm51bGwsInJvbGVfaWQiOjMsImlhdCI6MTczODUxMzA1OX0.j0vrhhIxA7hewiHAyUyvn9tXPQBcR7L9o5vIwcHV4i4	2025-02-02 11:17:39.500922
294	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoiYm9uaWZhY2VwYXVsNTAwQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNTg3NzI3MTMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzM4NTI4NzQ2fQ.KNYHcsHrI-e1SnerP4JraV-EOXEY6Eqyh7fWP2MhDIc	2025-02-02 15:39:06.6673
295	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODUyOTM4N30.EWTrsxRDe3V_ocgnsObvc1gnRhVwTPp_iBO-lEueM8c	2025-02-02 15:49:47.238482
296	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwibGF0IjozOC43OTQ1OTUyLCJsb24iOi0xMDYuNTM0ODM3OSwicm9sZV9pZCI6MywiaWF0IjoxNzM4NTI5NzgyfQ.ORHYYneaxi8zTnn2Rl7e794STTDtK476EhxMBP3p1Gk	2025-02-02 15:56:22.382101
297	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODU5NjkwNn0.Shm0DpbR7HeKLFJ5SZHD2OdfEV9KlaXUxZVPrXTsjiY	2025-02-03 10:35:06.042801
298	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODU5NzE0OX0.32u3LSlKAmBvWqS8OICUP_d-PPA4VjMljCqX3yP-Nj4	2025-02-03 10:39:09.678106
299	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODU5OTUxOH0.wqYD_08OOVI_OE_zYt3Ta7w-nDtCHMPdH8GQGeVCTqY	2025-02-03 11:18:38.921828
300	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODYwNjU4OX0.-N8HX-OHAoy3tZGMu0fTdztRGCsM0BiSfi1iiqsC1Lo	2025-02-03 13:16:29.411239
301	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODY5NTU3Mn0.peEiaVa2kKqSA37bJ5OFQC7FdyQfqmWoLXotespqfno	2025-02-04 13:59:32.322348
302	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODY5NTU4NX0.cyOjk0oOwbgzhqv50BB7jH1pRtx-T10y6iDQ2gYxrgg	2025-02-04 13:59:45.596883
303	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODY5NTY1OX0.vxialeKx4-MjgIGgMYLMkjRChbNzrEzz2p0znNoQ35E	2025-02-04 14:00:59.062768
304	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODY5NTcwNX0.J3yK54T-ppqfFj2BeSSTdt5tnoMVCxvjhcxvdyvIjXI	2025-02-04 14:01:45.119881
305	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODY5NTgyOH0.MTTYYopO1RQXT_8RwrDp_Xgx9-vz9No0SChCk-G2ry0	2025-02-04 14:03:48.531296
306	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODY5NzUxNn0.lSXlTA30TpWAMvgglkBC5UOjtyBNGJxVDgtDXbMPjR4	2025-02-04 14:31:56.134959
307	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODcxNzEzM30.mEiuVOa8IZ5nCGJi3B_uM2jUoG6KhP9imuTJT6oeEYg	2025-02-04 19:58:53.214998
308	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoiYm9uaWZhY2VwYXVsNTAwQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNTg3NzI3MTMiLCJsYXQiOjM4Ljc5NDU5NTIsImxvbiI6LTEwNi41MzQ4Mzc5LCJyb2xlX2lkIjozLCJpYXQiOjE3Mzg3Mjg0OTl9.FJlCj3BcBOzMH5VuhfVqjZb8KRjZ51iIanMhr1cLEJA	2025-02-04 23:08:19.892387
309	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODcyODc5NX0.GORytTfjtvNnjUBCfxOip0kl6LPD3ifc8sEaQzfjplQ	2025-02-04 23:13:15.276421
310	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODc1MDUzMX0.NIEn2_S172pSUmINIdWm0GRUss9UhQpJm8K9Rn9b8u0	2025-02-05 05:15:31.484176
311	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODc1Mzg5OH0.aJugXKCkE1RIUfApCx3OYOJdrF0RU2TQ3shY9MG3MaQ	2025-02-05 06:11:38.417225
312	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODg1NDIyNX0.n9CZ4_E5ofP-r6Lc6ai9y43e86tCqSlJ7D1aQwy0YCQ	2025-02-06 10:03:45.255904
313	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODkyMzc5OX0.Fx-WBgOMUw7GAU2JAFI8_S1g7qSG6l3Z-H_oBvBUHyg	2025-02-07 05:23:19.225599
314	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczODk5MzYzOH0.F19SJUsMSbrF_M7u8bCWN_IUYN0fLr8bNszkfI4vc-I	2025-02-08 00:47:18.061906
315	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczOTAwNjI4OX0.6gepBw-ETUmLn3wTfDFOUc3GZ9mM7yLCvEqMUgaicZo	2025-02-08 04:18:09.753938
316	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczOTEwODE5MX0.hHs6lE1-8WUFsNQhDrvxIaTGAmUxAZrf2c16U8E6zDk	2025-02-09 08:36:31.997843
317	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczOTExODM2MX0.sbbaHpNXH5J_8VoJXki0P78gcyckI1S4q0vmzpFXimo	2025-02-09 11:26:01.880936
318	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczOTEzMzg5Mn0.yIfqVTFzqF7vqbxfmseWfIodMk_2yQmFMmkiMDW-ZY4	2025-02-09 15:44:52.600971
319	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczOTEzNDA3Mn0.6yv3rFxE-1XheQMrUYoVQ79z5pwobKyxlYtgGfkeXg8	2025-02-09 15:47:52.909565
320	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTE4MzE3NX0.s8SnAMam-qOUS_6jTH-8MoQNwNHxc6VqwpfyMoPEDSI	2025-02-10 05:26:15.753586
321	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkxODU5ODF9.LC3YaiwXKhTE4bv6QJ6IXIGW5CHDx0tjD_zeI5q_-kA	2025-02-10 06:13:01.12372
322	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkxODYwMjd9.FfBN5lQiVwWohwZY9OaLwXfdcSKAK0FRWJJ8Qjzq-VY	2025-02-10 06:13:47.073495
323	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkxODg1OTB9.RgSQB2pcRtIQDSOcMLFjojJoN3ozSE8KJFQQDJf3MU4	2025-02-10 06:56:30.078089
324	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkxODg3OTh9.0uE_vPYBCPHyShwCxk2KsT-4Nvup9u94JrUUZFAnV5I	2025-02-10 06:59:58.23321
325	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkxODg4ODB9.HNQBMAnh2jRthvoViqQN3V_bZ6Ey6HSzM0rUlMbaPAo	2025-02-10 07:01:20.043037
326	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkyNDQ2NDF9.EikAqQyHwKmclCgBMIhSUYP1dTwVpYztfBaDvIsR_yk	2025-02-10 22:30:41.653952
327	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczOTI3Nzc1OH0.8fsc-MlbGnIYlFcs0U4Bx08kufxwOxB_AXnCrVaHnRs	2025-02-11 07:42:38.824406
328	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTI3ODE5M30.G_0lBSNDfsdjTg9qGRnD2TK9W4XBfmk0cMECfaCzOUY	2025-02-11 07:49:53.836381
329	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkyNzg2Nzl9.pM0B_86vetYjQxUoZFYQ8wY3QcjJBM3xRUZgHc_sO78	2025-02-11 07:57:59.186373
330	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTI4MDA5NH0.m882CsEVKT-s7yzqEgUetIXrViIUU_GcRS2hItyX2C0	2025-02-11 08:21:34.892403
331	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkyODA0MDN9.gKTu4PBbogQHONK2D2XrexHutbq3sP-87GMEjSFvEVY	2025-02-11 08:26:43.946489
332	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTI4MDQ5NX0.3oJCn2cIY7ExK31cgEb20a8a5i9OQeKuw3nRLxHtJGM	2025-02-11 08:28:15.012179
333	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTczOTI4MTY4Nn0.md4ZCaC7h1BdIBqWsnjkYa8WJ1qAXv1OY_3PswPY1K8	2025-02-11 08:48:06.116186
334	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkyODIxNDV9.S5FxB64I05DqMNDC7M06HzmfOgtfRaZ2oC8A52297cg	2025-02-11 08:55:45.646507
335	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkyODI1MzZ9.LqyAuI2IU_n8eazjhFDQdyRH6NQ95OzEpmf-HalgBWM	2025-02-11 09:02:16.509849
336	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkzMzA4ODh9.cAe52pdco_vpzu4rW--6MnbHPW7gRczCmnRBPp8W344	2025-02-11 22:28:08.998498
337	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3MzkzMzI5NDZ9.S9h6DN5o1o8SrqyV6mIS0D0j7z1K3lHUi4XhdarGLWM	2025-02-11 23:02:26.823937
338	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTMzMzM1NH0.wW6ov79pJIRLxa8hU7kuQOdzAAumpdGwY0-AG90DgA0	2025-02-11 23:09:14.281026
339	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsImVtYWlsIjoiYXVsZXhjNGQyQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNzc3OTAwMCIsImxhdCI6bnVsbCwibG9uIjpudWxsLCJyb2xlX2lkIjozLCJpYXQiOjE3MzkzMzM2OTF9.ckk1Gz2SHqFyZ4myASTKa8L5irQ9SyJ8KfnqXG7rjkY	2025-02-11 23:14:51.640913
340	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3Mzk0MDIzMDZ9.3gQL2M3PkO40m7jUgtS5GVU3MEuBtNgayAzyy1f5KTk	2025-02-12 18:18:26.207632
341	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3Mzk0NDM3Nzl9.y8OOVNbGplqSFPIRhY6bTZ_8Rzp8nGZb4pYGrwqSam8	2025-02-13 05:49:39.369956
342	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTQ0NTk3MH0.0aZczuWXoId0B7-eJ1ahYV-x0GeoVj6nhw4P0rMAuWM	2025-02-13 06:26:10.981398
343	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTU1ODIzOX0.sLBGn1d6I_QoWevr2VQtEHJB83luzdjsrBjowQHfm54	2025-02-14 13:37:19.907425
344	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTU5NjU2M30._57CSU7_v90RQdgHpWZyQhP1Lb5EinBm8bGk1J--dgk	2025-02-15 00:16:03.810799
345	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3Mzk1OTcyMjl9._t58ot_ekd0ADnHc_JFt8zFc6WLwVFyTQ6MzHxGzM6k	2025-02-15 00:27:09.497278
346	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDIsImVtYWlsIjoiZHJleDAyQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNTg3Nzk5MDAiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzM5NTk3MzYzfQ.exgMqOSKiIbUeVv3By6W5-8WZdCZ0_ew1Lttk40qg7g	2025-02-15 00:29:23.760439
347	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzM5NzM3Mzg5fQ.1nPuh6pMRAMK0MRiBb6D2Kw_WkWUQ3adP_vuCQ0g1dY	2025-02-16 15:23:09.485946
348	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzM5NzM4MzM1fQ.DhcV_zKbnBtU2xSV0BstvlUW_GPEpwWZUN9xAyUaRbg	2025-02-16 15:38:55.174732
349	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzM5NzM4OTczfQ.x4jzIPzZNqtXHqLA3XKiajw_lP0qIvkdISxfvK2pGog	2025-02-16 15:49:33.654554
350	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQsImVtYWlsIjoibG91aXNAZ3VtcHJpZ2h0LmNvLnVrIiwicGhvbmUiOiIwNzc2MDkyNjcyNSIsImxhdCI6bnVsbCwibG9uIjpudWxsLCJyb2xlX2lkIjozLCJpYXQiOjE3Mzk3MzkyMTh9.TqOKsGmCqdRyOkY7p9dHGanUTVtiVK2_wK8l2zNROyQ	2025-02-16 15:53:38.796455
351	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTc1NTU3OX0.dDjAHPiBPkOF71ih3boxfsuqeP_HddkoPSslpGs2UU4	2025-02-16 20:26:19.720366
352	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3Mzk3OTg1OTR9.cE4FOVKjvvKS4b-AFhSrv18w2pfX89p7Iot7rG57X8o	2025-02-17 08:23:14.951148
353	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTc5ODg3Nn0.Fp0HFc39lMXR35k1HYtnn66P12vayN_Yc6pICc_YOGg	2025-02-17 08:27:56.493109
354	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTczOTgwMTE2MX0._iL69li3KQubFfTChNTGBvH3LG9OGo7kammWOu7lqGI	2025-02-17 09:06:01.649502
355	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3Mzk4MDE1NjR9.omeoWVtDgIbYGvGgjqm9GCmCAYGH5gF08L7gQcADmG8	2025-02-17 09:12:44.389899
356	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzM5ODU0MTUzfQ.7-dEDDDBmpsD5sLPMFg31uqtWMQVoklFdp0JHOGM1tI	2025-02-17 23:49:13.742486
357	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTc0MDEzNDIyNH0.jXD7OEWeNDwMDPDmhTjeyXV9eMHPck43sKzTJWSIj7w	2025-02-21 05:37:04.9153
358	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTc0MDEzNDQyNH0.2XgsBsCxP4fVurX0s0zjkssM1jmArJa0m7fRunVkH1o	2025-02-21 05:40:24.530719
359	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDAxNDU2NjF9.FjXVb49-nEpvjFhmB3Q39pacKA5i_vq7G4sbv9UFY1E	2025-02-21 08:47:41.093597
360	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwMzQ1MzgwfQ.UPjw0tVXPTHi7UHr0ljeFrlJpQjRE-6psTTrmfTv8I8	2025-02-23 16:16:20.277543
361	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwMzk5MDg3fQ.s395wYo3SYhLvWEYKQq7qaM5i6G0p7ScXojEpZC0BQg	2025-02-24 07:11:27.154819
362	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA1OTQxNjV9.0zHsDmmg-O9gDe7J7rB8Mqvm81GT-qBm15SA84hKv_k	2025-02-26 13:22:45.095787
363	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA2MTQ0MzZ9.oBLUuWYa-bou08ZFTlNwKG8Cg50CsPoVczq1Yd7MouI	2025-02-26 19:00:36.996531
364	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsImVtYWlsIjoiYXVsZXhjNGQyQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNzc3OTAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTc0MDYxOTUyM30.EIoFwshKe6iMem1tfeF8gTo58sSTSiK-FA3DNbBFbpQ	2025-02-26 20:25:23.45287
365	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA3NTA3MDV9.pQh_m7L4BL2CSS2aUC3iKtwIftI8q9nX7clSoCLxKL4	2025-02-28 08:51:45.32648
366	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA3NTA3Nzl9.8h9Eeljb4gAhiNvJJ7kozGmipsnZAZFXWiupbO0sf2A	2025-02-28 08:52:59.682708
367	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwNzcyOTY0fQ.Wj4pP2XyezJ_dOtqR-vUmzrmmRANDTmcU8Kh9pX7D0I	2025-02-28 15:02:44.577283
368	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA4MTY1NzB9.jXZcLuFHSg8tFdYgWxbfcmNI24kXRMwWnbgmAjlnlaU	2025-03-01 03:09:30.168983
369	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA4MTkxNjJ9.LvMnCsMzZOyJTmPtP1emFsb8eMqNUFvnnX9JxJAt1ZA	2025-03-01 03:52:42.712286
370	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA4MjU1MDR9.g8AyBSbgFb9TpwVt8wTyeiNJmdS4E8ZBEKYyRCQjBmw	2025-03-01 05:38:24.915963
371	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwODI3MTA0fQ.kW0cKUrbyWy-Uv4v2osp2Sj4Dznb2loVUrS92WtdgYw	2025-03-01 06:05:04.496928
372	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA4Mjg0MjV9.L5Rx0yAeOlnWxNF2WorSoFOwoW_IXcSwWrm0ALoh5Gc	2025-03-01 06:27:05.129975
373	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTc0MDgzMTQzMH0.hhFx9ZlQ4wjc8o5hV4diw6HzpxvZCHBVxv-7i_Vqg10	2025-03-01 07:17:10.031246
374	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwODMyMTg3fQ.7FzmPPsne66-IAokSoRcdDZ56NLRVHaFe0LIdIQGU5c	2025-03-01 07:29:47.875332
375	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTc0MDgzMzgxMH0.2mb2tMLqfkduNPLP6YEhEC9sq6uLk2usPcu8oUX0F68	2025-03-01 07:56:50.047659
376	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzQsImVtYWlsIjoid2lsbGFydGh1cmZvcmJlc0BnbWFpbC5jb20iLCJwaG9uZSI6IjA3MzExMzM0NDM2IiwibGF0IjpudWxsLCJsb24iOm51bGwsInJvbGVfaWQiOjMsImlhdCI6MTc0MDg0MTUzNn0.D0ykXdl2-BFAQb0bKcNSA19mbeoL2F2ye3qKQYvQOCU	2025-03-01 10:05:36.804166
377	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwODQxNTQ0fQ.xiwbfO9qDcV5B7hhRugngRlSiNpLeQJ5dibH-oo_YMo	2025-03-01 10:05:44.93752
378	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjgsImVtYWlsIjoiYXVsZXg1MDBAZ21haWwuY29tIiwicGhvbmUiOiI5MDg3MDQ3Nzg5MCIsImxhdCI6NDAuNzEyOCwibG9uIjotNzQuMDA2LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA4NzQyNTN9.6LxAS2BUbPUQlVBjyx_k0oF8-AWPqHbso8HTQO84CH0	2025-03-01 19:10:53.838123
379	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwODg2MTQ4fQ.cKV1dB8lqr_CLXfQgyrPqzPVxDjhsdLL96PxP6WQef0	2025-03-01 22:29:08.680935
380	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoiYm9uaWZhY2VwYXVsNTAwQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNTg3NzI3MTMiLCJsYXQiOjM4Ljc5NDU5NTIsImxvbiI6LTEwNi41MzQ4Mzc5LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA4ODY0OTN9.hhJszAgSZJq6ffah7rTX3dZCCc9hk4W6pbO_SnXSX7E	2025-03-01 22:34:53.095977
381	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDMsImVtYWlsIjoiZHJlYW1zaW11YXBwQGdtYWlsLmNvbSIsInBob25lIjoiMDkwMzgzNDk4ODMiLCJsYXQiOm51bGwsImxvbiI6bnVsbCwicm9sZV9pZCI6MywiaWF0IjoxNzQwODkyOTQ3fQ.uudXB2HzMqZfFFA88eKqevEtf1n1t7RsrKahKs7FJyk	2025-03-02 00:22:27.205243
382	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoiYm9uaWZhY2VwYXVsNTAwQGdtYWlsLmNvbSIsInBob25lIjoiMDgxNTg3NzI3MTMiLCJsYXQiOjM4Ljc5NDU5NTIsImxvbiI6LTEwNi41MzQ4Mzc5LCJyb2xlX2lkIjozLCJpYXQiOjE3NDA5MTM0ODF9.B3fgU5ADjQ4xgm8ZBOgF7GGxHyh1SAG9I1lLE1BKmKc	2025-03-02 06:04:41.421149
383	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoiaHRtbGRldjAwMUBnbWFpbC5jb20iLCJwaG9uZSI6IjEyNDg5MDc2MDAwIiwibGF0IjozOC43OTQ1OTUyLCJsb24iOi0xMDYuNTM0ODM3OSwicm9sZV9pZCI6MywiaWF0IjoxNzQwOTEzNTkwfQ.29J2a0QX7gL6x7Urv2MpmabN-8P0_q8ezfzjGd1_ZD4	2025-03-02 06:06:30.875315
384	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzQsImVtYWlsIjoid2lsbGFydGh1cmZvcmJlc0BnbWFpbC5jb20iLCJwaG9uZSI6IjA3MzExMzM0NDM2IiwibGF0IjpudWxsLCJsb24iOm51bGwsInJvbGVfaWQiOjMsImlhdCI6MTc0MDkyMTQ3M30.CDsbEeZvucUrKETHs3a4qvERBhFvtpXdtjJkQVAcseY	2025-03-02 08:17:53.755086
385	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ0ZXN0MDFAZ21haWwuY29tIiwicGhvbmUiOiIwOTAwMDAwMDAwMCIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjEsImlhdCI6MTc0MDk0NDg0MH0.aEtCajosgbHZSjEo9CpLou4ot9VbMZJrpwQ9RvMW7IM	2025-03-02 14:47:20.571059
386	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzAsImVtYWlsIjoiZWR1cHJvZG90bmdAZ21haWwuY29tIiwicGhvbmUiOiIwOTAzMjY1NjE4NyIsImxhdCI6MzguNzk0NTk1MiwibG9uIjotMTA2LjUzNDgzNzksInJvbGVfaWQiOjMsImlhdCI6MTc0MDk0NTM4N30.fqvUb1Evg-p1Q94gDn3TuFy2PlKl87bIVHTT-RjMP1c	2025-03-02 14:56:27.268412
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.roles (id, name, description, created_at, updated_at) FROM stdin;
1	Admin	For admin only	2025-01-29 18:10:23.835384	2025-01-29 18:10:23.835384
2	Staff	For staff only	2025-01-29 18:10:39.451938	2025-01-29 18:10:39.451938
3	Customer	For customers only	2025-01-29 18:11:03.716639	2025-01-29 18:11:03.716639
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.skills (id, user_id, skill_type, experience_level, hourly_rate, spark_token, description, approval_status, created_at, updated_at, thumbnail01, thumbnail02, thumbnail03, thumbnail04) FROM stdin;
28	42	Plumbing	intermediate	50	\N	Just plumbing and other synthetic work services......6 dolls	published	2025-02-15 00:32:14.436845	2025-02-15 00:32:14.436845	testapi.humanserve.net/routes/uploads/skills/1739597534284-970900485.jpg	testapi.humanserve.net/routes/uploads/skills/1739597534286-148577970.jpg	testapi.humanserve.net/routes/uploads/skills/1739597534381-776699554.jpg	testapi.humanserve.net/routes/uploads/skills/1739597534381-443791219.jpg
26	28	Cabinet Installation	intermediate	5.00	\N	alway active and deliver	draft	2025-01-29 18:31:19.501299	2025-01-29 18:31:19.501299	testapi.humanserve.net/routes/uploads/skills/1738193479443-511375191.jpeg	testapi.humanserve.net/routes/uploads/skills/1738193479446-588982417.jpeg	testapi.humanserve.net/routes/uploads/skills/1738193479446-492430617.jpeg	testapi.humanserve.net/routes/uploads/skills/1738193479447-280281268.jpeg
17	5	Cleaner	intermediate	20	\N	none is fine	published	2025-01-19 19:37:30.58663	2025-01-19 19:37:30.58663	testapi.humanserve.net/routes/uploads/skills/1737458080116-496421522.png	testapi.humanserve.net/routes/uploads/skills/1737333450533-134790827.jpeg	testapi.humanserve.net/routes/uploads/skills/1737333450534-965170223.jpeg	\N
18	1	Barber	Expert	10	\N	I am a good barber	published	2025-01-20 23:07:49.364719	2025-01-20 23:07:49.364719	\N	\N	\N	\N
19	5	Plumbing	expert	500	\N	I specialize in providing top-quality plumbing solutions to ensure your home’s water systems run smoothly. With expertise in installing, repairing, and maintaining pipes and fixtures, I guarantee efficient and lasting results.\r\n\r\nWhy Choose My Services?\r\n\r\nProfessional Expertise: Years of experience handling a variety of plumbing needs.\r\nFast & Reliable: Quick response to emergencies and timely project completion.\r\nAffordable Pricing: High-quality services at competitive rates.\r\nServices Offered:\r\n\r\nLeak repairs\r\nPipe installations and replacements\r\nDrain cleaning\r\nFaucet and fixture repairs\r\nLet me help you maintain a functional and comfortable home. Contact me today for reliable plumbing services tailored to your needs!\r\n\r\nFeel free to replace “plumbing” with your desired skill or service. If you want me to tailor it further, let me know!\r\n\r\n\r\n\r\n	published	2025-01-21 07:16:59.366297	2025-01-21 07:16:59.366297	testapi.humanserve.net/routes/uploads/skills/1737461819105-1308188.jpg	testapi.humanserve.net/routes/uploads/skills/1737461819107-335951604.jpg	testapi.humanserve.net/routes/uploads/skills/1737461819111-576760146.jpg	testapi.humanserve.net/routes/uploads/skills/1737461819305-522548109.jpg
23	30	Drywall Installation and Repair	expert	4	\N	i am good at what i do	draft	2025-01-24 11:04:31.864553	2025-01-24 11:04:31.864553	testapi.humanserve.net/routes/uploads/skills/1737734736868-882978204.JPG	testapi.humanserve.net/routes/uploads/skills/1737734671764-794322139.jpeg	\N	\N
25	28	House Cleaning	beginner	5.00	\N	ok	draft	2025-01-28 05:24:50.072352	2025-01-28 05:24:50.072352	testapi.humanserve.net/routes/uploads/skills/1738059889973-527076388.jpeg	testapi.humanserve.net/routes/uploads/skills/1738059890000-842844038.png	testapi.humanserve.net/routes/uploads/skills/1738059890001-317534805.jpeg	testapi.humanserve.net/routes/uploads/skills/1738059890002-642574923.jpeg
30	43	Bathroom Remodeling	beginner	3	\N	i am good	draft	2025-02-16 15:33:11.174389	2025-02-16 15:33:11.174389	testapi.humanserve.net/routes/uploads/skills/1739737984373-990180379.png	\N	\N	\N
27	31	Plumbing	beginner	80	\N	\r\n"Hello, I just wanted to let you know that I’m a beginner in plumbing. I’m eager to learn and improve, so I appreciate any guidance or advice you can offer. Looking forward to working with	published	2025-02-11 23:18:25.498638	2025-02-11 23:18:25.498638	testapi.humanserve.net/routes/uploads/skills/1739333905250-295866385.jpg	testapi.humanserve.net/routes/uploads/skills/1739333905251-378838638.jpg	testapi.humanserve.net/routes/uploads/skills/1739333905347-467672511.jpg	testapi.humanserve.net/routes/uploads/skills/1739333905397-320489081.jpg
24	27	Bathroom Remodeling	beginner	5.00	\N	Modern	published	2025-01-28 05:14:54.123688	2025-01-28 05:14:54.123688	testapi.humanserve.net/routes/uploads/skills/1738059293858-134876089.jpg	testapi.humanserve.net/routes/uploads/skills/1738059293859-36132075.jpg	testapi.humanserve.net/routes/uploads/skills/1738059293900-108175658.jpg	testapi.humanserve.net/routes/uploads/skills/1738059294100-853928421.jpg
\.


--
-- Data for Name: skills_category; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.skills_category (id, title, description, thumbnail, status, created_at, updated_at) FROM stdin;
1	furniture Installations	for furniture Installations	testapi.humanserve.net/routes/uploads/profile/1739189104029-550506359.jpg	published	2025-02-10 07:05:05.149095	2025-02-10 07:05:05.149095
2	baking 	cake 	testapi.humanserve.net/routes/uploads/profile/1739280999970-343048459.jpeg	published	2025-02-11 08:36:40.15599	2025-02-11 08:36:40.15599
3	tailor	sowing	testapi.humanserve.net/routes/uploads/profile/1739281072157-877705192.jpeg	published	2025-02-11 08:37:52.378483	2025-02-11 08:37:52.378483
4	Fashion& Designing	Fashion and designing in clothing involve the art of creating stylish, functional, and aesthetically appealing garments. It blends creativity with technical skills to produce unique designs that reflect culture, trends, and individuality. From sketching ideas to selecting fabrics and finalizing patterns, fashion designing requires attention to detail, innovation, and an understanding of color theory, textiles, and body proportions.	testapi.humanserve.net/routes/uploads/profile/1739281877403-253732690.png	published	2025-02-11 08:51:19.438221	2025-02-11 08:51:19.438221
5	Plumbing	Plumbing involves the installation, maintenance, and repair of water supply systems, drainage, and sewage systems in residential, commercial, and industrial buildings. It includes tasks such as fixing leaks, unclogging drains, installing pipes, water heaters, faucets, and other plumbing fixtures. A professional plumber ensures the safe and efficient flow of water and waste, adhering to building codes and safety regulations.	testapi.humanserve.net/routes/uploads/profile/1739333514373-247947780.jpeg	published	2025-02-11 23:11:54.455282	2025-02-11 23:11:54.455282
6	farming	just farm	testapi.humanserve.net/routes/uploads/profile/1739558539603-341255034.jpeg	published	2025-02-14 13:42:19.841811	2025-02-14 13:42:19.841811
7	Electrician	An Electrician is a skilled tradesperson responsible for installing, maintaining, and repairing electrical systems in residential, commercial, and industrial settings. Their duties include:\r\n\r\nInstalling wiring, outlets, circuit breakers, and lighting fixtures.\r\nTroubleshooting and repairing electrical issues to ensure safety and efficiency.\r\nReading and interpreting technical blueprints and wiring diagrams.	testapi.humanserve.net/routes/uploads/profile/1739599025310-522251140.jpg	published	2025-02-15 00:57:05.897256	2025-02-15 00:57:05.897256
\.


--
-- Data for Name: stripe_account; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.stripe_account (id, user_id, stripe_account_id, charges_enabled, payouts_enabled, details_submitted, created_at, updated_at) FROM stdin;
3	1	acct_1QvPVR05Ynube4Zo	f	f	f	2025-02-22 15:41:04.462227	2025-02-22 15:41:04.462227
4	28	acct_1QwuZDP5bmTXYfVK	f	f	f	2025-02-26 19:03:09.852783	2025-02-26 19:03:09.852783
5	31	acct_1QwvxFP3Vv4KenJc	f	f	f	2025-02-26 20:32:03.680419	2025-02-26 20:32:03.680419
6	43	acct_1QxaNMP0PchU0Vna	f	f	f	2025-02-28 15:41:43.794491	2025-02-28 15:41:43.794491
7	26	acct_1Qy3K007YQmLz1m2	f	f	f	2025-03-01 22:36:11.269093	2025-03-01 22:36:11.269093
8	27	acct_1QyANk05rqVv9niQ	f	f	f	2025-03-02 06:08:30.57128	2025-03-02 06:08:30.57128
9	34	acct_1QyCay00LzUL9Avi	f	f	f	2025-03-02 08:30:19.53938	2025-03-02 08:30:19.53938
10	30	acct_1QyTZjP6pGRIsS4Q	f	f	f	2025-03-03 02:38:09.532749	2025-03-03 02:38:09.532749
\.


--
-- Data for Name: suggest_skills; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.suggest_skills (id, user_id, name, approval_status, created_at, updated_at) FROM stdin;
1	1	Wall painter	accepted	2024-12-15 10:58:54.671575	2024-12-15 10:58:54.671575
2	1	Nail technician	accepted	2024-12-15 11:05:10.235121	2024-12-15 11:05:10.235121
7	1	hair stylist	pending	2024-12-15 11:28:14.502318	2024-12-15 11:28:14.502318
6	1	Phone technician	rejected	2024-12-15 11:23:40.707616	2024-12-15 11:23:40.707616
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.users (id, phone, email, firstname, lastname, gender, password, notification_type, appearance_mode, created_at, updated_at, photourl, google_id, bio, location, street, zip_code, verification_code, is_email_verified, lat, lon, radius, location_updated_at, role_id, referred_by, referral_code, website) FROM stdin;
22	08158772715	aulex00@gmail.com	aulex	script	M	$2b$10$GcJv0GcnJZ/ht9mSKhNBj.rJv6OzRoX9uYCRHPwDLt8ICUy1BVbL.	\N	\N	2025-01-23 05:30:39.256962	2025-01-23 05:30:39.256962	\N	\N	\N	\N	\N	\N	7762	0	\N	\N	\N	\N	3	\N	\N	\N
29	\N	olaniyihoppee@gmail.com	Olaniyi	Hope	\N	\N	\N	\N	2025-01-24 09:56:38.07199	2025-01-24 09:56:38.07199	https://lh3.googleusercontent.com/a/ACg8ocLgTf7Zs5RORAvpWtUbMpw9oYSASSYz8IJbVyjh1iMXlIvnuQ=s96-c	116234998303079199231	\N	\N	\N	\N	\N	0	\N	\N	\N	\N	3	\N	\N	\N
5	09000000001	test02@gmail.com	tester02	me02	male	$2b$10$k52Pr3PXJ//D3Cgb6RjcBumW4TjlE2o0g4HuoraOlCQoxMkoUHaB.	\N	\N	2024-12-13 15:39:01.766003	2024-12-13 15:39:01.766003	testapi.humanserve.net/routes/uploads/profile/1737461076071-336873355.jpeg	3	software developer and creative artist. With a knack for problem-solving and an eye for aesthetics, I combine technical expertise with artistic expression to build innovative solutions and inspiring creations. Whether coding functional apps or crafting visual masterpieces, I thrive at the intersection of logic and creativity.	enugu state	nuskka	20002	\N	0	38.7945952000000034	-106.534837899999999	3458697.58452386549	\N	3	\N	\N	\N
7	09000000002	test03@gmail.com	tester02	me02	female	$2b$10$AttSgdsbOcw4G67Mgv0MU.qrWhLZgrNJUSgYn.HJSetX.Blhsayjq	\N	\N	2024-12-15 02:40:23.565626	2024-12-15 02:40:23.565626	2	1	\N	\N	\N	\N	\N	0	38.7945952000000034	-106.534837899999999	3458697.58452386549	2025-01-27T13:30:18.184Z	3	\N	\N	\N
33	\N	willforbes02@gmail.com	William	Forbes	\N	\N	\N	\N	2025-01-27 15:03:30.100212	2025-01-27 15:03:30.100212	https://lh3.googleusercontent.com/a/ACg8ocJceofyIK4HN7YjUcQjM4WCoc0HN5fZvS4Va0nYOen7LXBEKaNBEQ=s96-c	118411359152668307808	\N	\N	\N	\N	\N	0	\N	\N	\N	2025-01-27 15:03:30.100212-05	3	\N	\N	\N
27	12489076000	htmldev001@gmail.com	java	jasaaa	male	$2b$10$TpkRYi3Rh1FHAZCNDDg3uOZ5I2ULZk8QcouENKme8rA29POkXtBOO	\N	\N	2025-01-24 01:49:30.957405	2025-01-24 01:49:30.957405	testapi.humanserve.net/routes/uploads/profile/1738059236247-891838232.jpg	\N	My main bio..	Enugu state	No 10.new Anglican 	20890	\N	1	38.7945952000000034	-106.534837899999999	3458697.58452386549	2025-01-27T19:24:02.722Z	3	\N	\N	\N
23	09000773644	gideonconnect@gmail.com	Tester	me02	male	$2b$10$tFP32DHPxExDHGm8VWhjFe5h8E2t1wyDO9FB.2UF4lAd5UdMtjmKu	\N	\N	2025-01-23 09:20:06.499721	2025-01-23 09:20:06.499721	\N	\N	\N	\N	\N	\N	\N	1	38.7945952000000034	-106.534837899999999	3458697.58452386549	\N	3	\N	\N	\N
30	09032656187	eduprodotng@gmail.com	Edu pro	Solution	male	$2b$10$1rTY8NuzNrsFk39OwZrky.KGZ5KPzmcAjaQREHjWPDVdD.5ho6GWS	\N	\N	2025-01-24 11:00:47.404238	2025-01-24 11:00:47.404238	testapi.humanserve.net/routes/uploads/profile/1739278040820-292358309.JPG	\N	\N	Lagos	7, Accord Road	101101	\N	1	38.7945952000000034	-106.534837899999999	3458697.58452386549	2025-01-30T18:49:27.191Z	3	\N	\N	
1	09000000000	test01@gmail.com	Skilloviaaa	App	male	$2b$10$iiu0LGcdkW5Tuv4cNVwM8eBiaOWWGekI45BKB8JlDRMtoJ7uSA7re	sms	dark	2024-12-13 09:30:32.439668	2024-12-13 09:30:32.439668	testapi.humanserve.net/routes/uploads/profile/1737212555085-955651905.png	2	I am very hard working	ikeja lagos	73 rellign street	8374	\N	0	38.7945952000000034	-106.534837899999999	3458697.58452386549	2025-01-29T23:57:24.875Z	1	\N	\N	\N
35	0909009988	test04@gmail.com	kenneth	Matte	male	$2b$10$s6OwLoOnh3msN7A7wm0KZunuIjxUotREmQFKQmJrbwJEGBTBNOIgq	\N	\N	2025-01-29 19:08:13.205067	2025-01-29 19:08:13.205067	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	2025-01-29 19:08:13.205067-05	3	\N	\N	\N
31	0817779000	aulexc4d2@gmail.com	Marcello	Paul	male	$2b$10$DY0NuIQpwP4WB1ZXUdgmA.aeNQRbpvrylFKsEGNgRyeoytNmM0TBy	\N	\N	2025-01-24 16:00:39.710344	2025-01-24 16:00:39.710344	testapi.humanserve.net/routes/uploads/profile/1739333779337-999164598.jpg	\N	Be too good...in what ever you're doing 	No location available	No street available	No zip code available	\N	1	38.7945952000000034	-106.534837899999999	3458697.58452386549	2025-02-12T04:14:51.717Z	3	\N	\N	
44	07760926725	louis@gumpright.co.uk	Louis	Gumpright	male	$2b$10$3nWMmfi/pWtZw1gB/OBStO51lJQesoKSEwN0P36zzwlEyaoha5us.	\N	\N	2025-02-16 15:53:20.30845	2025-02-16 15:53:20.30845	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	2025-02-16 15:53:20.30845-05	3	\N	Louis389458	\N
26	08158772713	bonifacepaul500@gmail.com	Aulex	scriptDev	male	$2b$10$VqbHr2XQ0YxWlkAJTiZXouCCQ3pwAbQ.bZImfRV5NpiSJkaJGmtAW	\N	\N	2025-01-24 01:47:22.648106	2025-01-24 01:47:22.648106	testapi.humanserve.net/routes/uploads/profile/1738528780965-942680371.jpeg	\N	\N	\N	\N	\N	\N	1	38.7945952000000034	-106.534837899999999	3458697.58452386549	2025-02-02T20:39:06.683Z	3	\N	\N	\N
28	90870477890	aulex500@gmail.com	Johnnyy	Doeeee	male	$2b$10$zzHCgQNymYQGQ4vfpmw5K.Y6xD36/rn3xcyf0qzzrNrK3ohT7EVDy	\N	\N	2025-01-24 02:44:38.309709	2025-01-24 02:44:38.309709	testapi.humanserve.net/routes/uploads/profile/1739152417915-916426168.png	\N	skilled cabinet installer with [X] years of experience in designing, assembling, and installing high-quality cabinetry for residential and commercial spaces. With a keen eye for detail and a commitment to precision, [Your Name] ensures seamless installations that enhance both functionality and aesthetics. Whether it's a custom kitchen, bathroom, or office setup, [Your Name] takes pride in delivering durable and stylish cabinetry solutions tailored to clients' needs.	New York	123 Main Street	20022	\N	1	40.7128000000000014	-74.0060000000000002	3458697.58452386549	2025-01-27T19:34:15.540Z	3	Jane Smith	skv251823	https://p-folio-two.vercel.app/
40	\N	oriazowandavid@gmail.com	oriazowan	david	\N	\N	\N	\N	2025-02-04 18:04:34.838017	2025-02-04 18:04:34.838017	https://lh3.googleusercontent.com/a/ACg8ocITG02EYMgN4Wc06pW1s8N9n1SXMHNjUp6c-vpwSpGHlaD5TkKk=s96-c	101624316701378320598	\N	\N	\N	\N	\N	0	\N	\N	\N	2025-02-04 18:04:34.838017-05	3	\N	\N	\N
41	\N	kcarrr4@gmail.com	Kyle	Carr	\N	\N	\N	\N	2025-02-08 12:29:12.055554	2025-02-08 12:29:12.055554	https://lh3.googleusercontent.com/a/ACg8ocLXhDnZfAdZDZMWLAPu-hbgeDIEjwpIL-cKlbvtXspRcU1EtA=s96-c	105784587185799920316	\N	\N	\N	\N	\N	0	\N	\N	\N	2025-02-08 12:29:12.055554-05	3	\N	\N	\N
42	08158779900	drex02@gmail.com	Drex	Ezinne	male	$2b$10$u.2YR9bx2Zieo3Lcc5pb5u8IzN/gHcUR35SQdjE0uU.UyhDZkTD.W	\N	\N	2025-02-14 14:14:55.808142	2025-02-14 14:14:55.808142	testapi.humanserve.net/routes/uploads/profile/1739597664664-845726002.jpg	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	2025-02-14 14:14:55.808142-05	3	\N	\N	\N
43	09038349883	dreamsimuapp@gmail.com	Dream	Simu	female	$2b$10$JxfMjLFGua9kKoOCJiY0buN1Ok88TnRUNCH/9beFx7jUO1b2TpFWC	\N	\N	2025-02-16 15:22:55.965071	2025-02-16 15:22:55.965071	testapi.humanserve.net/routes/uploads/profile/1739738221306-298963356.png	\N	i am a tailor	abuja Nigeria	wuye	100001	\N	1	\N	\N	\N	2025-02-16 15:22:55.965071-05	3	\N	Dream501120	dreamsimu.com
34	07311334436	willarthurforbes@gmail.com	William	Forbes	male	$2b$10$HoF1KhTyLdLTMaePZ9PspeHYa1xnJLBCohnyWc6umZXoL7UiXa0gK	\N	\N	2025-01-27 15:08:16.495179	2025-01-27 15:08:16.495179	\N	\N	\N	Leeds	20 McClintock House	LS10 1LP	\N	1	\N	\N	\N	2025-01-27 15:08:16.495179-05	3	\N	\N	
\.


--
-- Data for Name: verifyemail; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.verifyemail (id, email, token, created_at, updated_at) FROM stdin;
1	gideonconnect@gmail.com	7597	2025-01-23 07:37:45.18204	2025-01-23 07:37:45.18204
3	aulex@gmail.com	6448	2025-01-23 22:21:25.022697	2025-01-23 22:21:25.022697
4	a@gmail.com	3048	2025-01-23 22:23:39.569968	2025-01-23 22:23:39.569968
7	bonifacepaul500@gmail.com	7133	2025-01-23 22:45:30.566477	2025-01-23 22:45:30.566477
5	htmldev001@gmail.com	5979	2025-01-23 22:31:04.246176	2025-01-23 22:31:04.246176
2	aulex500@gmail.com	5433	2025-01-23 09:22:34.525379	2025-01-23 09:22:34.525379
9	eduprodotng@gmail.com	8984	2025-01-24 10:59:52.255811	2025-01-24 10:59:52.255811
6	aulexc4d2@gmail.com	4303	2025-01-23 22:42:36.949668	2025-01-23 22:42:36.949668
10	willforbes02@gmail.com	7945	2025-01-27 15:04:32.951282	2025-01-27 15:04:32.951282
11	willarthurforbes@gmail.com	9195	2025-01-27 15:07:27.707256	2025-01-27 15:07:27.707256
8	olaniyihoppee@gmail.com	1893	2025-01-24 10:00:02.767129	2025-01-24 10:00:02.767129
12	dreamsimuapp@gmail.com	4817	2025-02-16 15:20:02.905405	2025-02-16 15:20:02.905405
13	louis@gumpright.co.uk	8166	2025-02-16 15:52:33.618067	2025-02-16 15:52:33.618067
\.


--
-- Data for Name: withdrawal_methods; Type: TABLE DATA; Schema: public; Owner: humaoqjw
--

COPY public.withdrawal_methods (id, user_id, bank_name, account_number, account_name, created_at, updated_at) FROM stdin;
2	1	union bank	887276636	jemmy Hodl	2024-12-31 13:39:48.299019	2024-12-31 13:39:48.299019
5	5	Bank of Test	1234567890	John Doe	2025-01-16 22:27:28.237747	2025-01-16 22:27:28.237747
6	5	Access Bank	1440908976	script dev	2025-01-16 22:29:07.956909	2025-01-16 22:29:07.956909
8	5	Zennith Bank	1440908976	script dev	2025-01-16 22:40:00.243864	2025-01-16 22:40:00.243864
12	1	Kuda	1440908976	script dev	2025-01-16 23:03:05.769416	2025-01-16 23:03:05.769416
15	1	BANKK	1440908976	TST	2025-01-17 22:27:48.673205	2025-01-17 22:27:48.673205
\.


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.account_id_seq', 1, false);


--
-- Name: account_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.account_user_id_seq', 1, false);


--
-- Name: billing_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.billing_methods_id_seq', 10, true);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.bookings_id_seq', 29, true);


--
-- Name: follows_follower_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.follows_follower_id_seq', 1, false);


--
-- Name: follows_following_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.follows_following_id_seq', 1, false);


--
-- Name: follows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.follows_id_seq', 24, true);


--
-- Name: kyc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.kyc_id_seq', 16, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.messages_id_seq', 66, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 7, true);


--
-- Name: refreshtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.refreshtoken_id_seq', 386, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: skills_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.skills_category_id_seq', 7, true);


--
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.skills_id_seq', 30, true);


--
-- Name: stripe_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.stripe_account_id_seq', 10, true);


--
-- Name: suggest_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.suggest_skills_id_seq', 7, true);


--
-- Name: suggest_skills_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.suggest_skills_user_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.users_id_seq', 44, true);


--
-- Name: verifyemail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.verifyemail_id_seq', 13, true);


--
-- Name: withdrawal_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: humaoqjw
--

SELECT pg_catalog.setval('public.withdrawal_methods_id_seq', 17, true);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: billing_methods billing_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.billing_methods
    ADD CONSTRAINT billing_methods_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: kyc kyc_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.kyc
    ADD CONSTRAINT kyc_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- Name: refreshtoken refreshtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.refreshtoken
    ADD CONSTRAINT refreshtoken_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: skills_category skills_category_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.skills_category
    ADD CONSTRAINT skills_category_pkey PRIMARY KEY (id);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: stripe_account stripe_account_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.stripe_account
    ADD CONSTRAINT stripe_account_pkey PRIMARY KEY (id);


--
-- Name: suggest_skills suggest_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.suggest_skills
    ADD CONSTRAINT suggest_skills_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: verifyemail verifyemail_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.verifyemail
    ADD CONSTRAINT verifyemail_pkey PRIMARY KEY (id);


--
-- Name: withdrawal_methods withdrawal_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.withdrawal_methods
    ADD CONSTRAINT withdrawal_methods_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: humaoqjw
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: TABLE account; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.account TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.account TO humaoqjw_skilloviadb;


--
-- Name: COLUMN account.id; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL(id) ON TABLE public.account TO humaoqjw_skillovia_u;
GRANT ALL(id) ON TABLE public.account TO humaoqjw_skilloviadb;


--
-- Name: COLUMN account.user_id; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL(user_id) ON TABLE public.account TO humaoqjw_skillovia_u;
GRANT ALL(user_id) ON TABLE public.account TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE account_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.account_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.account_id_seq TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE account_user_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.account_user_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.account_user_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE billing_methods; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.billing_methods TO PUBLIC;
GRANT ALL ON TABLE public.billing_methods TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.billing_methods TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE billing_methods_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.billing_methods_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.billing_methods_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE bookings; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.bookings TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.bookings TO humaoqjw_skilloviadb;


--
-- Name: COLUMN bookings.id; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL(id) ON TABLE public.bookings TO humaoqjw_skillovia_u;
GRANT ALL(id) ON TABLE public.bookings TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE bookings_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.bookings_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.bookings_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE follows; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.follows TO humaoqjw_skilloviadb;
GRANT ALL ON TABLE public.follows TO humaoqjw_skillovia_u;


--
-- Name: SEQUENCE follows_follower_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.follows_follower_id_seq TO humaoqjw_skillovia_u WITH GRANT OPTION;
GRANT ALL ON SEQUENCE public.follows_follower_id_seq TO humaoqjw_skilloviadb WITH GRANT OPTION;


--
-- Name: SEQUENCE follows_following_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.follows_following_id_seq TO humaoqjw_skillovia_u WITH GRANT OPTION;
GRANT ALL ON SEQUENCE public.follows_following_id_seq TO humaoqjw_skilloviadb WITH GRANT OPTION;


--
-- Name: SEQUENCE follows_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.follows_id_seq TO humaoqjw_skillovia_u WITH GRANT OPTION;
GRANT ALL ON SEQUENCE public.follows_id_seq TO humaoqjw_skilloviadb WITH GRANT OPTION;


--
-- Name: TABLE kyc; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.kyc TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.kyc TO humaoqjw_skilloviadb;


--
-- Name: COLUMN kyc.id; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL(id) ON TABLE public.kyc TO humaoqjw_skillovia_u;
GRANT ALL(id) ON TABLE public.kyc TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE kyc_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.kyc_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.kyc_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.messages TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.messages TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE messages_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.messages_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.messages_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE notifications; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.notifications TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.notifications TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE notifications_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.notifications_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.notifications_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE password_reset_tokens; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.password_reset_tokens TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.password_reset_tokens TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE password_reset_tokens_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.password_reset_tokens_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.password_reset_tokens_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE refreshtoken; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.refreshtoken TO humaoqjw_skilloviadb;
GRANT ALL ON TABLE public.refreshtoken TO humaoqjw_skillovia_u;


--
-- Name: SEQUENCE refreshtoken_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.refreshtoken_id_seq TO humaoqjw_skillovia_u WITH GRANT OPTION;
GRANT ALL ON SEQUENCE public.refreshtoken_id_seq TO humaoqjw_skilloviadb WITH GRANT OPTION;


--
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.roles TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.roles TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE roles_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.roles_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.roles_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE skills; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.skills TO humaoqjw_skilloviadb;
GRANT ALL ON TABLE public.skills TO humaoqjw_skillovia_u;


--
-- Name: TABLE skills_category; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.skills_category TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.skills_category TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE skills_category_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.skills_category_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.skills_category_id_seq TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE skills_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.skills_id_seq TO humaoqjw_skillovia_u WITH GRANT OPTION;
GRANT ALL ON SEQUENCE public.skills_id_seq TO humaoqjw_skilloviadb WITH GRANT OPTION;


--
-- Name: TABLE stripe_account; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.stripe_account TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.stripe_account TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE stripe_account_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.stripe_account_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.stripe_account_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE suggest_skills; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.suggest_skills TO humaoqjw_skilloviadb;
GRANT ALL ON TABLE public.suggest_skills TO humaoqjw_skillovia_u;


--
-- Name: SEQUENCE suggest_skills_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.suggest_skills_id_seq TO humaoqjw_skillovia_u WITH GRANT OPTION;
GRANT ALL ON SEQUENCE public.suggest_skills_id_seq TO humaoqjw_skilloviadb WITH GRANT OPTION;


--
-- Name: SEQUENCE suggest_skills_user_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.suggest_skills_user_id_seq TO humaoqjw_skillovia_u WITH GRANT OPTION;
GRANT ALL ON SEQUENCE public.suggest_skills_user_id_seq TO humaoqjw_skilloviadb WITH GRANT OPTION;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.users TO humaoqjw_skilloviadb;
GRANT ALL ON TABLE public.users TO humaoqjw_skillovia_u;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.users_id_seq TO PUBLIC;
GRANT ALL ON SEQUENCE public.users_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.users_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE verifyemail; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.verifyemail TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.verifyemail TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE verifyemail_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.verifyemail_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.verifyemail_id_seq TO humaoqjw_skilloviadb;


--
-- Name: TABLE withdrawal_methods; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON TABLE public.withdrawal_methods TO humaoqjw_skillovia_u;
GRANT ALL ON TABLE public.withdrawal_methods TO humaoqjw_skilloviadb;


--
-- Name: SEQUENCE withdrawal_methods_id_seq; Type: ACL; Schema: public; Owner: humaoqjw
--

GRANT ALL ON SEQUENCE public.withdrawal_methods_id_seq TO humaoqjw_skillovia_u;
GRANT ALL ON SEQUENCE public.withdrawal_methods_id_seq TO humaoqjw_skilloviadb;


--
-- PostgreSQL database dump complete
--

