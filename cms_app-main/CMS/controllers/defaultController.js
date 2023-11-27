const { client, pool } = require('../application.js');
const bcrypt = require('bcryptjs');

module.exports = {
    index: async(req, res) => {
        /* Get categories */
        var query = "SELECT kategoria_id, kategoria_tytul FROM kategorie";
        var categories = await getObjectFromDbToVar(query);

        var query2 = "SELECT " +
            "wpisy.wpis_id, wpisy.wpis_tytul, wpisy.wpis_status, substr(wpisy.wpis_tresc ,0,200) AS wpis_tresc, wpis_plik," +
            "to_char(wpisy.wpis_data_opublikowania,'DD-MM-YYYY') As wpis_data_opublikowania, " +
            "wpisy.wpis_odblokuj_komentarze, kategorie.kategoria_tytul, " +
            "uzytkownicy.uzytkownik_imie, uzytkownicy.uzytkownik_nazwisko " +
            "FROM wpisy " +
            "INNER JOIN kategorie ON wpisy.wpis_kategoria_id = kategorie.kategoria_id " +
            "INNER JOIN uzytkownicy ON wpisy.wpis_autor_id = uzytkownicy.uzytkownik_id WHERE wpisy.wpis_status = 'public'";
        var renderString2 = 'defaultPageView/index';
        var argName2 = 'posts';
        var index = 0;
        await getObjectFromDb(query2, res, renderString2, argName2, { categories: categories });
        //await getObjectFromDb(query, res, renderString, argName);
        //res.render('defaultPageView/index');
    },

    indexCategoryFilter: async(req, res) => {
        /* Get categories */

        console.log(req.params);
        const categoryId = req.params.id;

        var query = "SELECT kategoria_id, kategoria_tytul FROM kategorie";
        var categories = await getObjectFromDbToVar(query);

        var query2 = "SELECT " +
            "wpisy.wpis_id, wpisy.wpis_tytul, wpisy.wpis_status, substr(wpisy.wpis_tresc ,0,200) AS wpis_tresc, wpis_plik," +
            "to_char(wpisy.wpis_data_opublikowania,'DD-MM-YYYY') As wpis_data_opublikowania, " +
            "wpisy.wpis_odblokuj_komentarze, kategorie.kategoria_tytul, " +
            "uzytkownicy.uzytkownik_imie, uzytkownicy.uzytkownik_nazwisko " +
            "FROM wpisy " +
            "INNER JOIN kategorie ON wpisy.wpis_kategoria_id = kategorie.kategoria_id " +
            "INNER JOIN uzytkownicy ON wpisy.wpis_autor_id = uzytkownicy.uzytkownik_id WHERE wpisy.wpis_status = 'public' " + 
            "AND wpisy.wpis_kategoria_id = '" + categoryId + "'";
        var renderString2 = 'defaultPageView/index';
        var argName2 = 'posts';
        var index = 0;
        await getObjectFromDb(query2, res, renderString2, argName2, { categories: categories });
        //await getObjectFromDb(query, res, renderString, argName);
        //res.render('defaultPageView/index');
    },

    loginGet: (req, res) => {
        res.render('defaultPageView/login');
    },

    logoutGet: (req, res) => {
        res.render('defaultPageView/logout');
    },

    logoutPost: (req, res) => {
        req.logout(function(err) {
            if (err) {
                return next(err);
            }
            req.flash('success-message', 'Logout was successful.')
            res.redirect('/');
        });
    },

    loginPost: (req, res) => {
        res.send("Contgrats, succesfully submit the data");
    },

    registerGet: (req, res) => {
        res.render('defaultPageView/register');
    },

    registerPost: async(req, res) => {
        var errors = validation(req);

        if (errors.length > 0) {
            res.render('defaultPageView/register', {
                errors: errors,
                firstName: firstName,
                lastName: lastName,
                email: email,
            });
        } else {
            var email = req.body.email;
            var query = "SELECT uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo " +
                "FROM uzytkownicy WHERE uzytkownik_email = '" + email + "'";
            var user = await getObjectFromDbToVar(query);

            if (user != null) {
                res.render('defaultPageView/register', { errorMessage: 'Email already used' });

            } else {
                bcrypt.genSalt(10, (err, salt) => {
                    bcrypt.hash(req.body.password, salt, (err, hash) => {
                        var query2 = `INSERT INTO "uzytkownicy" ("uzytkownik_imie", "uzytkownik_nazwisko", "uzytkownik_email", "uzytkownik_haslo") 
                            VALUES ($1, $2, $3, $4)`;
                        var args2 = [req.body.firstName, req.body.lastName, req.body.email, hash];
                        var redirectString2 = '/login';
                        var flashMsg2 = 'You are now registered.';
                        actionRequest(query2, args2, redirectString2, flashMsg2, req, res);
                    })
                });
            }

        }
    },

    singlePost: async(req, res) => {
        const id = req.params.id;
        var query = "SELECT kategoria_id, kategoria_tytul FROM kategorie";
        var categories = await getObjectFromDbToVar(query);

        var query = "SELECT " +
            "wpisy.wpis_id, wpisy.wpis_tytul, wpisy.wpis_status, wpisy.wpis_tresc, wpisy.wpis_plik, " +
            "to_char(wpisy.wpis_data_opublikowania,'DD-MM-YYYY') As wpis_data_opublikowania, " +
            "wpisy.wpis_odblokuj_komentarze, kategorie.kategoria_tytul, " +
            "uzytkownicy.uzytkownik_imie, uzytkownicy.uzytkownik_nazwisko " +
            "FROM wpisy " +
            "INNER JOIN kategorie ON wpisy.wpis_kategoria_id = kategorie.kategoria_id " +
            "INNER JOIN uzytkownicy ON wpisy.wpis_autor_id = uzytkownicy.uzytkownik_id " +
            "WHERE wpisy.wpis_id = " + id;

        var post = await getObjectFromDbToVar(query);

        var query2 = "SELECT " +
            "komentarze.komentarz_id, komentarze.komentarz_zatwierdzony, " +
            "komentarze.komentarz_tresc, " +
            "to_char(komentarze.komentarz_data,'DD-MM-YYYY') As komentarz_data, " +
            "wpisy.wpis_tytul, " +
            "uzytkownicy.uzytkownik_imie, uzytkownicy.uzytkownik_nazwisko " +
            "FROM komentarze " +
            "INNER JOIN wpisy ON komentarze.komentarz_wpis_id = wpisy.wpis_id " +
            "INNER JOIN uzytkownicy ON komentarze.komentarz_autor_id = uzytkownicy.uzytkownik_id " +
            "WHERE wpisy.wpis_id = " + id;
        var comments = await getObjectFromDbToVar(query2);

        if (post == null) {
            res.status(404).json({ message: 'No post found' });
        } else {
            res.render('defaultPageView/singlePost', { post: post[0], comments: comments, categories: categories });
        }
    },

    submitComment: (req, res) => {
        var comment;
        if (req.user) {
            if (req.body.id) {
                var query = `INSERT INTO "komentarze" ("komentarz_wpis_id", "komentarz_data", "komentarz_autor_id", "komentarz_tresc") 
                            VALUES ($1, to_timestamp($2 / 1000.0), $3, $4)`;
                var args = [req.body.id, Date.now(), req.user.uzytkownik_id, req.body.commentContent];
                var redirectString = `/singlepost/${req.body.id}`;
                var flashMsg = 'Comment added successfully, wait for approval.';
                actionRequest(query, args, redirectString, flashMsg, req, res);
            }
        } else {
            req.flash('error-message', 'Login first to comment.');
            res.redirect('/login');
        }


    },

    about: (req, res) => {
        res.render('defaultPageView/about');
    }
}

