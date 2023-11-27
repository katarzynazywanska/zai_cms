--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-03-13 20:21:46

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
-- TOC entry 3343 (class 0 OID 16522)
-- Dependencies: 215
-- Data for Name: kategorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategorie (kategoria_id, kategoria_tytul) FROM stdin;
23	new category
27	new category 5
28	new 
29	new 1
31	new 1234567890
30	new 90000
24	new category 90909------------
\.


--
-- TOC entry 3347 (class 0 OID 16533)
-- Dependencies: 219
-- Data for Name: uzytkownicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.uzytkownicy (uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo) FROM stdin;
22	Katarzyna	Żywańska	kasia_zywanska@wp.pl	$2a$10$c5IwiSPb.JvEcTqT17cJd.dsIpzWwWIufEkJBRad88B6eI2wf3ZXO
23	Marcin	Putra	marcin.putra@gmail.com	$2a$10$BfoIYArcQzLFd2ASvRX4A.yMNEMQiS.xiu4OavDz4P8x5ZmSPiJRi
24	Jan	Kowalski	jan.kowalski@gmail.com	$2a$10$WJ6hAyxKKbD.3t6U5dBAku60a1zRKNkEbzOICvpvaJcwfYpzAJsiC
25	Scott	Tiger	scott.tiger@gmail.com	$2a$10$7XqOhx964324LLie6d25C.mvDIs3iVV5ZergniDEyV8pohYhACAXu
\.


