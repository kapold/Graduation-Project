const express = require('express');
const orderController = require('../controllers/order-controller');
const errors = require('../helpers/errors');

module.exports = () => {
    let router = express.Router();

    router
        .route('/')
        .get(orderController.getAll)
        .post(orderController.addOrder)
        .put(orderController.updateStatus)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route('/:userId')
        .get(orderController.getByUserId)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    return router;
};