function getObjectFromDb(query, res, renderString, argName, args, index) {
    var arg = {}
    if (args != undefined || args != null) {
        arg = args;
    }
    pool.connect(function(err, client, done) {
        if (err) {
            return console.error('connexion error', err);
        }

        client.query(query,
            function(err, result) {
                // call `done()` to release the client back to the pool
                done();
                if (err) {
                    return console.error('error running query', err);
                }
                if (index != 0) {
                    arg[argName] = result.rows;
                } else {
                    arg[argName] = result.rows[index];
                }
                res.render(renderString, arg);
            });
    });
}


// The resolve and reject are functions
function getObjectFromDbToVar(query) {
    return new Promise((resolve, reject) => {
        pool.connect(function(err, client, done) {
            if (err) {
                return console.error('connexion error', err);
            }
            client.query(query,
                function(err, result) {
                    // call `done()` to release the client back to the pool
                    done();
                    if (err) {
                        return console.error('error running query', err);
                    }
                    if (result.rowCount > 0) {
                        resolve(result.rows);
                    } else {
                        resolve(null);
                    }
                });
        });
    });
}

function validation(req) {
    var errors = [];
    if (!req.body.firstName) {
        errors.push({ message: 'First name is mandatory' });
    }
    if (!req.body.lastName) {
        errors.push({ message: 'Last name is mandatory' });
    }
    if (!req.body.email) {
        errors.push({ message: 'Email name is mandatory' });
    }
    if (!(req.body.password == req.body.passwordConfirm)) {
        errors.push({ message: 'Passwords do not match' });
    }
    return errors;
}

function actionRequest(query, args, redirectString, flashMsg, req, res, status) {
    pool.connect(function(err, client, done) {
        if (err) {
            return console.error('connexion error', err);
        }
        client.query(query, args,
            function(err, result) {
                // call `done()` to release the client back to the pool
                done();
                if (err) {
                    return console.log('error running query', err);
                }
                if (result) {
                    if (!status) {
                        req.flash('success-message', flashMsg);
                        res.redirect(redirectString);
                    } else {
                        console.log("KOMENTARZ 7");
                        if (result.rows[0]) {
                            res.status(200).json(result.rows[0]);
                        } else {
                            res.status(200).json({ url: redirectString });
                        }
                    }
                }
            });
    });
};