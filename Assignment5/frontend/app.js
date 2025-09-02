const express = require('express');
const path = require('path');
const axios = require('axios');

const app = express();
const PORT = 4000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

app.get("/", (req, res) => {
  res.render("index");
});

const backendUrl = process.env.BACKEND_URL || 'http://localhost:5000/register';

app.post("/register", (req, res) => {
  data = req.body;
  axios.post(backendUrl, data)
    .then(response => {
      res.send(response.data);
    })
    .catch(error => {
      res.status(500).json({ error: 'Failed to send data to backend' });
    });
})

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});