module.exports = (Sequelize, sequelize) => {
    return sequelize.define('users', {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        phoneNumber: {
            type: Sequelize.STRING,
            unique: true,
        },
        password: Sequelize.STRING,
        name: Sequelize.STRING,
        accessKey: {
            type: Sequelize.STRING,
            allowNull: true,
        },
        token: Sequelize.STRING,
        role: {
            type: Sequelize.ENUM,
            values: ['customer', 'admin', 'deliveryman'],
            allowNull: true,
            defaultValue: 'customer',
        },
    });
}