const express = require("express")
require("./db/mongoose")

const userRouter = require("./routers/userRouter")
const ticketRouter = require("./routers/ticketRouter")
const dateCrowdRouter = require("./routers/dateWiseInfoRouter")

//session
const session = require("express-session")

const app = express()

app.use(express.json())

app.use(userRouter)
app.use(ticketRouter)
app.use(dateCrowdRouter)

//session
app.use(
  session({
    secret: "YOUR_SECRET_KEY", // Replace with a strong secret key
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }, // Set to true for https
  })
)

app.get("/", (req, res) => {
  console.log("Hello from the app.js")
})

module.exports = app
