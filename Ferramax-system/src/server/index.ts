// src/server/index.ts
// set-up dev-node

import express from "express"
import { api } from "./api.js"

const app = express() // declare api
app.use(api) // consume api

app.listen(3002, () => console.log("Server started :D"))