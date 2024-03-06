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
        const { name, description, price, calories, protein, fats, carbohydrates, weight, imageUrl, isAvailable } = productData;

        if (!name || !price) {
            throw errors.invalidInput('Name and price are required');
        }

        const newProduct = await Product.create({
            name,
            description,
            price,
            calories,
            protein,
            fats,
            carbohydrates,
            weight,
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

        const { name, description, price, calories, protein, fats, carbohydrates, weight, imageUrl, isAvailable } = productData;

        if (name) {
            product.name = name;
        }
        if (description) {
            product.description = description;
        }
        if (price) {
            product.price = price;
        }
        if (calories) {
            product.calories = calories;
        }
        if (protein) {
            product.protein = protein;
        }
        if (fats) {
            product.fats = fats;
        }
        if (carbohydrates) {
            product.carbohydrates = carbohydrates;
        }
        if (weight) {
            product.weight = weight;
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