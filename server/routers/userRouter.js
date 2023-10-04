const express = require("express");
const userController = require("../controllers/userController");
const errors = require("../helpers/errors");

module.exports = () => {
    let router = express.Router();

    router
        .route("/")
        .get((req, res, next) => {
            if (Object.keys(req.query).length === 0) {
                userController.getAll(req, res, next);
            } else {
                next();
            }
        })
        .post(userController.createUser)
        .put(userController.updateUserById)
        .delete(userController.deleteUserById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route("/:id")
        .get(userController.getById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    return router;
};