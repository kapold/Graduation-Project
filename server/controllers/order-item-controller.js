const orderItemService = require('../services/order-item-service');

module.exports = {
    getByOrderId: async (req, res, next) => {
        try {
            res.json(await orderItemService.getByOrderId(req.params.orderId));
        } catch (error) {
            next(error);
        }
    },
};