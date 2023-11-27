--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-03-13 20:54:09

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
-- TOC entry 6 (class 2615 OID 16521)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16522)
-- Name: kategorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategorie (
    kategoria_id integer NOT NULL,
    kategoria_tytul character varying(30) NOT NULL
);


ALTER TABLE public.kategorie OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16525)
-- Name: kategorie_kategoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategorie_kategoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kategorie_kategoria_id_seq OWNER TO postgres;

--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 216
-- Name: kategorie_kategoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategorie_kategoria_id_seq OWNED BY public.kategorie.kategoria_id;


--
-- TOC entry 217 (class 1259 OID 16526)
-- Name: komentarze; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.komentarze (
    komentarz_id integer NOT NULL,
    komentarz_wpis_id integer,
    komentarz_data date,
    komentarz_zatwierdzony boolean DEFAULT false,
    komentarz_autor_id integer,
    komentarz_tresc character varying(500)
);


ALTER TABLE public.komentarze OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16532)
-- Name: komentarze_komentarz_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.komentarze_komentarz_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.komentarze_komentarz_id_seq OWNER TO postgres;

--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 218
-- Name: komentarze_komentarz_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.komentarze_komentarz_id_seq OWNED BY public.komentarze.komentarz_id;


--
-- TOC entry 219 (class 1259 OID 16533)
-- Name: uzytkownicy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uzytkownicy (
    uzytkownik_id integer NOT NULL,
    uzytkownik_imie character varying(100),
    uzytkownik_nazwisko character varying(100),
    uzytkownik_email character varying(100),
    uzytkownik_haslo character varying(100)
);


ALTER TABLE public.uzytkownicy OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16536)
-- Name: uzytkownicy_uzytkownik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.uzytkownicy_uzytkownik_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uzytkownicy_uzytkownik_id_seq OWNER TO postgres;

--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 220
-- Name: uzytkownicy_uzytkownik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.uzytkownicy_uzytkownik_id_seq OWNED BY public.uzytkownicy.uzytkownik_id;


--
-- TOC entry 221 (class 1259 OID 16537)
-- Name: wpisy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wpisy (
    wpis_id integer NOT NULL,
    wpis_tytul character varying(100) NOT NULL,
    wpis_status character varying(100) NOT NULL,
    wpis_data_opublikowania date NOT NULL,
    wpis_odblokuj_komentarze boolean DEFAULT false,
    wpis_autor_id integer,
    wpis_kategoria_id integer,
    wpis_plik character varying(128),
    wpis_tresc character varying(5000)
);


ALTER TABLE public.wpisy OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16543)
-- Name: wpisy_wpis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wpisy_wpis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wpisy_wpis_id_seq OWNER TO postgres;

--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 222
-- Name: wpisy_wpis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wpisy_wpis_id_seq OWNED BY public.wpisy.wpis_id;


--
-- TOC entry 3189 (class 2604 OID 16544)
-- Name: kategorie kategoria_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategorie ALTER COLUMN kategoria_id SET DEFAULT nextval('public.kategorie_kategoria_id_seq'::regclass);


--
-- TOC entry 3190 (class 2604 OID 16545)
-- Name: komentarze komentarz_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.komentarze ALTER COLUMN komentarz_id SET DEFAULT nextval('public.komentarze_komentarz_id_seq'::regclass);


--
-- TOC entry 3192 (class 2604 OID 16546)
-- Name: uzytkownicy uzytkownik_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uzytkownicy ALTER COLUMN uzytkownik_id SET DEFAULT nextval('public.uzytkownicy_uzytkownik_id_seq'::regclass);


--
-- TOC entry 3193 (class 2604 OID 16547)
-- Name: wpisy wpis_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wpisy ALTER COLUMN wpis_id SET DEFAULT nextval('public.wpisy_wpis_id_seq'::regclass);


