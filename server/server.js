const express = require('express');
const favicon = require('serve-favicon')
const path = require('path')
const bodyParser = require('body-parser');

let app = express();
app.use(favicon(path.join(__dirname, 'public', 'favicon.png')));
app.use(bodyParser.json({ extended: false }));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

// app.use('/api/pizzas/', pizzaRoutes);
// app.use('/api/weapons/', weaponRoutes);
// app.use('/api/turtles/', turtleRoutes);

app.listen(3000, () => console.log('Server running at port http://localhost:3000'));
