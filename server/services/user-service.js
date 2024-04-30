const User = require('../context').users;
const errors = require('../helpers/errors');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const statics = require('../helpers/statics');


module.exports = {
    getUserGeo: async (userData) => {
        const { id } = userData;
        if (!id) {
            throw errors.invalidInput('User ID is required');
        }

        const user = await User.findByPk(id);
        if (!user) {
            throw errors.entityNotFound;
        }

        return { latitude: user.latitude, longitude: user.longitude };
    },

    updateUserGeo: async (userData) => {
        const { id, latitude, longitude } = userData;

        if (!id || latitude === undefined || longitude === undefined) {
            throw errors.invalidInput('User ID, latitude and longitude are required');
        }

        const user = await User.findByPk(id);
        if (!user) {
            throw errors.entityNotFound;
        }

        user.latitude = latitude;
        user.longitude = longitude;
        await user.save();

        return user;
    },

    getAll: async () => {
        return User.findAll();
    },

    getAllRoles: async () => {
        return User.rawAttributes.role.type.values;
    },

    getById: async (userId) => {
        const user = await User.findByPk(parseInt(userId));
        if (!user)
            throw errors.entityNotFound;
        return user;
    },

    register: async (userData) => {
        let {phoneNumber, password, name, role} = userData;

        if (!name || !password || !phoneNumber) {
            throw errors.invalidInput('Name, password and phone number are required');
        }

        const existingUser = await User.findOne({where: {phoneNumber}});
        if (existingUser) {
            throw errors.entityAlreadyExists;
        }

        password = await bcrypt.hash(password, 10);

        const user = await User.create({
            phoneNumber,
            password,
            name,
            role
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
            throw errors.invalidInput('Phone number and password are required');
        }

        const user = await User.findOne(
            {
                where: {
                    phoneNumber: phoneNumber
                }
            }
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
            throw errors.entityNotFound;
        }
    },

    auth: async (data) => {
        const {token} = data;

        if (!token) {
            throw errors.invalidInput('Token is empty');
        }

        return jwt.verify(token, statics.jwt_secret);
    },

    authStaff: async (data) => {
        const {accessKey} = data;

        if (!accessKey) {
            throw errors.invalidInput('Access Key is empty');
        }

        const user = await User.findOne(
            {
                where: {
                    accessKey: accessKey
                }
            }
        );

        if (user) {
            return user;
        } else {
            throw errors.entityNotFound;
        }
    },

    updateUserById: async (userData) => {
        const user = await User.findByPk(parseInt(userData.id));
        if (!user) {
            throw errors.entityNotFound;
        }

        const {phoneNumber, password, name, role} = userData;

        if (phoneNumber) {
            user.phoneNumber = phoneNumber;
        }
        if (password) {
            user.password = password;
        }
        if (name) {
            user.name = name;
        }
        if (role) {
            user.role = role;
        }

        await user.save();
        return user;
    },

    deleteUserById: async (id) => {
        if (!Number.isInteger(id)) {
            throw errors.invalidId;
        }

        const user = await User.findByPk(id);
        if (!user) {
            throw errors.entityNotFound;
        }

        await user.destroy();
        return user;
    }
};