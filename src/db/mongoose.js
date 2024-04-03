const mongoose = require("mongoose")

mongoose
  .connect("mongodb://127.0.0.1:27017/temple-ticketing", {})
  .then((db) => {
    console.log("DB connected....")
  })
  .catch((err) => {
    console.log(`Error ${err}`)
  })
