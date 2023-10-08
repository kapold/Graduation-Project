const User = require('../context').users;
const errors = require('../helpers/errors');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const statics = require('../helpers/statics');


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

    register: async (userData) => {
        let {phoneNumber, password, name} = userData;

        if (!name || !password || !phoneNumber) {
            throw new Error('Name, password and phone number are required');
        }

        password = await bcrypt.hash(password, 10);

        const user = await User.create({
            phoneNumber,
            password,
            name
        });

        user.token = jwt.sign(
            {
                user_id: user.id
            },
            statics.jwt_secret,
            {expiresIn: statics.user_expiration_time}
        );
        await user.save();

        return user;
    },

    login: async (userData) => {
        let {phoneNumber, password} = userData;

        if (!phoneNumber || !password) {
            throw new Error('Phone number and password are required');
        }

        const user = await User.findOne(
            {where: {phoneNumber: phoneNumber}}
        );

        if (user && (await bcrypt.compare(password, user.password))) {
            user.token = jwt.sign(
                {
                    user_id: user.id
                },
                statics.jwt_secret,
                {expiresIn: statics.user_expiration_time}
            );
            await user.save();

            return user;
        } else {
            throw new Error('User not found');
        }
    },

    auth: async (data) => {
        const {token} = data;
        if (!token) {
            throw new Error('Token is empty');
        }

        return jwt.verify(token, statics.jwt_secret);
    },

    updateUserById: async (userData) => {
        const user = await User.findByPk(parseInt(userData.id));
        if (!user) {
            throw new Error('User not found');
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
            throw new Error('Invalid id');
        }

        const user = await User.findByPk(id);
        if (!user) {
            throw new Error('User not found');
        }

        await user.destroy();
        return user;
    }
};