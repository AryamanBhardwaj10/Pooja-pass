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
