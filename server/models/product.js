module.exports = (Sequelize, sequelize) => {
    return sequelize.define('products', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        name: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
        },
        description: {
            type: Sequelize.TEXT,
            allowNull: true
        },
        price: {
            type: Sequelize.FLOAT,
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
        imageUrl: {
            type: Sequelize.STRING,
            allowNull: true
        },
        isAvailable: {
            type: Sequelize.BOOLEAN,
            allowNull: false,
            defaultValue: true
        },
    });
};
