const express = require('express');
const productController = require('../controllers/product-controller');
const errors = require('../helpers/errors');

module.exports = () => {
    let router = express.Router();

    router
        .route('/')
        .get(productController.getAll)
        .put(productController.updateProductById)
        .post(productController.addProduct)
        .delete(productController.deleteProductById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    router
        .route('/:id')
        .get(productController.getById)
        .all((req, res, next) => res.error(errors.methodNotAllowed));

    return router;
};