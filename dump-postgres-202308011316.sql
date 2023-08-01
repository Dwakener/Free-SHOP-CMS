--
-- PostgreSQL database cluster dump
--

-- Started on 2023-08-01 13:16:39

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-08-01 13:16:39

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

-- Completed on 2023-08-01 13:16:39

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-08-01 13:16:39

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

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 237 (class 1255 OID 16398)
-- Name: create_customer(character varying, character varying, text, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_customer(first_name character varying, last_name character varying, delivery_address text, email character varying, phone_number character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    customer_id INTEGER;
BEGIN
    -- Вставляем данные покупателя в таблицу "Покупатели"
    INSERT INTO Customers (First_Name, Last_Name, Delivery_Address, Email, Phone_Number)
    VALUES (first_name, last_name, delivery_address, email, phone_number)
    RETURNING ID INTO customer_id;

    RETURN customer_id;
END;
$$;


ALTER FUNCTION public.create_customer(first_name character varying, last_name character varying, delivery_address text, email character varying, phone_number character varying) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 16399)
-- Name: create_order(integer, date, numeric, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_order(customer_id integer, order_date date, order_total numeric, order_status character varying, delivery_method character varying, payment_method character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    order_id INTEGER;
BEGIN
    -- Вставляем данные заказа в таблицу "Заказы"
    INSERT INTO Orders (Customer_ID, Order_Date, Order_Total, Order_Status, Delivery_Method, Payment_Method)
    VALUES (customer_id, order_date, order_total, order_status, delivery_method, payment_method)
    RETURNING ID INTO order_id;

    RETURN order_id;
END;
$$;


ALTER FUNCTION public.create_order(customer_id integer, order_date date, order_total numeric, order_status character varying, delivery_method character varying, payment_method character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 230 (class 1259 OID 16513)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16512)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 229
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 215 (class 1259 OID 16406)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    delivery_address text NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(20) NOT NULL,
    password_hash character varying,
    user_type_id integer
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16411)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO postgres;

--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 216
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 217 (class 1259 OID 16412)
-- Name: discounts_and_promotions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discounts_and_promotions (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    discount_amount numeric(5,2) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE public.discounts_and_promotions OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16417)
-- Name: discounts_and_promotions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discounts_and_promotions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discounts_and_promotions_id_seq OWNER TO postgres;

--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 218
-- Name: discounts_and_promotions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discounts_and_promotions_id_seq OWNED BY public.discounts_and_promotions.id;


--
-- TOC entry 219 (class 1259 OID 16418)
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    message text NOT NULL
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16423)
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO postgres;

--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 220
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- TOC entry 221 (class 1259 OID 16424)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    order_date date NOT NULL,
    order_total numeric(10,2) NOT NULL,
    order_status character varying(50) NOT NULL,
    delivery_method character varying(100) NOT NULL,
    payment_method character varying(100) NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16427)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- TOC entry 223 (class 1259 OID 16428)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    payment_date date NOT NULL,
    payment_amount numeric(10,2) NOT NULL,
    payment_status character varying(50) NOT NULL,
    payment_system character varying(100) NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16431)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO postgres;

--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 224
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 232 (class 1259 OID 16523)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) NOT NULL,
    category_id integer,
    brand character varying(50),
    weight numeric(8,2),
    color character varying(20),
    material character varying(50),
    stock_quantity integer,
    is_available boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    image_url character varying
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16522)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 231
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 225 (class 1259 OID 16440)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    rating numeric(2,1) NOT NULL,
    review_text text,
    review_date date NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16445)
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO postgres;

--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 226
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- TOC entry 227 (class 1259 OID 16446)
-- Name: shipments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipments (
    id integer NOT NULL,
    shipment_date date NOT NULL,
    delivery_cost numeric(10,2) NOT NULL,
    delivery_address text NOT NULL,
    shipment_status character varying(50) NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.shipments OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16451)
-- Name: shipments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shipments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipments_id_seq OWNER TO postgres;

--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 228
-- Name: shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shipments_id_seq OWNED BY public.shipments.id;


