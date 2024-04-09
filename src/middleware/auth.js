const CatchAsync = require("./../utils/catchAsync")
const jwt = require("jsonwebtoken")
const AppError = require("./../utils/appError")
const auth = CatchAsync(async (req, res, next) => {
  const token = req.header("x-auth-token")
  if (!token) {
    return next(new AppError("No auth token, access denied", 401))
  }
  const verified = jwt.verify(token, "secret-key")
  if (!verified) {
    return next(new AppError("Token verification failed", 401))
  }
  req.user = verified.id
  req.token = token
  next()
})

module.exports = auth
