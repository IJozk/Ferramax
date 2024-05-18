import express from "express";
import { db } from "./db";

const app = express();
app.use(db);
app.get("/db/hi", (req, res) => res.send("Hello"));
app.listen(3002, () => console.log("started :)"));