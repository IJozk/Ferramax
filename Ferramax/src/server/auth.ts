import express, { Router } from "express"
import type { UserInfo } from "remult"

const validUsers: UserInfo[] = [
    {id: "1", name: "Jane"},
    {id: "2", name: "Steve", roles: ["admin"]},
]

export const auth = Router()

auth.use(express.json())

auth.post("/api/signIn", (req, res) => {
    const user = validUsers.find(user => user.name === req.body.username)
    if (user) {
        req.session!["user"] = user
        res.json(user)
    } else {
        res.status(404).json("Usuario invalido, intenta con 'Steve' o 'Jane'")
    }
})

auth.post("/api/signOut", (req, res) => {
    req.session!["user"] = null
    res.json("Sesión cerrada con éxito")
})

auth.get("/api/currentUser", (req, res) => res.json(req.session!["user"]))