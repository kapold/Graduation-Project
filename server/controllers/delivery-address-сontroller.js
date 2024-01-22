const deliveryAddressService = require('../services/delivery-address-service');

module.exports = {
    getById: async (req, res, next) => {
        try {
            res.json(await deliveryAddressService.getById(req.params.id));
        } catch (error) {
            next(error);
        }
    },

    updateAddressById: async (req, res, next) => {
        try {
            const addressData = req.body;
            res.json(await deliveryAddressService.updateAddressById(addressData));
        } catch (error) {
            next(error);
        }
    },

    deleteAddressById: async (req, res, next) => {
        try {
            res.json(await deliveryAddressService.deleteAddressById(req.body.id));
        } catch (error) {
            next(error);
        }
    }
};