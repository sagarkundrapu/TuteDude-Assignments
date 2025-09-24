const express = require('express');
const axios = require('axios');
require('dotenv').config();

BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:5000';

const app = express();
const PORT = 3000;

app.set('view engine', 'ejs');

app.get('/', (req, res) => {
    axios.get(`${BACKEND_URL}/api`)
        .then(response => {
            res.render('index', { data: response.data });
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });
});


app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});