const deliveryAddressService = require('../services/delivery-address-service');

module.exports = {
    getById: async (req, res, next) => {
        try {
            res.json(await deliveryAddressService.getById(req.params.id));
        } catch (error) {
            next(error);
        }
    },

    getByUserId: async (req, res, next) => {
        try {
            res.json(await deliveryAddressService.getByUserId(req.body));
        } catch (error) {
            next(error);
        }
    },

    addAddress: async (req, res, next) => {
        try {
            res.json(await deliveryAddressService.addAddress(req.body));
        } catch (error) {
            next(error);
        }
    },

    updateAddressById: async (req, res, next) => {
        try {
            res.json(await deliveryAddressService.updateAddressById(req.body));
        } catch (error) {
            next(error);
        }
    },

    deleteAddressById: async (req, res, next) => {
        try {
            res.json(await deliveryAddressService.deleteAddressById(req.body));
        } catch (error) {
            next(error);
        }
    }
};