--
-- TOC entry 234 (class 1259 OID 16540)
-- Name: shopping_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_cart (
    id integer NOT NULL,
    user_id integer,
    product_id integer,
    quantity integer
);


ALTER TABLE public.shopping_cart OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16539)
-- Name: shopping_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_cart_id_seq OWNER TO postgres;

--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 233
-- Name: shopping_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_cart_id_seq OWNED BY public.shopping_cart.id;


--
-- TOC entry 236 (class 1259 OID 16547)
-- Name: user_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.user_types OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16546)
-- Name: user_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_types_id_seq OWNER TO postgres;

--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 235
-- Name: user_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_types_id_seq OWNED BY public.user_types.id;


--
-- TOC entry 3233 (class 2604 OID 16516)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 3226 (class 2604 OID 16453)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 3227 (class 2604 OID 16454)
-- Name: discounts_and_promotions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts_and_promotions ALTER COLUMN id SET DEFAULT nextval('public.discounts_and_promotions_id_seq'::regclass);


--
-- TOC entry 3228 (class 2604 OID 16455)
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 16456)
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- TOC entry 3230 (class 2604 OID 16457)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 3234 (class 2604 OID 16526)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 3231 (class 2604 OID 16459)
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- TOC entry 3232 (class 2604 OID 16460)
-- Name: shipments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments ALTER COLUMN id SET DEFAULT nextval('public.shipments_id_seq'::regclass);


--
-- TOC entry 3237 (class 2604 OID 16543)
-- Name: shopping_cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart ALTER COLUMN id SET DEFAULT nextval('public.shopping_cart_id_seq'::regclass);


--
-- TOC entry 3238 (class 2604 OID 16550)
-- Name: user_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_types ALTER COLUMN id SET DEFAULT nextval('public.user_types_id_seq'::regclass);


--
-- TOC entry 3424 (class 0 OID 16513)
-- Dependencies: 230
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description) FROM stdin;
1	Electronics	Electronic devices and gadgets
2	Clothing	Fashionable clothing and accessories
3	Books	Various books and literary works
4	Home Decor	Decorative items for home
5	Toys	Toys and games for kids
6	Sports & Outdoors	Sports equipment and outdoor gear
\.


--
-- TOC entry 3409 (class 0 OID 16406)
-- Dependencies: 215
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, first_name, last_name, delivery_address, email, phone_number, password_hash, user_type_id) FROM stdin;
5	v	v	Russia	viktor@viktor.ru	1	$2y$10$YRF99hMIEEkZmAUv.mzYHOxtXVwMh46uflGoNsr/EMAmlza4il/Bi	1
6	v	v	vvv	v@v.ru	1	$2y$10$P28j8BpC2QW9nZDeAB413.hqiYnVygWwyo2Ut13uatpPMbTCSHQSK	3
\.


--
-- TOC entry 3411 (class 0 OID 16412)
-- Dependencies: 217
-- Data for Name: discounts_and_promotions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discounts_and_promotions (id, name, description, discount_amount, start_date, end_date) FROM stdin;
\.


--
-- TOC entry 3413 (class 0 OID 16418)
-- Dependencies: 219
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback (id, name, email, message) FROM stdin;
1	Виктор	v@v.ru	Не работает регистрация
2	М	м@yandex.ru	test
3	v	v	1
\.


--
-- TOC entry 3415 (class 0 OID 16424)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_date, order_total, order_status, delivery_method, payment_method, customer_id) FROM stdin;
\.


--
-- TOC entry 3417 (class 0 OID 16428)
-- Dependencies: 223
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, payment_date, payment_amount, payment_status, payment_system, order_id) FROM stdin;
\.


