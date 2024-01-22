module.exports = (Sequelize, sequelize) => {
    return sequelize.define('orders', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        userId: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        status: {
            type: Sequelize.ENUM,
            values: ['processing', 'completed', 'cancelled', 'in delivery', 'deliveried'],
            allowNull: false,
            defaultValue: 'processing'
        },
        totalPrice: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
    });
};