--
-- TOC entry 3349 (class 0 OID 16522)
-- Dependencies: 215
-- Data for Name: kategorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategorie (kategoria_id, kategoria_tytul) VALUES (23, 'new category');
INSERT INTO public.kategorie (kategoria_id, kategoria_tytul) VALUES (27, 'new category 5');
INSERT INTO public.kategorie (kategoria_id, kategoria_tytul) VALUES (28, 'new ');
INSERT INTO public.kategorie (kategoria_id, kategoria_tytul) VALUES (29, 'new 1');
INSERT INTO public.kategorie (kategoria_id, kategoria_tytul) VALUES (31, 'new 1234567890');
INSERT INTO public.kategorie (kategoria_id, kategoria_tytul) VALUES (30, 'new 90000');
INSERT INTO public.kategorie (kategoria_id, kategoria_tytul) VALUES (24, 'new category 90909------------');


--
-- TOC entry 3351 (class 0 OID 16526)
-- Dependencies: 217
-- Data for Name: komentarze; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.komentarze (komentarz_id, komentarz_wpis_id, komentarz_data, komentarz_zatwierdzony, komentarz_autor_id, komentarz_tresc) VALUES (9, 57, '2023-01-25', true, 22, 'Testowy komentarz');
INSERT INTO public.komentarze (komentarz_id, komentarz_wpis_id, komentarz_data, komentarz_zatwierdzony, komentarz_autor_id, komentarz_tresc) VALUES (10, 57, '2023-01-25', false, 22, 'Drugi testowy Komentarz');
INSERT INTO public.komentarze (komentarz_id, komentarz_wpis_id, komentarz_data, komentarz_zatwierdzony, komentarz_autor_id, komentarz_tresc) VALUES (12, 57, '2023-01-25', false, 22, 'Czwarty testowy komentarz');


--
-- TOC entry 3353 (class 0 OID 16533)
-- Dependencies: 219
-- Data for Name: uzytkownicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.uzytkownicy (uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo) VALUES (22, 'Katarzyna', 'Żywańska', 'kasia_zywanska@wp.pl', '$2a$10$c5IwiSPb.JvEcTqT17cJd.dsIpzWwWIufEkJBRad88B6eI2wf3ZXO');
INSERT INTO public.uzytkownicy (uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo) VALUES (23, 'Marcin', 'Putra', 'marcin.putra@gmail.com', '$2a$10$BfoIYArcQzLFd2ASvRX4A.yMNEMQiS.xiu4OavDz4P8x5ZmSPiJRi');
INSERT INTO public.uzytkownicy (uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo) VALUES (24, 'Jan', 'Kowalski', 'jan.kowalski@gmail.com', '$2a$10$WJ6hAyxKKbD.3t6U5dBAku60a1zRKNkEbzOICvpvaJcwfYpzAJsiC');
INSERT INTO public.uzytkownicy (uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo) VALUES (25, 'Scott', 'Tiger', 'scott.tiger@gmail.com', '$2a$10$7XqOhx964324LLie6d25C.mvDIs3iVV5ZergniDEyV8pohYhACAXu');


