const User = require("../context").users;
const errors = require("../helpers/errors");

module.exports = {
    getAll: async () => {
        return User.findAll();
    },

    getById: async (userId) => {
        const user = await User.findByPk(parseInt(userId));
        if (!user)
            throw errors.entityNotFound;
        return user;
    },

    createUser: async (userData) => {
        const {phoneNumber, password, name} = userData;

        if (!name || !password) {
            throw new Error("Name and password are required");
        }


        const user = await User.create({
            phoneNumber,
            password,
            name
        });

        return user;
    },

    updateUserById: async (userData) => {
        const user = await User.findByPk(parseInt(userData.id));
        if (!user) {
            throw new Error("User not found");
        }

        const {phoneNumber, password, name} = userData;

        if (phoneNumber) {
            user.phoneNumber = phoneNumber;
        }
        if (password) {
            user.password = password;
        }
        if (name) {
            user.name = name;
        }

        await user.save();
        return user;
    },

    deleteUserById: async (id) => {
        if (!Number.isInteger(id)) {
            throw new Error("Invalid id");
        }

        const user = await User.findByPk(id);
        if (!user) {
            throw new Error("User not found");
        }

        await user.destroy();
        return user;
    }
};