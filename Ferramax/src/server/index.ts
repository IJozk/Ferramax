import express from "express";
import axios from "axios";
import bodyParser from "body-parser";
import { api } from "./api";
import { Remult } from 'remult';
import { TipoEmpleado } from "../shared/tipo_empleado";
import { Empleado } from "../shared/empleado";
const mercadopago = require('mercadopago');

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

// Middleware
app.use(bodyParser.json());

// Configura las credenciales de Mercado Pago
mercadopago.configure({
  access_token: 'TEST-2009681591890148-070207-4afd66d446cc2506de0108d4abb7b86b-305841050'
});

// Endpoint para crear la preferencia de pago
app.post('/api/pago', async (req, res) => {
  try {
    const { transaction_amount, description, payment_method_id, payer } = req.body;

    const preference = {
      items: [
        {
          title: description,
          unit_price: transaction_amount,
          quantity: 1,
        }
      ],
      payer: {
        email: payer.email,
      },
      payment_methods: {
        excluded_payment_types: [
          {
            id: "ticket"
          }
        ],
        installments: 1,
      },
      back_urls: {
        success: "http://localhost:8080/success",
        failure: "http://localhost:8080/failure",
        pending: "http://localhost:8080/pending"
      },
      auto_return: "approved",
    };

    const response = await mercadopago.preferences.create(preference);
    res.json({ preference_id: response.body.id });
  } catch (error) {
    console.error('Error al crear la preferencia:', error);
    res.status(500).json({ message: error.message });
  }
});

app.listen(3002, () => console.log("Server started on port 3002"));
