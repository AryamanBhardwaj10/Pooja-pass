const express = require("express")
const authController = require("../controllers/authController")
const userController = require("./../controllers/userController")
const auth = require("../middleware/auth")
const router = new express.Router()

//authentication routes
router.post("/register", authController.register)
router.post("/login", authController.login)

router.post("/isTokenValid", auth, authController.isTokenValid)

// --------------------
router.get("/user", auth, userController.getUser)
router.get("/users", userController.getUsers)

module.exports = router
