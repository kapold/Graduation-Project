const OrderItem = require('../context').orderItems;
const errors = require('../helpers/errors');


module.exports = {
    getByOrderId: async (orderId) => {
        try {
            return await OrderItem.findAll({
                where: {orderId: orderId},
            });
        } catch (error) {
            console.log(error)
            throw errors.entityNotFound;
        }
    },
};