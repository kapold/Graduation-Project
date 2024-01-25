const express = require('express');
const deliveryAddressController = require('../controllers/delivery-address-сontroller');
const errors = require('../helpers/errors');

module.exports = () => {
    let router = express.Router();

    router
        .route('/')
        .get(deliveryAddressController.getByUserId)
        .post(deliveryAddressController.addAddress)
        .put(deliveryAddressController.updateAddressById)
        .delete(deliveryAddressController.deleteAddressById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route('/:id')
        .get(deliveryAddressController.getById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    return router;
};