--
-- TOC entry 3355 (class 0 OID 16537)
-- Dependencies: 221
-- Data for Name: wpisy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (56, 'nowy post', 'public', '2023-01-24', false, 23, 23, '', 'przykładowy post
                ');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (58, 'Post', 'public', '2023-01-24', true, 22, 23, '', 'Post');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (54, 'wpis_autor_id', 'public', '2023-01-24', false, 22, 23, '', 'wpis_autor_id
                ');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (42, 'hgfdsa', 'draft', '2023-01-24', true, 22, 27, '', '                ');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (57, 'Lorem ipsum test', 'public', '2023-01-25', true, 23, 24, '', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus sit amet dictum sit amet justo donec. Ornare massa eget egestas purus viverra accumsan in nisl nisi. Egestas diam in arcu cursus euismod quis viverra nibh cras. Consectetur lorem donec massa sapien faucibus et. Sed risus pretium quam vulputate dignissim suspendisse in est ante. Amet risus nullam eget felis eget. Donec ultrices tincidunt arcu non sodales neque sodales ut etiam. Arcu odio ut sem nulla pharetra diam sit. Ac tortor vitae purus faucibus. Rhoncus mattis rhoncus urna neque viverra. Tortor id aliquet lectus proin nibh nisl condimentum. Auctor elit sed vulputate mi sit amet mauris commodo. Ac turpis egestas integer eget aliquet nibh. Vel quam elementum pulvinar etiam non quam lacus suspendisse. Non curabitur gravida arcu ac tortor dignissim. Duis tristique sollicitudin nibh sit amet. Amet nisl purus in mollis nunc sed.

Nunc eget lorem dolor sed viverra ipsum. Aliquet nec ullamcorper sit amet. Ac placerat vestibulum lectus mauris ultrices. Egestas diam in arcu cursus euismod quis viverra nibh. Convallis aenean et tortor at risus viverra adipiscing. Elementum facilisis leo vel fringilla est ullamcorper eget. Condimentum lacinia quis vel eros donec ac. Risus pretium quam vulputate dignissim suspendisse in est ante. Ullamcorper eget nulla facilisi etiam dignissim. Euismod elementum nisi quis eleifend quam adipiscing vitae. Massa massa ultricies mi quis hendrerit dolor magna. Donec enim diam vulputate ut pharetra. Ut tristique et egestas quis ipsum suspendisse ultrices. Justo donec enim diam vulputate ut pharetra sit amet aliquam. Porta nibh venenatis cras sed. Placerat orci nulla pellentesque dignissim enim sit amet venenatis. Eros in cursus turpis massa tincidunt dui. Id diam vel quam elementum pulvinar etiam non.

Libero id faucibus nisl tincidunt eget nullam non. Sit amet est placerat in. Faucibus pulvinar elementum integer enim neque volutpat ac tincidunt. Aliquam ultrices sagittis orci a scelerisque purus. Eget nulla facilisi etiam dignissim diam quis enim lobortis scelerisque. Sit amet consectetur adipiscing elit. Tristique nulla aliquet enim tortor. Nunc sed augue lacus viverra vitae congue eu consequat ac. Non pulvinar neque laoreet suspendisse interdum. Eget nunc lobortis mattis aliquam faucibus purus in. Aliquet lectus proin nibh nisl condimentum. Ornare arcu odio ut sem. Lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare. Condimentum mattis pellentesque id nibh tortor id aliquet lectus proin. Elit pellentesque habitant morbi tristique. Suspendisse ultrices gravida dictum fusce ut placerat orci. Sagittis id consectetur purus ut. Fermentum leo vel orci porta. Massa id neque aliquam vestibulum morbi blandit cursus risus at.

At tellus at urna condimentum mattis. Iaculis eu non diam phasellus. A lacus vestibulum sed arcu non odio euismod lacinia. Pulvinar elementum integer enim neque volutpat ac tincidunt vitae semper. Purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae. Auctor augue mauris augue neque gravida in fermentum et. Mattis nunc sed blandit libero volutpat sed cras. In nisl nisi scelerisque eu ultrices vitae. Sit amet mauris commodo quis imperdiet massa tincidunt nunc pulvinar. Fusce ut placerat orci nulla pellentesque. Diam maecenas ultricies mi eget mauris pharetra et ultrices. Aenean pharetra magna ac placerat vestibulum. Faucibus pulvinar elementum integer enim neque volutpat ac. Turpis egestas maecenas pharetra convallis posuere morbi leo urna molestie. Eget aliquet nibh praesent tristique magna sit amet purus gravida. Cursus vitae congue mauris rhoncus aenean vel. Mattis pellentesque id nibh tortor id.

Auctor eu augue ut lectus arcu bibendum at varius. In hendrerit gravida rutrum quisque non tellus. Id faucibus nisl tincidunt eget. Volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend. Etiam erat velit scelerisque in. Tincidunt vitae semper quis lectus nulla at. Non tellus orci ac auctor augue mauris. Donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Neque gravida in fermentum et sollicitudin ac orci. Varius quam quisque id diam vel. Et molestie ac feugiat sed lectus vestibulum mattis. Aliquet sagittis id consectetur purus ut faucibus. Nisi lacus sed viverra tellus in hac habitasse platea.

                
                
                
                
                
                
                ');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (60, '123', 'public', '2023-01-25', false, 22, 23, '', 'cos; INSERT INTO uzytkownicy (uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo) 	VALUES (''Marek'', ''Nowak'', ''test@query.injection.pl'', ''haslomaslo'');');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (43, 'TEST ', 'public', '2023-01-10', false, NULL, 28, NULL, NULL);
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (52, 'test flush', 'public', '2023-01-12', false, NULL, 23, '', 'test flush');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (53, '12345', 'public', '2023-01-15', false, NULL, 23, '', '123456789');
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (25, 'cos', 'public', '2023-01-02', false, 22, NULL, NULL, NULL);
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (34, 'jhgfghjkl', 'public', '2023-01-06', false, 22, NULL, NULL, NULL);
INSERT INTO public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) VALUES (37, 'cos cos cos', 'public', '2023-01-06', false, 22, NULL, NULL, NULL);


