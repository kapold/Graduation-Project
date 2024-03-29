const express = require('express');

express.response.error = function (error) {
    if (!error.code) {
        error = {
            message: error.toString(),
            code: 'server_error',
            status: 500,
        };
    }

    this.status(error.status).json(error);
};

module.exports = {
    invalidId: {
        message: 'Already exists',
        code: 'already_exists',
        status: 400
    },
    invalidInput: (message) => {
        return {
            message: message,
            code: 'invalid_input',
            status: 400
        };
    },
    entityNotFound: {
        message: 'Entity Not Found',
        code: 'entity_not_found',
        status: 404
    },
    entityNotCreated: {
        message: 'Entity Not Created',
        code: 'entity_not_created',
        status: 422
    },
    methodNotAllowed: {
        message: 'methodNotAllowed',
        code: 'method_not_allowed',
        status: 405
    },
    entityAlreadyExists: {
        message: 'Entity already exists',
        code: 'entity_already_exists',
        status: 409
    },
};