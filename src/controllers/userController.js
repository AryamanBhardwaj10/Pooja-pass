const express = require("express")

const User = require("./../models/userModel")
const CatchAsync = require("./../utils/catchAsync")
const AppError = require("./../utils/appError")

exports.getUsers = CatchAsync(async (req, res, next) => {
  const users = await User.find()
  res.status(200).json({
    status: "success",
    results: users.length,
    data: {
      users,
    },
  })
})

exports.getUser = CatchAsync(async (req, res, next) => {
  const userId = req.user

  const user = await User.findById(userId)
  if (!user) {
    //todo:check status code
    return next(new AppError("User not found", 404))
  }
  res.status(200).json({
    status: "success",
    data: {
      user,
    },
  })
})
