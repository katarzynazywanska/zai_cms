const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');
const { isUserAuthenticated } = require('../config/utils');

router.all('/*', isUserAuthenticated, (req, res, next) => {
    req.app.locals.layout = 'admin';
    next();
})


router.route('/')
    .get(adminController.index);

router.route('/posts')
    .get(adminController.getPosts)
    .post(adminController.submitPosts);

router.route('/posts/create')
    .get(adminController.createPosts)
    .post(adminController.submitPosts);

router.route('/posts/edit/:id')
    .get(adminController.editPosts)
    .put(adminController.editPostSubmit);

router.route('/posts/delete/:id')
    .delete(adminController.deletePosts);


router.route('/categories')
    .get(adminController.getCategories)
    .post(adminController.createCategories);

router.route('/categories/edit/:id')
    .get(adminController.editCategory)
    .post(adminController.editCategorySubmit);

router.route('/categories/delete/:id')
    .delete(adminController.deleteCategory);


router.route('/comments')
    .get(adminController.getComments);

router.route('/comments/accept/:id')
    .put(adminController.acceptComment);

router.route('/comments/delete/:id')
    .delete(adminController.deleteComment);

router.route('/users')
    .get(adminController.getUsers);

router.route('/users/delete/:id')
    .delete(adminController.deleteUser);

router.route('/mostActiveUsers')
    .get(adminController.getMostActiveUsers);

module.exports = router;