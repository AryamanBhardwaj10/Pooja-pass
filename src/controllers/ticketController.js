const express = require("express")

const Ticket = require("./../models/ticketModel")
const User = require("./../models/userModel")
const DateWiseInfo = require("./../models/dateWiseInfoModel")
const CatchAsync = require("./../utils/catchAsync")
const AppError = require("./../utils/appError")
const APIFeatures = require("./../utils/apiFeatures")
const { default: mongoose } = require("mongoose")

exports.getAllTickets = CatchAsync(async (req, res, next) => {
  const features = new APIFeatures(Ticket.find(), req.query).filter()

  const tickets = await features.query

  res.status(200).json({
    status: "success",
    result: tickets.length,
    data: {
      tickets,
    },
  })
})

exports.getUserTickets = CatchAsync(async (req, res, next) => {
  const userId = req.params.userId

  const tickets = await Ticket.find({ userId: userId })

  if (!tickets) {
    return next(new AppError("Couldn't fetch the tickets", 500))
  }

  res.status(200).json({
    status: "success",
    result: tickets.length,
    data: {
      tickets,
    },
  })
})

// exports.bookUserTicket = CatchAsync(async (req, res, next) => {
//   const userId = req.params.userId

//   const user = await User.findById(userId)
//   //check if user exists
//   if (!user) {
//     return next(new AppError("User not found", 400))
//   }

//   //extract date and memberList
//   const { ticketDate, memberNames } = { ...req.body }

//   const parsedDate = new Date(ticketDate)

//   //datecrowdinfo

//   //! not sure if find or findOne
//   const dateWiseCrowdData = await DateWiseInfo.findOne({ date: parsedDate })
//   if (!dateWiseCrowdData) {
//     return next(new AppError("No tickets for this date"), 400)
//   }
//   const { maxCap, bookedTickets } = dateWiseCrowdData
//   const availableTickets = maxCap - bookedTickets
//   if (availableTickets < memberNames.length) {
//     return next(new AppError("Insufficient Tickets"), 400)
//   }

//   //create a ticket
//   const ticket = new Ticket({
//     qrCode: req.body.qrCode,
//     ticketDate: parsedDate,
//     userId: userId,
//     ticketStatus: "booked",
//     memberNames: memberNames,
//   })

//   //begin a transaction
//   let session

//   try {
//     session = await mongoose.startSession()
//     session.startTransaction()
//     //save ticket
//     console.log("saving ticket...")
//     const savedTicket = await ticket.save({ session })
//     //update book count
//     console.log("updating date wise info")
//     await DateWiseInfo.findOneAndUpdate(
//       { date: ticketDate },
//       { $inc: { bookedTickets: memberNames.length } },
//       { session }
//     )

//     await session.commitTransaction()

//     //send booking confirmation
//     res.status(201).json({
//       status: "success",
//       message: "Ticket booked successfully",
//       data: {
//         ticket: savedTicket,
//         user: {
//           name: user.name,
//           email: user.email,
//         },
//       },
//     })
//   } catch (e) {
//     await session.abortTransaction()
//     return next(new AppError(`Ticket booking failed ${e.toString()}`, 400))
//   }
// })

//!no transaction added here : R E P L I C A  S E T  R E Q U I R E D !!

exports.bookUserTicket = CatchAsync(async (req, res, next) => {
  const userId = req.params.userId

  const user = await User.findById(userId)
  //check if user exists
  if (!user) {
    return next(new AppError("User not found", 400))
  }

  //extract date and memberList
  const { ticketDate, memberNames } = { ...req.body }

  const parsedDate = new Date(ticketDate)

  // Check user's booking limit for this date
  const existingBookings = await Ticket.find({
    userId: userId,
    ticketDate: parsedDate,
  })
  console.log(existingBookings)

  if (existingBookings.length >= 2) {
    return next(
      new AppError(
        "Booking limit reached. You can only book tickets for this date twice.",
        400
      )
    )
  }

  //datecrowdinfo

  const dateWiseCrowdData = await DateWiseInfo.findOne({ date: parsedDate })
  if (!dateWiseCrowdData) {
    return next(new AppError("No tickets for this date"), 400)
  }
  const { maxCap, bookedTickets } = dateWiseCrowdData
  const availableTickets = maxCap - bookedTickets
  if (availableTickets < memberNames.length) {
    return next(new AppError("Insufficient Tickets"), 400)
  }

  //create a ticket
  const ticket = new Ticket({
    qrCode: req.body.qrCode,
    ticketDate: parsedDate,
    userId: userId,
    ticketStatus: "booked",
    memberNames: memberNames,
  })

  //save ticket
  console.log("saving ticket...")
  const savedTicket = await ticket.save()
  //update book count
  console.log("updating date wise info")
  await DateWiseInfo.findOneAndUpdate(
    { date: ticketDate },
    { $inc: { bookedTickets: memberNames.length } }
  )

  //send booking confirmation
  res.status(201).json({
    status: "success",
    message: "Ticket booked successfully",
    data: {
      ticket: savedTicket,
      user: {
        name: user.name,
        email: user.email,
      },
    },
  })
})

//updating ticket status
exports.updateTicketStatus = CatchAsync(async (req, res, next) => {
  const qrCode = req.params.qrCode
  const ticket = await Ticket.findOne({ qrCode })

  if (!ticket) {
    return next(new AppError("Ticket not found"), 404)
  }
  if (ticket.ticketStatus === "booked") {
    ticket.ticketStatus = "entered"
  } else if (ticket.ticketStatus === "entered") {
    ticket.ticketStatus = "exited"
  } else {
    return next(new AppError("Ticket expired or invalid", 400))
  }
  await ticket.save()

  res.status(200).json({
    status: "success",
    message: "Ticket Status updated",
    data: {
      ticket,
    },
  })
})
