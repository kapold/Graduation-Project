module.exports = (Sequelize, sequelize) => {
    return sequelize.define('orders', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        userId: {
            type: Sequelize.INTEGER,
            foreignKey: true,
            allowNull: false,
        },
        deliverymanId: {
            type: Sequelize.INTEGER,
            foreignKey: true,
            allowNull: true,
        },
        deliveryAddressId: {
            type: Sequelize.INTEGER,
            foreignKey: true,
            allowNull: false,
        },
        status: {
            type: Sequelize.ENUM,
            values: ['processing', 'completed', 'cancelled', 'in delivery', 'deliveried'],
            allowNull: false,
            defaultValue: 'processing',
        },
        paymentType: {
            type: Sequelize.ENUM,
            values: ['in cash', 'by card'],
            allowNull: false,
        },
        totalPrice: {
            type: Sequelize.FLOAT,
            allowNull: false,
        },
        createdAt: {
            type: Sequelize.DATE,
            defaultValue: Sequelize.NOW,
        },
        updatedAt: {
            type: Sequelize.DATE,
            defaultValue: Sequelize.NOW,
        },
    });
};