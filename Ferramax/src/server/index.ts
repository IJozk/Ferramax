// src/server/index.ts
// setup dev-node
// tsx watch (...) declared in package.json allows this script to update at real time after saving

import express from "express"
import { api } from "./api.js"

const app = express() // declare api
app.use(api) // consume api

app.listen(3002, () => console.log("Server started :D")) // initiates api