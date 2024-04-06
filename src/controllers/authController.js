const jwt = require("jsonwebtoken")
const User = require("./../models/userModel")
const CatchAsync = require("./../utils/catchAsync")
const AppError = require("./../utils/appError")
const auth = require("./../middleware/auth")

//*Register

exports.register = CatchAsync(async (req, res, next) => {
  const newUser = await User.create({
    name: req.body.name,
    email: req.body.email,
    password: req.body.password,
  })

  if (!newUser) {
    next(new AppError("Could not create ", 500, res))
  }

  //todo: expires-in option
  const token = jwt.sign({ id: newUser._id }, "secret-key")

  res.status(201).json({
    status: "success",
    token,
    data: {
      user: newUser,
    },
  })
})

//*Login

exports.login = CatchAsync(async (req, res, next) => {
  const { email, password } = req.body

  //check if email and pw is provided
  if (!email || !password) {
    return next(new AppError("Please provide email and password!", 400))
  }

  //check if user exists
  const user = await User.findOne({ email: email }).select("+password")

  if (!user || !(await user.correctPassword(password, user.password))) {
    return next(new AppError("Incorrect email or password"), 401)
  }

  const token = jwt.sign({ id: user._id }, "secret-key")

  res.status(200).json({
    status: "success",
    token,
    data: {
      user: user,
    },
  })
})

//is token valid
exports.isTokenValid = CatchAsync(async (req, res, next) => {
  const token = req.header("x-auth-token")
  if (!token) {
    return res.json(false)
  }
  const verified = jwt.verify(token, "secret-key")
  if (!verified) {
    return res.json(false)
  }
  const user = await User.findById(verified.id)
  if (!user) return res.json(false)
  res.json(true)
})
