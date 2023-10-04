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
        name: Sequelize.STRING
    });
}