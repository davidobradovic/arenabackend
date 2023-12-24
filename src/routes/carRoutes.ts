import express from 'express';
import { PrismaClient } from '@prisma/client';

const router = express.Router();
const prisma = new PrismaClient();

router.get('/all-vehicles', async (req, res) => {
  const data = await prisma.cars.findMany({ include: { images: true, specifications: true } });

  if (!data) {
    res.json({ error: 'Greska pri pribavljanju podataka' })
  }

  res.json(data)
})

router.get('/all-brands', async (req, res) => {
  const data = await prisma.carBrands.findMany({
    include: { models: true }
  });

  if (!data) {
    res.json({ error: 'Greska pri pribavljanju podataka' })
  }

  res.json(data)
})

router.get('/all-models/:brand_id', async (req, res) => {
  const { brand_id } = req.params;

  const data = await prisma.carModels.findMany({
    where: { brand_id: Number(brand_id) }
  });

  if (!data) {
    res.json({ error: 'Greska pri pribavljanju podataka' })
  }

  res.json(data)
})

router.get('/:car_id', async (req, res) => {
  try {
    const { car_id } = req.params;

    const data = await prisma.cars.findUnique({
      where: { id: Number(car_id) },
      include: { images: true, specifications: true },
    });

    if (!data) {
      return res.status(404).json({ message: 'Nema podataka' });
    }

    return res.json(data);
  } catch (error) {
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error', details: error });
  }
});

router.put('/car-view/:car_id', async (req, res) => {
  const { car_id } = req.params;

  try {
    const updatedCar = await prisma.cars.update({
      where: {
        id: Number(car_id),
      },
      data: {
        views: {
          increment: 1,
        },
      },
    });

    res.json(updatedCar);
  } catch (error) {
    console.error('Error updating car views:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

router.put('/car-view/:car_id', async (req, res) => {
  try {
    const { car_id } = req.params;
    // Fetch the current value of the counter
    const existingRecord = await prisma.cars.findFirst({
      where: {
        id: Number(car_id)
      }
    });
    const currentView = existingRecord?.views || 0;

    // Increment the counter by 1
    const updatedRecord = await prisma.cars.update({
      where: {
        id: Number(car_id)
      },
      data: {
        views: currentView + 1,
      },
    });

    res.json({ newCounterValue: updatedRecord.views });
  } catch (error) {
    console.error('Error updating counter:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
})

router.post('/car-question/:car_id', async (req, res) => {
  try {
    const { car_id } = req.params;
    const {
      fullName,
      phone,
      email,
      message
    } = req.body

    const data = await prisma.contacsForCars.create({
      data: {
        car_id: Number(car_id),
        fullName,
        phone,
        email,
        message
      }
    })

    if (!data) {
      return res.status(500).json({ error: 'Error creating car data' });
    }

    // Respond with the created data
    return res.status(200).json(data);

  } catch (error) {
    // Handle unexpected errors
    console.error('Error:', error);
    return res.status(500).json({ error: 'Internal server error', details: error });
  }
})

module.exports = router