const DeliveryAddress = require('../context').deliveryAddresses;
const errors = require('../helpers/errors');


module.exports = {
    getById: async (addressId) => {
        const deliveryAddress = await DeliveryAddress.findByPk(parseInt(addressId));
        if (!deliveryAddress)
            throw errors.entityNotFound;
        return deliveryAddress;
    },

    addAddress: async (addressData) => {
        const { userId, address } = addressData;

        if (!userId || !address) {
            throw errors.invalidInput('userId and address are required');
        }

        const newAddress = await DeliveryAddress.create({
            userId: parseInt(userId),
            address: address,
        });
        return newAddress;
    },

    getByUserId: async (addressData) => {
        const {userId} = addressData;
        const deliveryAddresses = await DeliveryAddress.findAll({
            where: { userId: parseInt(userId) }
        });

        if (!deliveryAddresses || deliveryAddresses.length === 0) {
            throw errors.entityNotFound;
        }
        return deliveryAddresses;
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

    deleteAddressById: async (addressData) => {
        const { addressId } = addressData;
        console.log(`GOVNO: ${addressId}`)
        if (!Number.isInteger(addressId)) {
            throw errors.invalidId;
        }

        const deliveryAddress = await DeliveryAddress.findByPk(parseInt(addressId));
        if (!deliveryAddress) {
            throw errors.entityNotFound;
        }

        await deliveryAddress.destroy();
        return deliveryAddress;
    }
};