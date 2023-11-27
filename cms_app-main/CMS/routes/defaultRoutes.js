const express = require("express");
const defaultController = require("../controllers/defaultController");
const router = express.Router();
const passport = require('passport');
const localStrategy = require('passport-local').Strategy;
const bcrypt = require('bcryptjs');
const { client, pool } = require('../application.js');

router.all('/*', (req, res, next) => {
    req.app.locals.layout = 'default';
    next();
})

router.route('/')
    .get(defaultController.index);

router.route('/category/:id')
    .get(defaultController.indexCategoryFilter);

passport.use(new localStrategy({
    usernameField: 'email',
    passReqToCallback: true
}, async(req, email, password, done) => {
    var query = "SELECT uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo " +
        "FROM uzytkownicy WHERE uzytkownik_email = '" + email + "'";
    var user = await getObjectFromDbToVar(query);
    if (user != null) {
        bcrypt.compare(password, user.uzytkownik_haslo, (err, passwordMatched) => {
            if (err) {
                return err;
            }

            if (!passwordMatched) {
                return done(null, false, req.flash('error-message', 'Invalid Username or Password.'));
            }
            return done(null, user, req.flash('success-message', 'Login successful.'));
        });
    } else {
        return done(null, false, req.flash('error-message', 'User not found with this email.'));
    }
}));

passport.serializeUser(function(user, done) {
    done(null, user.uzytkownik_id);
});

passport.deserializeUser(async function(id, done) {
    var query = "SELECT uzytkownik_id, uzytkownik_imie, uzytkownik_nazwisko, uzytkownik_email, uzytkownik_haslo " +
        "FROM uzytkownicy WHERE uzytkownik_id =" + id;
    var user = await getObjectFromDbToVar(query);
    if (user != null) {
        done(null, user);
    }
})

router.route('/login')
    .get(defaultController.loginGet)
    .post(passport.authenticate('local', {
        successRedirect: '/admin',
        failureRedirect: '/login',
        failureFlash: true,
        successFlash: true,
        session: true
    }), defaultController.loginPost);

router.route('/logout')
    .get(defaultController.logoutGet)
    .post(defaultController.logoutPost);

router.route('/register')
    .get(defaultController.registerGet)
    .post(defaultController.registerPost);

router.route('/singlepost/:id')
    .get(defaultController.singlePost)
    .post(defaultController.submitComment);

router.route('/about')
    .get(defaultController.about);

module.exports = router;

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
                        resolve(result.rows[0]);
                    } else {
                        resolve(null);
                    }
                });
        });
    });
}