--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 216
-- Name: kategorie_kategoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategorie_kategoria_id_seq', 37, true);


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 218
-- Name: komentarze_komentarz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.komentarze_komentarz_id_seq', 15, true);


--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 220
-- Name: uzytkownicy_uzytkownik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uzytkownicy_uzytkownik_id_seq', 25, true);


--
-- TOC entry 3372 (class 0 OID 0)
-- Dependencies: 222
-- Name: wpisy_wpis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wpisy_wpis_id_seq', 62, true);


--
-- TOC entry 3196 (class 2606 OID 16550)
-- Name: kategorie kategorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategorie
    ADD CONSTRAINT kategorie_pkey PRIMARY KEY (kategoria_id);


--
-- TOC entry 3198 (class 2606 OID 16552)
-- Name: komentarze komentarze_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.komentarze
    ADD CONSTRAINT komentarze_pkey PRIMARY KEY (komentarz_id);


--
-- TOC entry 3200 (class 2606 OID 16554)
-- Name: uzytkownicy uzytkownicy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uzytkownicy
    ADD CONSTRAINT uzytkownicy_pkey PRIMARY KEY (uzytkownik_id);


--
-- TOC entry 3202 (class 2606 OID 16556)
-- Name: wpisy wpisy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wpisy
    ADD CONSTRAINT wpisy_pkey PRIMARY KEY (wpis_id);


--
-- TOC entry 3203 (class 2606 OID 16557)
-- Name: komentarze komentarz_autor_id_uzytkownik_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.komentarze
    ADD CONSTRAINT komentarz_autor_id_uzytkownik_id FOREIGN KEY (komentarz_autor_id) REFERENCES public.uzytkownicy(uzytkownik_id) NOT VALID;


--
-- TOC entry 3204 (class 2606 OID 16578)
-- Name: komentarze komentarz_wpis_id_wpis_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.komentarze
    ADD CONSTRAINT komentarz_wpis_id_wpis_id FOREIGN KEY (komentarz_wpis_id) REFERENCES public.wpisy(wpis_id) ON DELETE CASCADE;


--
-- TOC entry 3205 (class 2606 OID 16567)
-- Name: wpisy wpis_autor_id_uzytkownik_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wpisy
    ADD CONSTRAINT wpis_autor_id_uzytkownik_id FOREIGN KEY (wpis_autor_id) REFERENCES public.uzytkownicy(uzytkownik_id) NOT VALID;


--
-- TOC entry 3206 (class 2606 OID 16572)
-- Name: wpisy wpis_kategoria_id_kategoria_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wpisy
    ADD CONSTRAINT wpis_kategoria_id_kategoria_id FOREIGN KEY (wpis_kategoria_id) REFERENCES public.kategorie(kategoria_id) NOT VALID;


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2023-03-13 20:54:13

--
-- PostgreSQL database dump complete
--