--
-- TOC entry 3349 (class 0 OID 16537)
-- Dependencies: 221
-- Data for Name: wpisy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wpisy (wpis_id, wpis_tytul, wpis_status, wpis_data_opublikowania, wpis_odblokuj_komentarze, wpis_autor_id, wpis_kategoria_id, wpis_plik, wpis_tresc) FROM stdin;
56	nowy post	public	2023-01-24	f	23	23		przykładowy post\r\n                
58	Post	public	2023-01-24	t	22	23		Post
54	wpis_autor_id	public	2023-01-24	f	22	23		wpis_autor_id\r\n                
42	hgfdsa	draft	2023-01-24	t	22	27		                
57	Lorem ipsum test	public	2023-01-25	t	23	24		Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cursus sit amet dictum sit amet justo donec. Ornare massa eget egestas purus viverra accumsan in nisl nisi. Egestas diam in arcu cursus euismod quis viverra nibh cras. Consectetur lorem donec massa sapien faucibus et. Sed risus pretium quam vulputate dignissim suspendisse in est ante. Amet risus nullam eget felis eget. Donec ultrices tincidunt arcu non sodales neque sodales ut etiam. Arcu odio ut sem nulla pharetra diam sit. Ac tortor vitae purus faucibus. Rhoncus mattis rhoncus urna neque viverra. Tortor id aliquet lectus proin nibh nisl condimentum. Auctor elit sed vulputate mi sit amet mauris commodo. Ac turpis egestas integer eget aliquet nibh. Vel quam elementum pulvinar etiam non quam lacus suspendisse. Non curabitur gravida arcu ac tortor dignissim. Duis tristique sollicitudin nibh sit amet. Amet nisl purus in mollis nunc sed.\r\n\r\nNunc eget lorem dolor sed viverra ipsum. Aliquet nec ullamcorper sit amet. Ac placerat vestibulum lectus mauris ultrices. Egestas diam in arcu cursus euismod quis viverra nibh. Convallis aenean et tortor at risus viverra adipiscing. Elementum facilisis leo vel fringilla est ullamcorper eget. Condimentum lacinia quis vel eros donec ac. Risus pretium quam vulputate dignissim suspendisse in est ante. Ullamcorper eget nulla facilisi etiam dignissim. Euismod elementum nisi quis eleifend quam adipiscing vitae. Massa massa ultricies mi quis hendrerit dolor magna. Donec enim diam vulputate ut pharetra. Ut tristique et egestas quis ipsum suspendisse ultrices. Justo donec enim diam vulputate ut pharetra sit amet aliquam. Porta nibh venenatis cras sed. Placerat orci nulla pellentesque dignissim enim sit amet venenatis. Eros in cursus turpis massa tincidunt dui. Id diam vel quam elementum pulvinar etiam non.\r\n\r\nLibero id faucibus nisl tincidunt eget nullam non. Sit amet est placerat in. Faucibus pulvinar elementum integer enim neque volutpat ac tincidunt. Aliquam ultrices sagittis orci a scelerisque purus. Eget nulla facilisi etiam dignissim diam quis enim lobortis scelerisque. Sit amet consectetur adipiscing elit. Tristique nulla aliquet enim tortor. Nunc sed augue lacus viverra vitae congue eu consequat ac. Non pulvinar neque laoreet suspendisse interdum. Eget nunc lobortis mattis aliquam faucibus purus in. Aliquet lectus proin nibh nisl condimentum. Ornare arcu odio ut sem. Lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare. Condimentum mattis pellentesque id nibh tortor id aliquet lectus proin. Elit pellentesque habitant morbi tristique. Suspendisse ultrices gravida dictum fusce ut placerat orci. Sagittis id consectetur purus ut. Fermentum leo vel orci porta. Massa id neque aliquam vestibulum morbi blandit cursus risus at.\r\n\r\nAt tellus at urna condimentum mattis. Iaculis eu non diam phasellus. A lacus vestibulum sed arcu non odio euismod lacinia. Pulvinar elementum integer enim neque volutpat ac tincidunt vitae semper. Purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae. Auctor augue mauris augue neque gravida in fermentum et. Mattis nunc sed blandit libero volutpat sed cras. In nisl nisi scelerisque eu ultrices vitae. Sit amet mauris commodo quis imperdiet massa tincidunt nunc pulvinar. Fusce ut placerat orci nulla pellentesque. Diam maecenas ultricies mi eget mauris pharetra et ultrices. Aenean pharetra magna ac placerat vestibulum. Faucibus pulvinar elementum integer enim neque volutpat ac. Turpis egestas maecenas pharetra convallis posuere morbi leo urna molestie. Eget aliquet nibh praesent tristique magna sit amet purus gravida. Cursus vitae congue mauris rhoncus aenean vel. Mattis pellentesque id nibh tortor id.\r\n\r\nAuctor eu augue ut lectus arcu bibendum at varius. In hendrerit gravida rutrum quisque non tellus. Id faucibus nisl tincidunt eget. Volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend. Etiam erat velit scelerisque in. Tincidunt vitae semper quis lectus nulla at. Non tellus orci ac auctor augue mauris. Donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu. Neque gravida in fermentum et sollicitudin ac orci. Varius quam quisque id diam vel. Et molestie ac feugiat sed lectus vestibulum mattis. Aliquet sagittis id consectetur purus ut faucibus. Nisi lacus sed viverra tellus in hac habitasse platea.\r\n\r\n                \r\n                \r\n                \r\n                \r\n                \r\n                \r\n                
60	123	public	2023-01-25	f	22	23		cos; INSERT INTO uzytkownicy (uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo) \tVALUES ('Marek', 'Nowak', 'test@query.injection.pl', 'haslomaslo');
43	TEST 	public	2023-01-10	f	\N	28	\N	\N
52	test flush	public	2023-01-12	f	\N	23		test flush
53	12345	public	2023-01-15	f	\N	23		123456789
25	cos	public	2023-01-02	f	22	\N	\N	\N
34	jhgfghjkl	public	2023-01-06	f	22	\N	\N	\N
37	cos cos cos	public	2023-01-06	f	22	\N	\N	\N
\.


--
-- TOC entry 3345 (class 0 OID 16526)
-- Dependencies: 217
-- Data for Name: komentarze; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.komentarze (komentarz_id, komentarz_wpis_id, komentarz_data, komentarz_zatwierdzony, komentarz_autor_id, komentarz_tresc) FROM stdin;
9	57	2023-01-25	t	22	Testowy komentarz
10	57	2023-01-25	f	22	Drugi testowy Komentarz
12	57	2023-01-25	f	22	Czwarty testowy komentarz
\.


--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 216
-- Name: kategorie_kategoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategorie_kategoria_id_seq', 37, true);


--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 218
-- Name: komentarze_komentarz_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.komentarze_komentarz_id_seq', 15, true);


--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 220
-- Name: uzytkownicy_uzytkownik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.uzytkownicy_uzytkownik_id_seq', 25, true);


--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 222
-- Name: wpisy_wpis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wpisy_wpis_id_seq', 62, true);


-- Completed on 2023-03-13 20:21:47

--
-- PostgreSQL database dump complete
--

