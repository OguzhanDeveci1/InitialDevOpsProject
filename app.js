const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('<h1> Hello DevOps! Ilk Pipeline Projem Basariyla Calisiyor.</h1>');
});

app.listen(PORT, () => {
    console.log(`Sunucu ${PORT} portunda ayaklandi...`);
});