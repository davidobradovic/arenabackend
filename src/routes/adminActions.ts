import express, { Request, Response, NextFunction } from 'express';
import { PrismaClient } from '@prisma/client';
import multer from 'multer';
import path from 'path';
import { v4 as uuidv4 } from 'uuid';


const router = express.Router();
const prisma = new PrismaClient();

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "uploads");
    },
    filename: (req, file, cb) => {
        cb(null, uuidv4() + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });

router.post('/post-vehicle', upload.array('images'), async (req, res, next) => {
    try {
        const {
            brand_id,
            model_id,
            title,
            price,
            mileage,
            year,
            type,
            fuel,
            transmission,
            drive,
            carColor,
            doors,
            engine,
            power,
            horsePowers,
            weight,
            climate,
            sound,
            parkingSenzori,
            parkingCamera,
            interior,
            roloZavjese,
            lights,
            seats,
            transmissionLength,
            wheels,
            numberOfOwners,
            emmisionStandad,
            yearOfFirstRegistration,
            registeredTo,
            warranty,
            car_status,
            advertisement_status,
            description,
            specifications
        } = req.body;

        // Check if the specified brand and model exist
        const brandExists = await prisma.carBrands.findUnique({ where: { id: Number(brand_id) } });
        const modelExists = await prisma.carModels.findUnique({ where: { id: Number(model_id) } });

        if (!brandExists || !modelExists) {
            return res.status(404).json({ error: 'Specified brand or model not found' });
        }

        const uploadedFiles = ((req.files as Express.Multer.File[]) || []).map((file: Express.Multer.File) => ({
            url: file.filename,
            name: file.originalname
        }));

        const selectedSpec = specifications.map((spec: string) => ({
            value: spec
        }));

        // Create a new car with nested data
        const data = await prisma.cars.create({
            data: {
                brand: { connect: { id: Number(brand_id) } },
                model: { connect: { id: Number(model_id) } },
                title,
                price: Number(price),
                mileage: Number(mileage),
                year: Number(year),
                type,
                fuel,
                transmission,
                drive,
                carColor,
                doors,
                engine,
                power: Number(power),
                horsePowers: Number(horsePowers),
                weight: Number(weight),
                climate: climate || '',
                sound: sound || '',
                parkingSenzori: parkingSenzori || '',
                parkingCamera: parkingCamera || '',
                interior: interior  || '',
                roloZavjese: roloZavjese|| '',
                lights: lights || '',
                seats: Number(seats),
                transmissionLength: transmissionLength || '',
                wheels: wheels || '',
                numberOfOwners: Number(numberOfOwners),
                emmisionStandad: emmisionStandad || '',
                yearOfFirstRegistration: Number(yearOfFirstRegistration),
                registeredTo: Number(registeredTo),
                warranty: Number(warranty),
                car_status,
                advertisement_status,
                description,
                images: {
                    create: uploadedFiles || []
                },
                specifications: {
                    create: specifications.length > 3 ? selectedSpec : []
                },
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

router.get('/radnici', async (req, res) => {
    try {
        const data = await prisma.administrators.findMany({
        })

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
})

router.delete('/delete-car/:carID', async (req, res) => {
    try {
        const { carID } = req.params;

        // Attempt to delete the car and its associated images and specifications
        const existingCar = await prisma.cars.findUnique({
            where: {
                id: Number(carID),
            }
        });

        if(existingCar) {
            const response = await prisma.images.deleteMany({
                where: {
                    car_id: Number(carID)
                }
            })
            await prisma.specifications.deleteMany({
                where: {
                    car_id: Number(carID)
                }
            })

            if(response) {
                const finRes =await prisma.cars.delete({
                    where: {
                        id: Number(carID)
                    }
                })

                res.json(finRes)
            }

        } else {
            res.json({ error: 'Greska pri brisanju vozila' })
        }

    } catch (error: any) {
        return res.status(400).json({ error: 'GRESKA' })
    }
});

router.put('/update-car-status/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { advertisement_status } = req.body

        const data = await prisma.cars.update({
            where: { id: Number(id) },
            data: {
                advertisement_status
            }
        })

        if (!data) {
            return res.status(500).json({ error: 'Error creating car data' });
        }

        return res.json(data);
    } catch (error) {
        // Handle unexpected errors
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal server error', details: error });
    }
})

router.get('/cars-questions', async (req, res) => {
    try {
        const data = await prisma.contacsForCars.findMany({
            include: { car: true, }
        })

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
})

router.get('/komisione-prodaje', async (req, res) => {
    try {
        const data = await prisma.komisionaProdaja.findMany({
            include: { images: true }
        })

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
})

router.post('/postavi-reklamu', async (req, res, next) => {
    try {
        const {
            backgroundImage,
            title,
            description,
            action,
            adLink,
            exipration
        } = req.body;

        // Create a new car with nested data
        const response = await prisma.advertisements.updateMany({
            data: {
                active: false
            }
        })

        if(response) {
            const data = await prisma.advertisements.create({
                data: {
                    backgroundImage,
                    title,
                    description,
                    action,
                    adLink,
                    exipration,
                    active: true
                },
            });

            if (!data) {
                return res.status(500).json({ error: 'Error creating car data' });
            }
    
            // Respond with the created data
            return res.json(data);
        }

    } catch (error) {
        // Handle unexpected errors
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal server error', details: error });
    }
});

router.get('/all-advertisements', async (req, res) => {
    try {
        const response = await prisma.advertisements.findMany();

        if (!response) {
            return res.status(500).json({ error: 'Error creating car data' });
        }

        // Respond with the created data
        return res.json(response);
    } catch (error) {
        // Handle unexpected errors
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal server error', details: error });
    }
})

router.post('/api/brands', async (req, res) => {
    try {
        const { title, logo } = req.body;

        // Create models in the database

        const data = await prisma.carBrands.create({
            data: {
                title,
                logo: logo || ''
            }
        })

        if(!data) {
            return res.status(200).json({ error: 'Greska pri postavljanju marke' })
        }

        res.json({ success: true, models: data });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, error: 'Internal Server Error' });
    }
});

router.post('/api/models', async (req, res) => {
    try {
        const { brand_id, models } = req.body;

        // Create models in the database
        const createdModels = [];
        for (const model of models) {
            const createdModel = await prisma.carModels.create({
                data: {
                    title: model.title,
                    brand: { connect: { id: parseInt(brand_id) } },
                },
            });
            createdModels.push(createdModel);
        }

        res.json({ success: true, models: createdModels });
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, error: 'Internal Server Error' });
    }
});

router.put('/api/ad-status/:adID', async (req, res) => {
    try {
        const { adID } = req.params;

        const response = await prisma.advertisements.update({
            where: {
                id: Number(adID)
            },
            data: {
                active: false
            }
        })


        if (!response) {
            return res.status(500).json({ error: 'Error creating car data' });
        }

        // Respond with the created data
        return res.json(response);
    } catch (error) {
        // Handle unexpected errors
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal server error', details: error });
    }
});

router.put('/api/ad-true-status/:adID', async (req, res) => {
    try {
        const { adID } = req.params;

        const response = await prisma.advertisements.update({
            where: {
                id: Number(adID)
            },
            data: {
                active: true
            }
        })


        if (!response) {
            return res.status(500).json({ error: 'Error creating car data' });
        }

        // Respond with the created data
        return res.json(response);
    } catch (error) {
        // Handle unexpected errors
        console.error('Error:', error);
        return res.status(500).json({ error: 'Internal server error', details: error });
    }
});

module.exports = router;
