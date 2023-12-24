import express from 'express';
import { PrismaClient } from '@prisma/client';
import multer from 'multer';
import path from 'path';

const router = express.Router();
const prisma = new PrismaClient();

router.post('/auth', async (req, res) => {
    try {
        const {
            username,
            password,
            security_code
        } = req.body;

        const response = await prisma.administrators.findFirst({
            // eslint-ignore
            where: {
                username: username
            },
          })

        if(!response) {
            return res.status(401).json({ error: 'Wrong data for user' })
        }
        else if(response?.password != password) {
            return res.status(401).json({ error: 'Wrong password' })
        } else if (response?.security_code != security_code) {
            return res.status(401).json({ error: 'Wrong secure code' })
        } else {
            return res.status(200).json(response)
        }

        // Rest of your code...
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, error: 'Internal Server Error' });
    }
});

module.exports = router