--
-- TOC entry 3426 (class 0 OID 16523)
-- Dependencies: 232
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description, price, category_id, brand, weight, color, material, stock_quantity, is_available, created_at, image_url) FROM stdin;
1	Smartphone X	A powerful smartphone with advanced features.	699.99	1	Brand X	0.30	Black	Metal	100	t	2023-07-31 13:52:19.227934	\N
2	Laptop Y	A high-performance laptop for work and entertainment.	1099.99	1	Brand Y	2.50	Silver	Aluminum	50	t	2023-07-31 13:52:19.227934	\N
3	T-Shirt Z	A comfortable and stylish t-shirt for casual wear.	29.99	2	Brand Z	0.20	Blue	Cotton	200	t	2023-07-31 13:52:19.227934	\N
4	Book A	An intriguing novel that keeps you engaged.	15.99	3	Author A	0.50	N/A	Paper	50	t	2023-07-31 13:52:19.227934	\N
5	Home Decor B	A decorative item to enhance your home interior.	49.99	4	Brand B	1.00	Gold	Ceramic	30	t	2023-07-31 13:52:19.227934	\N
6	Action Figure C	A collectible action figure for kids.	19.99	5	Brand C	0.10	Red	Plastic	100	t	2023-07-31 13:52:19.227934	\N
7	Sports Ball D	A high-quality sports ball for various sports.	24.99	6	Brand D	0.60	Various	Rubber	40	t	2023-07-31 13:52:19.227934	\N
8	Слон	Слон	12.00	\N	\N	\N	\N	\N	\N	t	2023-08-01 10:42:47.653484	https://c.files.bbci.co.uk/137DD/production/_126273897_wed5.jpg
\.


--
-- TOC entry 3419 (class 0 OID 16440)
-- Dependencies: 225
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, rating, review_text, review_date, customer_id, product_id) FROM stdin;
\.


--
-- TOC entry 3421 (class 0 OID 16446)
-- Dependencies: 227
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shipments (id, shipment_date, delivery_cost, delivery_address, shipment_status, order_id) FROM stdin;
\.


--
-- TOC entry 3428 (class 0 OID 16540)
-- Dependencies: 234
-- Data for Name: shopping_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_cart (id, user_id, product_id, quantity) FROM stdin;
1	5	1	1
2	6	8	1
\.


--
-- TOC entry 3430 (class 0 OID 16547)
-- Dependencies: 236
-- Data for Name: user_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_types (id, name, description) FROM stdin;
1	Admin	Administrator with full access
2	Manager	Manager with limited access
3	User	Regular user with basic access
\.


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 229
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 6, true);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 216
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 6, true);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 218
-- Name: discounts_and_promotions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discounts_and_promotions_id_seq', 1, false);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 220
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_id_seq', 3, true);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 222
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 224
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 231
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 8, true);


--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 226
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 228
-- Name: shipments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shipments_id_seq', 1, false);


--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 233
-- Name: shopping_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shopping_cart_id_seq', 2, true);


--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 235
-- Name: user_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_types_id_seq', 3, true);


--
-- TOC entry 3254 (class 2606 OID 16520)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16466)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 16468)
-- Name: discounts_and_promotions discounts_and_promotions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discounts_and_promotions
    ADD CONSTRAINT discounts_and_promotions_pkey PRIMARY KEY (id);


--
-- TOC entry 3244 (class 2606 OID 16470)
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 16472)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 3248 (class 2606 OID 16474)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 16532)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 16478)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 3252 (class 2606 OID 16480)
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (id);


--
-- TOC entry 3258 (class 2606 OID 16545)
-- Name: shopping_cart shopping_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_cart
    ADD CONSTRAINT shopping_cart_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 16554)
-- Name: user_types user_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_types
    ADD CONSTRAINT user_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3261 (class 2606 OID 16555)
-- Name: customers fk_customers_user_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT fk_customers_user_type FOREIGN KEY (user_type_id) REFERENCES public.user_types(id) ON DELETE CASCADE;


--
-- TOC entry 3262 (class 2606 OID 16481)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3263 (class 2606 OID 16486)
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- TOC entry 3266 (class 2606 OID 16533)
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 3264 (class 2606 OID 16496)
-- Name: reviews reviews_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3265 (class 2606 OID 16506)
-- Name: shipments shipments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


-- Completed on 2023-08-01 13:16:40

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-08-01 13:16:40

--
-- PostgreSQL database cluster dump complete
--

