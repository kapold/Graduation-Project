const express = require('express');
const orderItemController = require('../controllers/order-item-controller');
const errors = require('../helpers/errors');

module.exports = () => {
    let router = express.Router();

    router
        .route('/:orderId')
        .get(orderItemController.getByOrderId)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    return router;
};