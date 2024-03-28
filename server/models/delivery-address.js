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
        address: Sequelize.STRING,
    });
}