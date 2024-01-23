const productService = require('../services/product-service');

module.exports = {
    getAll: async (req, res, next) => {
        try {
            res.json(await productService.getAll());
        } catch (error) {
            next(error);
        }
    },

    addProduct: async (req, res, next) => {
        try {
            const productData = req.body;
            res.json(await productService.addProduct(productData));
        } catch (error) {
            next(error);
        }
    },

    getById: async (req, res, next) => {
        try {
            res.json(await productService.getById(req.params.id));
        } catch (error) {
            next(error);
        }
    },

    updateProductById: async (req, res, next) => {
        try {
            const productData = req.body;
            res.json(await productService.updateProductById(productData));
        } catch (error) {
            next(error);
        }
    },

    deleteProductById: async (req, res, next) => {
        try {
            res.json(await productService.deleteProductById(req.body.id));
        } catch (error) {
            next(error);
        }
    },
};