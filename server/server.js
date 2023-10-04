const express = require('express');
const bodyParser = require('body-parser');

const errors = require("./helpers/errors");
const errorController = require("./controllers/errorController");
const userRoutes = require("./routers/userRouter")();
let app = express();
app.use(bodyParser.json({ extended: false }));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

app.use('/api/users/', userRoutes);
app.use((req, res, next) => {
    res.error(errors.resourseNotFound);
});
app.use(errorController);

app.listen(3000, () => console.log('Server running at port http://localhost:3000'));
