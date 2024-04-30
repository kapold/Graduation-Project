const Order = require('../context').orders;
const OrderItem = require('../context').orderItems;
const errors = require('../helpers/errors');
const {sequelize} = require("../context");


module.exports = {
    getAll: async () => {
        console.log(`ORDERS: ${await Order.findAll()}`);
        return Order.findAll();
    },

    getById: async (orderId) => {
        const order = await Order.findByPk(parseInt(orderId));
        if (!order)
            throw errors.entityNotFound;
        return order;
    },

    updateStatus: async (data) => {
        const { orderId, newStatus } = data;

        if (!orderId || !newStatus) {
            throw new Error("Order ID and new status must be provided");
        }

        const order = await Order.findByPk(parseInt(orderId));
        if (!order) {
            throw errors.entityNotFound;
        }

        order.status = newStatus;
        await order.save();

        return order;
    },

    getByUserId: async (userId) => {
        try {
            return await Order.findAll({
                where: {userId: userId},
            });
        } catch (error) {
            console.log(error)
            throw errors.entityNotFound;
        }
    },

    addOrder: async (orderData) => {
        const { userId, deliveryAddressId, paymentType, totalPrice, orderItems } = orderData;
        const t = await sequelize.transaction();

        try {
            const order = await Order.create({
                userId,
                deliveryAddressId,
                paymentType,
                totalPrice,
            }, { transaction: t });

            for (const item of orderItems) {
                await OrderItem.create({
                    ...item,
                    orderId: order.id,
                    id: null,
                }, { transaction: t });
            }

            await t.commit();
            return order;
        } catch (error) {
            await t.rollback();
            throw errors.entityNotCreated;
        }
    },
};