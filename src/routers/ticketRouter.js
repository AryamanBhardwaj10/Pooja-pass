const express = require("express")
const ticketController = require("./../controllers/ticketController")

const router = express.Router()

//get tickets of a user
router.get("/tickets/:userId", ticketController.getUserTickets)

//get all tickets
router.get("/tickets", ticketController.getAllTickets)

//book a ticket
router.post("/tickets/:userId", ticketController.bookUserTicket)

//update ticket status
router.patch("/tickets/:qrCode", ticketController.updateTicketStatus)

module.exports = router
