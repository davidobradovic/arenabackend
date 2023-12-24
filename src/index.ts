import express from "express";
import cors from 'cors';
import path from "path";
import bodyParser from "body-parser";

// routes
const carRoutes = require('./routes/carRoutes')
const adminActions = require('./routes/adminActions')
const pageRoutes = require('./routes/pageRoutes')
const authActions = require('./routes/authActions')

const app = express();
app.use(express.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());



app.use('/cars', carRoutes)
app.use('/admin', adminActions)
app.use('/page', pageRoutes)
app.use('/authentication', authActions)

app.use('/uploads', express.static(path.join(__dirname, '../uploads')));
app.use('/komisija-uploads', express.static(path.join(__dirname, '../komuploads')));


app.listen(3030, () => {
    console.log("Server running on port 3030")
})