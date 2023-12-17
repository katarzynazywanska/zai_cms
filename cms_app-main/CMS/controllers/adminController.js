const { client, pool } = require('../application.js');
const { isEmpty } = require('../config/utils');

module.exports = {
    index: (req, res) => {
        res.render('adminPageView/index');
    },

    getPosts: (req, res) => {
        var query = "SELECT " +
            "wpisy.wpis_id, wpisy.wpis_tytul, wpisy.wpis_status, wpisy.wpis_tresc, wpis_plik," +
            "to_char(wpisy.wpis_data_opublikowania,'DD-MM-YYYY') As wpis_data_opublikowania, " +
            "wpisy.wpis_odblokuj_komentarze, kategorie.kategoria_tytul, " +
            "uzytkownicy.uzytkownik_imie, uzytkownicy.uzytkownik_nazwisko " +
            "FROM wpisy " +
            "INNER JOIN kategorie ON wpisy.wpis_kategoria_id = kategorie.kategoria_id " +
            "INNER JOIN uzytkownicy ON wpisy.wpis_autor_id = uzytkownicy.uzytkownik_id " +
            "ORDER BY ";
        var renderString = 'adminPageView/posts/index';
        var argName = 'posts';
        getObjectFromDb(query, res, renderString, argName);
    },

    submitPosts: (req, res) => {
        /* Insert new Post */
        var fileName = getFileNameifExist(req);

        var query = `INSERT INTO "wpisy" ("wpis_tytul", "wpis_status", "wpis_data_opublikowania", "wpis_odblokuj_komentarze", "wpis_kategoria_id", "wpis_tresc", "wpis_plik", "wpis_autor_id")  
                    VALUES ($1, $2, to_timestamp($3 / 1000.0), $4, $5, $6, $7, $8)`;
        var args = [req.body.title, req.body.status, Date.now(), req.body.allowComments, req.body.category, req.body.articleContent, fileName, req.user.uzytkownik_id];
        if (req.body.allowComments == null) {
            query = `INSERT INTO "wpisy" ("wpis_tytul", "wpis_status", "wpis_data_opublikowania", "wpis_kategoria_id", "wpis_tresc", "wpis_plik", "wpis_autor_id")  
                    VALUES ($1, $2, to_timestamp($3 / 1000.0), $4, $5, $6, $7)`;
            args = [req.body.title, req.body.status, Date.now(), req.body.category, req.body.articleContent, fileName, req.user.uzytkownik_id];
        }
        var redirectString = '/admin/posts';
        var flashMsg = 'Post created successfully';
        actionRequest(query, args, redirectString, flashMsg, req, res);
    },

    createPosts: async(req, res) => {
        /* Get categories */

        var query = "SELECT kategoria_id, kategoria_tytul FROM kategorie";
        var renderString = 'adminPageView/categories/index';
        var argName = 'categories';
        var categories = await getObjectFromDbToVar(query, res, renderString, argName);

        res.render('adminPageView/posts/createPost', { categories: categories });
    },

    editPosts: async(req, res) => {
        const id = req.params.id;

        /* Get categories */
        var query = "SELECT kategoria_id, kategoria_tytul FROM kategorie";
        var renderString = 'adminPageView/categories/index';
        var argName = 'categories';
        var categories = await getObjectFromDbToVar(query, res, renderString, argName);

        /* Get post */
        var query2 = "SELECT " +
            "wpisy.wpis_id, wpisy.wpis_tytul, wpisy.wpis_status," +
            "to_char(wpisy.wpis_data_opublikowania,'DD-MM-YYYY') As wpis_data_opublikowania, " +
            "wpisy.wpis_odblokuj_komentarze, wpisy.wpis_kategoria_id, wpisy.wpis_plik, wpisy.wpis_tresc, kategorie.kategoria_tytul, kategorie.kategoria_id " +
            "FROM wpisy INNER JOIN kategorie ON wpisy.wpis_kategoria_id = kategorie.kategoria_id " +
            "WHERE wpisy.wpis_id =" + id;
        var renderString2 = 'adminPageView/posts/editPost';
        var argName2 = 'post';
        index = 0;
        getObjectFromDb(query2, res, renderString2, argName2, { categories: categories }, index);
    },

    editPostSubmit: (req, res) => {
        const id = req.params.id;

        /* Update post */
        var query = `UPDATE "wpisy"
                    SET "wpis_tytul"=$1, "wpis_status"=$2, "wpis_data_opublikowania"=(to_timestamp($3 / 1000.0)), 
                    "wpis_kategoria_id"=$4,  "wpis_odblokuj_komentarze"=$5, "wpis_tresc"=$6, "wpis_plik"=$7
                    WHERE wpis_id=$8`;

        var fileName = getFileNameifExist(req);
        var args = [req.body.title, req.body.status, Date.now(), req.body.category, req.body.allowComments, req.body.articleContent, fileName, id];
        if (req.body.allowComments == null) {
            query = `UPDATE "wpisy"
                    SET "wpis_tytul"=$1, "wpis_status"=$2, "wpis_data_opublikowania"=(to_timestamp($3 / 1000.0)), "wpis_kategoria_id"=$4, "wpis_tresc"=$5, "wpis_plik"=$6, "wpis_odblokuj_komentarze"=$7
                    WHERE wpis_id=$8`;
            args = [req.body.title, req.body.status, Date.now(), req.body.category, req.body.articleContent, fileName, false, id];
        }
        var redirectString = '/admin/posts';
        var flashMsg = 'Post updated successfully';
        actionRequest(query, args, redirectString, flashMsg, req, res);
    },

    deletePosts: (req, res) => {
        var query =
            "DELETE FROM wpisy WHERE wpis_id = $1";

        var args = [req.params.id];
        var flashMsg = `Post ${req.params.id} deleted successfully`;
        var redirectString = '/admin/posts';
        actionRequest(query, args, redirectString, flashMsg, req, res);
    },

    getCategories: (req, res) => {
        var query = "SELECT kategoria_id, kategoria_tytul FROM kategorie ORDER BY kategoria_id ASC;";
        var renderString = 'adminPageView/categories/index';
        var argName = 'categories';
        getObjectFromDb(query, res, renderString, argName);
    },

    createCategories: (req, res) => {
        /* Insert new Category */
        if (req.body.categoryTitle) {
            var query = `INSERT INTO "kategorie" ("kategoria_tytul") VALUES ($1) RETURNING kategoria_id, kategoria_tytul`;
            var args = [req.body.categoryTitle];
            var redirectString = '/admin/categories';
            var flashMsg = 'Category created successfully';
            actionRequest(query, args, redirectString, flashMsg, req, res, true);
        }
    },

    editCategory: async(req, res) => {
        const id = req.params.id;

        /* Get categories */
        var query = "SELECT kategoria_id, kategoria_tytul FROM kategorie";
        var renderString = 'adminPageView/categories/index';
        var argName = 'categories';
        var categories = await getObjectFromDbToVar(query, res, renderString, argName);

        /* Get category */
        var query2 = "SELECT kategoria_id, kategoria_tytul FROM kategorie WHERE kategoria_id = " + id;
        var renderString2 = 'adminPageView/categories/editCategories';
        var argName2 = 'category';
        index = 0;
        getObjectFromDb(query2, res, renderString2, argName2, { categories: categories }, index);
    },

    editCategorySubmit: (req, res) => {
        /* Update Category */
        if (req.body.categoryTitle) {
            var query = `UPDATE "kategorie" 
                        SET "kategoria_tytul" = ($1) WHERE kategoria_id = $2`;
            var args = [req.body.categoryTitle, req.body.categoryId];
            var redirectString = '/admin/categories';
            var flashMsg = 'Category updated successfully';
            actionRequest(query, args, redirectString, flashMsg, req, res, true);
        }
    },

    deleteCategory: async(req, res) => {
        /* Get categories */

        var query = "SELECT COUNT(kategorie.kategoria_id)" +
            "FROM kategorie " +
            "INNER JOIN wpisy ON kategorie.kategoria_id = wpisy.wpis_kategoria_id " +
            "WHERE kategorie.kategoria_id = " + req.params.id;
        var renderString = 'adminPageView/categories/index';
        var argName = 'categories';
        var howManyPostsAssignedToCategoryObj = await getObjectFromDbToVar(query, res, renderString, argName);

        var countObj = howManyPostsAssignedToCategoryObj[0];
        if (countObj.count != null && countObj.count == 0) {
            /* Delete category */
            var query2 = "DELETE FROM kategorie WHERE kategoria_id=$1";
            var args2 = [req.params.id];
            var flashMsg2 = `Category ${req.params.id} deleted successfully`;
            var redirectString2 = '/admin/categories';
            actionRequest(query2, args2, redirectString2, flashMsg2, req, res);
        } else {
            req.flash('error-message', "This category is assined to " + countObj.count +
                " posts - cannot be deleted!");
            res.redirect('/admin/categories');
        }
    },

    getComments: (req, res) => {
        var query = "SELECT " +
            "komentarze.komentarz_id, komentarze.komentarz_zatwierdzony, " +
            "komentarze.komentarz_tresc, " +
            "to_char(komentarze.komentarz_data,'DD-MM-YYYY') As komentarz_data, " +
            "wpisy.wpis_id, wpisy.wpis_tytul, " +
            "uzytkownicy.uzytkownik_imie, uzytkownicy.uzytkownik_nazwisko " +
            "FROM komentarze " +
            "INNER JOIN wpisy ON komentarze.komentarz_wpis_id = wpisy.wpis_id " +
            "INNER JOIN uzytkownicy ON komentarze.komentarz_autor_id = uzytkownicy.uzytkownik_id " + 
            "ORDER BY komentarze.komentarz_id ASC";
        var renderString = 'adminPageView/comments/index';
        var argName = 'comments';
        getObjectFromDb(query, res, renderString, argName);
    },

    acceptComment: (req, res) => {
        var query = `UPDATE  "komentarze" 
                    SET komentarz_zatwierdzony = true WHERE komentarz_id = $1`;
        var args = [req.params.id];
        var flashMsg = `Comment ${req.params.id} approved successfully`;
        var redirectString = '/admin/comments';
        actionRequest(query, args, redirectString, flashMsg, req, res);
    },

    deleteComment: (req, res) => {
        var query = "DELETE FROM komentarze WHERE komentarz_id=$1";
        var args = [req.params.id];
        var flashMsg = `Comment ${req.params.id} deleted successfully`;
        var redirectString = '/admin/comments';
        actionRequest(query, args, redirectString, flashMsg, req, res);
    },

    getUsers: (req, res) => {
        var query = "SELECT " + 
                "u.uzytkownik_id, " +
                "u.uzytkownik_imie, " + 
                "u.uzytkownik_nazwisko, " + 
                "u.uzytkownik_email, " +
                "COUNT(w.wpis_id) AS post_count " + 
            "FROM " + 
                "uzytkownicy u " +  
            "LEFT JOIN " + 
                "wpisy w ON u.uzytkownik_id = w.wpis_autor_id " + 
            "GROUP BY " +
                "u.uzytkownik_id, u.uzytkownik_imie, u.uzytkownik_nazwisko, u.uzytkownik_email ORDER BY u.uzytkownik_id ASC;" 

        var renderString = 'adminPageView/users/index';
        var argName = 'users';
        getObjectFromDb(query, res, renderString, argName);  
    },

    deleteUser: async(req, res) => {
        /* Get users */

        var query = "SELECT COUNT(uzytkownicy.uzytkownik_id)" +
            "FROM uzytkownicy " +
            "INNER JOIN wpisy ON uzytkownicy.uzytkownik_id = wpisy.wpis_autor_id " +
            "WHERE uzytkownicy.uzytkownik_id = " + req.params.id;
        var renderString = 'adminPageView/users/index';
        var argName = 'users';
        var howManyPostsAssignedToUserObj = await getObjectFromDbToVar(query, res, renderString, argName);

        console.log("params");
        console.log(req.params);

        var countObj = howManyPostsAssignedToUserObj[0];
        if (countObj.count != null && countObj.count == 0) {
            /* Delete user */
            var query2 = "DELETE FROM uzytkownicy WHERE uzytkownik_id=$1";
            var args2 = [req.params.id];
            var flashMsg2 = `User ${req.params.id} deleted successfully`;
            var redirectString2 = '/admin/users';
            actionRequest(query2, args2, redirectString2, flashMsg2, req, res);
        } else {
            req.flash('error-message', "This user is author to " + countObj.count +
                " posts - cannot be deleted!");
            res.redirect('/admin/users');
        }
    },

    getMostActiveUsers: (req, res) => {
        var query = "SELECT " + 
                "u.uzytkownik_id, " +
                "u.uzytkownik_imie, " + 
                "u.uzytkownik_nazwisko, " + 
                "u.uzytkownik_email, " +
                "COUNT(w.wpis_id) AS post_count " + 
            "FROM " + 
                "uzytkownicy u " +  
            "LEFT JOIN " + 
                "wpisy w ON u.uzytkownik_id = w.wpis_autor_id " + 
            "GROUP BY " +
                "u.uzytkownik_id, u.uzytkownik_imie, u.uzytkownik_nazwisko, u.uzytkownik_email ORDER BY post_count DESC LIMIT 100;" 
                
        var renderString = 'adminPageView/users/mostActiveUsers';
        var argName = 'users';
        getObjectFromDb(query, res, renderString, argName);  
    },
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
                        console.log("result : ");
                        console.log({ result });
                        if (flashMsg != '') {
                            req.flash('success-message', flashMsg);
                        }
                        res.redirect(redirectString);
                    }
                    if (status) {
                        if (result.rows[0]) {
                            res.status(200).json(result.rows[0]);
                        } else {
                            res.status(200).json({ url: redirectString });
                        }
                    }
                }
            })
    });
};

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
function getObjectFromDbToVar(query, res, renderString, argName) {
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
                    resolve(result.rows);
                });
        });
    });
}

function getFileNameifExist(req) {
    var fileName = "";
    if (!isEmpty(req.files)) {
        var file = req.files.file;
        fileName = file.name.replace(/\s/g, '');;
        var uploadFolder = './pagesFiles/uploadedFiles/'
        file.mv(uploadFolder + fileName, (error) => {
            if (error) {
                throw error;
            }
        });
        return "/uploadedFiles/" + fileName;
    }
    return fileName;
}