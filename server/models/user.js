module.exports = (Sequelize, sequelize) => {
    return sequelize.define('users', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        phoneNumber: {
            type: Sequelize.STRING,
            unique: true
        },
        password: Sequelize.STRING,
        name: Sequelize.STRING,
        token: Sequelize.STRING,
        role: {
            type: Sequelize.ENUM,
            values: ['customer', 'admin', 'staff', 'deliveryman'],
            allowNull: true,
            defaultValue: 'customer',
        },
        coins: {
            type: Sequelize.INTEGER,
            defaultValue: 0
        }
    });
}