const mongoose = require("mongoose")

const dateWiseInfoSchema = new mongoose.Schema({
  date: {
    type: Date,
    unique: true,
    required: [true, "Date is required"],
  },
  maxCap: {
    type: Number,
    required: [true, "Maximum capacity is required"],
  },
  bookedTickets: {
    type: Number,
    default: 0,
  },
})

const DateWiseInfoModel = mongoose.model("DateWiseInfo", dateWiseInfoSchema)

module.exports = DateWiseInfoModel
