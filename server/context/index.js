const Sequelize = require('sequelize');
const config = require('../config.json');

const sequelize = new Sequelize(
    config.db.name,
    config.db.user,
    config.db.password,
    config.db.options
);

const Users = require('../models/user')(Sequelize, sequelize);
const DeliveryAddresses = require('../models/delivery-address')(Sequelize, sequelize);
const Products = require('../models/product')(Sequelize, sequelize);
const Orders = require('../models/order')(Sequelize, sequelize);
const OrderItems = require('../models/order-item')(Sequelize, sequelize);

DeliveryAddresses.belongsTo(Users, {foreignKey: 'userId'})
Orders.hasMany(OrderItems, {as: 'items'});
Orders.belongsTo(Users, {as: 'user'});
OrderItems.belongsTo(Orders, {as: 'order', foreignKey: 'orderId'});
OrderItems.belongsTo(Products, {as: 'product'});

sequelize
    .sync({alter: true})
    .then(() => console.log('Database synced successfully'))
    .catch((err) => console.error('Error syncing database:', err));

module.exports = {
    users: Users,
    deliveryAddresses: DeliveryAddresses,
    products: Products,
    orders: Orders,
    orderItems: OrderItems,
    sequelize,
    Sequelize,
};

