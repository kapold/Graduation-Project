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
        calories: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        protein: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        fats: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        carbohydrates: {
            type: Sequelize.FLOAT,
            allowNull: false
        },
        weight: {
            type: Sequelize.INTEGER,
            allowNull: false
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
