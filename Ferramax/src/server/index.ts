import express from "express";
import axios from "axios";
import bodyParser from "body-parser";
import { api } from "./api";
import { Remult } from 'remult';
import { TipoEmpleado } from "../shared/tipo_empleado";
import { Empleado } from "../shared/empleado";

const app = express();
const remult = new Remult();

app.use(bodyParser.json()); // Middleware to parse JSON requests
app.use(api);

app.get("/api/hi", (req, res) => res.send("Hello"));

// Endpoint para obtener empleados por categoría
app.get('/api/empleados/:id_categoria', async (req, res) => {
    const id_categoria = parseInt(req.params.id_categoria);
    try {
        const tipoEmpleadoRepo = remult.repo(TipoEmpleado);
        const empleadoRepo = remult.repo(Empleado);

        // Busca los tipos de empleado que pertenecen a la categoría seleccionada
        const tipoEmpleados = await tipoEmpleadoRepo.find({ where: { id_categoria } });
        const tipoEmpleadoIds = tipoEmpleados.map(te => te.id_tipo_empleado);

        // Busca los empleados que tienen uno de los tipos de empleado encontrados
        const empleados = await empleadoRepo.find({ where: { id_tipo_empleado: tipoEmpleadoIds } });

        res.json({ empleados });
    } catch (error) {
        console.error("Error al obtener empleados:", error);
        res.status(500).send("Error al obtener empleados");
    }
});

// Webpay Integration Endpoint
app.post('/api/webpay/create-transaction', async (req, res) => {
    const { amount, returnUrl } = req.body;

    try {
        // Make a request to Webpay API to create a transaction
        const response = await axios.post('https://webpay.api.url', {
            amount,
            returnUrl,
            // Add other necessary parameters and credentials for Webpay API
        });

        // Respond with the redirect URL to complete the payment
        res.json({ redirectUrl: response.data.redirectUrl });
    } catch (error) {
        console.error('Error creating Webpay transaction:', error);
        res.status(500).send('Error creating Webpay transaction');
    }
});

app.listen(3002, () => console.log("Server started on port 3002"));
