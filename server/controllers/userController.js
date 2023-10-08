const userService = require('../services/userService');

module.exports = {
    getAll: async (req, res, next) => {
        try {
            res.json(await userService.getAll());
        } catch (error) {
            next(error);
        }
    },

    getById: async (req, res, next) => {
        try {
            res.json(await userService.getById(req.params.id));
        } catch (error) {
            next(error);
        }
    },

    register: async (req, res, next) => {
        try {
            const newUser = req.body;
            res.json(await userService.register(newUser));
        } catch (error) {
            next(error);
        }
    },

    login: async (req, res, next) => {
        try {
            const user = req.body;
            res.json(await userService.login(user));
        } catch (error) {
            next(error);
        }
    },

    auth: async (req, res, next) => {
        try {
            const token = req.body;
            res.json(await userService.auth(token));
        } catch (error) {
            next(error);
        }
    },

    updateUserById: async (req, res, next) => {
        try {
            const userData = req.body;
            res.json(await userService.updateUserById(userData));
        } catch (error) {
            next(error);
        }
    },

    deleteUserById: async (req, res, next) => {
        try {
            res.json(await userService.deleteUserById(req.body.id));
        } catch (error) {
            next(error);
        }
    }
};