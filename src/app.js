const express = require("express")
require("./db/mongoose")

const userRouter = require("./routers/userRouter")

const app = express()

app.use(express.json())

app.use(userRouter)

app.get("/", (req, res) => {
  console.log("Hello from the app.js")
})

module.exports = app
