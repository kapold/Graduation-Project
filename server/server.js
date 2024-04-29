const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');

const errors = require("./helpers/errors");
const errorController = require("./controllers/error-сontroller");
const userRoutes = require("./routers/user-router")();
const deliveryAddressRoutes = require("./routers/delivery-address-router")();
const productRoutes = require("./routers/product-router")();
const orderRoutes = require("./routers/order-router")();
const orderItemRoutes = require("./routers/order-item-router")();

let app = express();
app.use(cors());
app.use(bodyParser.json({extended: false}));

app.use(express.static(path.join(__dirname, 'context')));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/context/index.html');
});

app.use('/api/users/', userRoutes);
app.use('/api/delivery-addresses/', deliveryAddressRoutes)
app.use('/api/products/', productRoutes)
app.use('/api/orders/', orderRoutes)
app.use('/api/order-items/', orderItemRoutes)
app.use((req, res, next) => {
    res.error(errors.resourseNotFound);
});
app.use(errorController);

app.listen(3000, () => console.log('Server running at port http://localhost:3000'));
