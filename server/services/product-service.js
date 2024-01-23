const Product = require('../context').products;
const errors = require('../helpers/errors');


module.exports = {
    getAll: async () => {
        return Product.findAll();
    },

    getById: async (userId) => {
        const product = await Product.findByPk(parseInt(userId));
        if (!product)
            throw errors.entityNotFound;
        return product;
    },

    addProduct: async (productData) => {
        const { name, description, price, size, isVegetarian, toppings, imageUrl, isAvailable } = productData;

        if (!name || !price) {
            throw errors.invalidInput('Name and price are required');
        }

        const newProduct = await Product.create({
            name,
            description,
            price,
            size,
            isVegetarian,
            toppings,
            imageUrl,
            isAvailable
        });
        return newProduct;
    },

    updateProductById: async (productData) => {
        const product = await Product.findByPk(parseInt(productData.id));
        if (!product) {
            throw errors.entityNotFound;
        }

        const {name, description, price, size, isVegetarian, toppings, imageUrl, isAvailable} = productData;

        if (name) {
            product.name = name;
        }
        if (description) {
            product.description = description;
        }
        if (price) {
            product.price = price;
        }
        if (size) {
            product.size = size;
        }
        if (isVegetarian) {
            product.isVegetarian = isVegetarian;
        }
        if (toppings) {
            product.toppings = toppings;
        }
        if (imageUrl) {
            product.imageUrl = imageUrl;
        }
        if (isAvailable) {
            product.isAvailable = isAvailable;
        }

        await product.save();
        return product;
    },

    deleteProductById: async (id) => {
        if (!Number.isInteger(id)) {
            throw errors.invalidId;
        }

        const product = await Product.findByPk(id);
        if (!product) {
            throw errors.entityNotFound;
        }

        await product.destroy();
        return product;
    }
};