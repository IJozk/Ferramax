// src/server/index.ts
// setup dev-node
// tsx watch (...) declared in package.json allows this script to update at real time after saving

import express from "express"
import { api } from "./api"
import session from "cookie-session"
import { auth } from "./auth"

const app = express() // declare api
app.use(
    session({
        secret: process.env["SESSION_SECRET"] || "my secret"
    })
) 

app.use(auth)
app.use(api)

app.listen(3002, () => console.log("Server started :D")) // initiates api