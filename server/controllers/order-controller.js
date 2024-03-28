const orderService = require('../services/order-service');

module.exports = {
    getAll: async (req, res, next) => {
        try {
            res.json(await orderService.getAll());
        } catch (error) {
            next(error);
        }
    },

    addOrder: async (req, res, next) => {
        try {
            const productData = req.body;
            res.json(await orderService.addOrder(productData));
        } catch (error) {
            next(error);
        }
    },

    getByUserId: async (req, res, next) => {
        try {
            res.json(await orderService.getByUserId(req.params.userId));
        } catch (error) {
            next(error);
        }
    },

    getById: async (req, res, next) => {
        try {
            res.json(await orderService.getById(req.params.id));
        } catch (error) {
            next(error);
        }
    },
};