module.exports = (Sequelize, sequelize) => {
    return sequelize.define('deliveryAddresses', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        userId: {
            type: Sequelize.INTEGER,
            foreignKey: true,
            notNull: true,
        },
        city: Sequelize.STRING,
        street: Sequelize.STRING,
        homeNumber: Sequelize.STRING,
        flatNumber: {
            type: Sequelize.STRING,
            allowNull: true,
        },
    });
}