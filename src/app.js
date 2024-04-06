const express = require("express")
require("./db/mongoose")

const userRouter = require("./routers/userRouter")
const ticketRouter = require("./routers/ticketRouter")
const dateCrowdRouter = require("./routers/dateWiseInfoRouter")
const AppError = require("./utils/appError")
const globalErrorHandler = require("./controllers/errorController")

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

app.all("*", (req, res, next) => {
  next(new AppError(`Can't find ${req.url}`, 404))
})

// app.get("/", (req, res) => {
//   console.log("Hello from the app.js")
// })
app.use(globalErrorHandler)

module.exports = app
