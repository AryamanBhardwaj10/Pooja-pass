const mongoose = require("mongoose")

const ticketSchema = mongoose.Schema({
  qrCode: {
    type: String,
    trim: true,
    required: [true, "Ticket QR required"],
  },
  ticketDate: {
    type: Date,
    required: true,
  },
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  ticketStatus: {
    type: String,
    required: true,
    default: "booked",
    enum: ["booked", "entered", "exited"],
  },
  memberNames: {
    type: [String],
    validate: {
      validator: (v) => v.length > 0,
      messsage: "Must have atleast one member",
    },
  },
})

const Ticket = mongoose.model("Ticket", ticketSchema)

module.exports = Ticket
