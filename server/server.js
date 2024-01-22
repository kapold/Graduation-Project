const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');

const errors = require("./helpers/errors");
const errorController = require("./controllers/error-сontroller");
const userRoutes = require("./routers/user-router")();
const deliveryAddressRoutes = require("./routers/delivery-address-router")();
let app = express();
app.use(bodyParser.json({extended: false}));

// Указываем директорию, где хранятся статические файлы
app.use(express.static(path.join(__dirname, 'context')));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/context/index.html');
});

app.use('/api/users/', userRoutes);
app.use('/api/delivery-addresses/', deliveryAddressRoutes)
app.use((req, res, next) => {
    res.error(errors.resourseNotFound);
});
app.use(errorController);

app.listen(3000, () => console.log('Server running at port http://localhost:3000'));
