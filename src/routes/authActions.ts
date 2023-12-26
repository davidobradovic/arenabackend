import express from 'express';
import { PrismaClient } from '@prisma/client';
import multer from 'multer';
import path from 'path';
import jwt from 'jsonwebtoken';

const router = express.Router();
const prisma = new PrismaClient();

const expirationTimeInSeconds = 60 * 60; 

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
            const loggedId = response.id
            const loggedToken = jwt.sign({loggedId}, "ArenaMotors123!", { expiresIn: expirationTimeInSeconds })
            return res.status(200).json({
                Login: true,
                loggedToken,
                userid: response.id,
                response
            })
        }

        // Rest of your code...
    } catch (error) {
        console.error(error);
        res.status(500).json({ success: false, error: 'Internal Server Error' });
    }
});

const verifyJwt = (req: any, res: any, next: any) => {
    const token = req.headers["access-token"];
    if(!token) {
        return res.json("token not founded")
    } else {
        jwt.verify(token, "ArenaMotors123!", (err: any, decoded: any) => {
            if(err) {
                res.json("Not Authenticated")
            } else {
                req.userId = decoded.id
                next();
            }
        })
    }
}

router.get('/checkauth', verifyJwt , (req: any, res: any) => {
    return res.json(true)
})

router.post('/logout', async (req: any, res: any) => {
    try {
      const { elapsedTime, userId } = req.body;
  
  
      // Update the user's record in the database with the elapsed time
      await prisma.administrators.update({
        where: { id: Number(userId) },
        data: { worktime: { increment: elapsedTime } }, // Assuming you have a field named totalSessionTime
      });
  
      res.status(200).json({ success: true });
    } catch (error) {
      console.error(error);
      res.status(500).json({ success: false, error: 'Internal Server Error' });
    }
  });
  

module.exports = router