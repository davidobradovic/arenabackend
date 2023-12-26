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

const secretKey = 'arenamotorscarsforever123!';

const provjeriAutenticnost = (req: any, res: any, next: any) => {
    const pristigliKljuc = req.headers.authorization;
  
    if (!pristigliKljuc || pristigliKljuc !== `Bearer ${secretKey}`) {
      return res.status(401).json({ error: 'Neautoriziran pristup' });
    }
  
    // Ako je ključ ispravan, nastavi izvođenje
    next();
};

app.use('/cars', provjeriAutenticnost, carRoutes)
app.use('/admin',provjeriAutenticnost, adminActions)
app.use('/page',provjeriAutenticnost, pageRoutes)
app.use('/authentication', authActions)

app.use('/uploads', express.static(path.join(__dirname, '../uploads')));
app.use('/komisija-uploads', express.static(path.join(__dirname, '../komuploads')));


app.listen(3030, () => {
    console.log("Server running on port 3030")
})