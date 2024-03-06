module.exports = (Sequelize, sequelize) => {
    return sequelize.define('orderItems', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        orderId: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        productId: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        size: {
            type: Sequelize.ENUM,
            values: ['small', 'medium', 'large'],
            allowNull: true
        },
        isVegetarian: {
            type: Sequelize.BOOLEAN,
            allowNull: false,
            defaultValue: false
        },
        toppings: {
            type: Sequelize.ARRAY(Sequelize.STRING),
            allowNull: true,
            defaultValue: null
        },
        quantity: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        price: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
    });
};