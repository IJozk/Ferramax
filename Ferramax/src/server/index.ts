import express, { Router } from "express";
import { remultExpress } from "remult/remult-express";
import { Usuario } from "../shared/usuario";

import { api } from "./api";
import { Remult } from 'remult';
import { TipoEmpleado } from "../shared/tipo_empleado";
import { Empleado } from "../shared/empleado";
import session from "cookie-session";
import { auth } from "./auth"

const app = express();
const api = remultExpress();

app.use(api);

const auth = Router();
auth.use(express.json());

auth.post("/api/signIn", async (req, res) => {
  const usuarioRepo: Repository<Usuario> = remult.repo(Usuario);
  const user = await usuarioRepo.findFirst({ correo: req.body.username });
  if (user && user.clave === req.body.password) {
    req.session!["user"] = user;
    res.json(user);
  } else {
    res.status(404).json("Usuario inválido, intenta nuevamente");
  }
});

auth.post("/api/signOut", (req, res) => {
  req.session!["user"] = null;
  res.json("Cerraste sesión");
});

auth.get("/api/currentUser", (req, res) => {
  res.json(req.session!["user"]);
});

app.use(auth);

app.listen(3002, () => console.log("started :)"));
