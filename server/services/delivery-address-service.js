const DeliveryAddress = require('../context').deliveryAddresses;
const errors = require('../helpers/errors');


module.exports = {
    getById: async (addressId) => {
        const deliveryAddress = await DeliveryAddress.findByPk(parseInt(addressId));
        if (!deliveryAddress)
            throw errors.entityNotFound;
        return deliveryAddress;
    },

    updateAddressById: async (addressData) => {
        const deliveryAddress = await DeliveryAddress.findByPk(parseInt(addressData.id));
        if (!deliveryAddress) {
            throw errors.entityNotFound;
        }

        const {userId, address} = addressData;

        if (userId) {
            deliveryAddress.userId = userId;
        }
        if (address) {
            deliveryAddress.address = address;
        }

        await deliveryAddress.save();
        return deliveryAddress;
    },

    deleteAddressById: async (id) => {
        if (!Number.isInteger(id)) {
            throw errors.invalidId;
        }

        const deliveryAddress = await DeliveryAddress.findByPk(id);
        if (!deliveryAddress) {
            throw errors.entityNotFound;
        }

        await deliveryAddress.destroy();
        return deliveryAddress;
    }
};