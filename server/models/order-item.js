module.exports = (Sequelize, sequelize) => {
    return sequelize.define('orderItems', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        orderId: {
            type: Sequelize.INTEGER,
            allowNull: false,
            references: {
                model: 'orders',
                key: 'id',
            },
            onDelete: 'CASCADE',
        },
        productId: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        size: {
            type: Sequelize.ENUM,
            values: ['small', 'medium', 'large'],
            allowNull: true,
        },
        dough: {
            type: Sequelize.ENUM,
            values: ['traditional', 'thin'],
            allowNull: true,
        },
        toppings: {
            type: Sequelize.ARRAY(Sequelize.STRING),
            allowNull: true,
            defaultValue: null,
        },
        removedCompositions: {
            type: Sequelize.ARRAY(Sequelize.STRING),
            allowNull: true,
            defaultValue: null,
        },
        quantity: {
            type: Sequelize.INTEGER,
            allowNull: false,
        },
        price: {
            type: Sequelize.FLOAT,
            allowNull: false,
        },
    });
};