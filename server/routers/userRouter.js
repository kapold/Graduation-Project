const express = require('express');
const userController = require('../controllers/userController');
const errors = require('../helpers/errors');

module.exports = () => {
    let router = express.Router();

    router
        .route('/login')
        .get(userController.login)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route('/register')
        .post(userController.register)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route('/auth')
        .get(userController.auth)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route('/')
        .get((req, res, next) => {
            if (Object.keys(req.query).length === 0) {
                userController.getAll(req, res, next);
            } else {
                next();
            }
        })
        .put(userController.updateUserById)
        .delete(userController.deleteUserById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route('/:id')
        .get(userController.getById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    return router;
};