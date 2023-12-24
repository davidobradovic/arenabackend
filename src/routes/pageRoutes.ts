import express from 'express';
import { PrismaClient } from '@prisma/client';
import multer from 'multer';
import path from 'path';

const router = express.Router();
const prisma = new PrismaClient();

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "komuploads");
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

// router.put('/page-views', async (req, res) => {
//   try {
//     const updatedCar = await prisma.webViews.update({
//       where: {
//         id: 1,
//       },
//       data: {
//         view: {
//           increment: 1,
//         },
//       },
//     });

//     res.json(updatedCar);
//   } catch (error) {
//     console.error('Error updating car views:', error);
//     res.status(500).json({ error: 'Internal Server Error' });
//   }
// });

router.put('/page-views', async (req, res) => {
  try {
    // Fetch the current value of the counter
    const existingRecord = await prisma.webViews.findFirst();
    const currentView = existingRecord?.view || 0;

    // Increment the counter by 1
    const updatedRecord = await prisma.webViews.update({
      where: {
        id: 1
      },
      data: {
        view: currentView + 1,
      },
    });

    res.json({ newCounterValue: updatedRecord.view });
  } catch (error) {
    console.error('Error updating counter:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

router.post('/post-komisiona-prodaja', upload.array('images'), async (req, res, next) => {
  try {
      const {
        customer_name,
        customer_phone,
        customer_email,
        car_name,
        car_price,
        car_desc
      } = req.body;

      const uploadedFiles = ((req.files as Express.Multer.File[]) || []).map((file: Express.Multer.File) => ({
          url: `http://localhost:3030/komisija-uploads/${file.filename}`,
          name: file.originalname
      }));

      // Create a new car with nested data
    const data = await prisma.komisionaProdaja.create({
      data: {
        customer_name,
        customer_phone,
        customer_email,
        car_name,
        car_price: Number(car_price),
        car_desc,
        images: {
          create: uploadedFiles || []
        }
      },
    });

      if (!data) {
          return res.status(500).json({ error: 'Error creating car data' });
      }

      // Respond with the created data
      return res.json(data);
  } catch (error) {
      // Handle unexpected errors
      console.error('Error:', error);
      return res.status(500).json({ error: 'Internal server error', details: error });
  }
});

router.get('/arena-views', async (req, res) => {
  try {
    const response = await prisma.webViews.findMany();

    if(!response) {
      return res.status(500).json({ error: 'Greska' })
    }

    return res.json(response)
  } catch (error) {
    console.error('Error updating car views:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
})

module.exports = router