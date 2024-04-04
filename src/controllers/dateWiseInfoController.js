const APIFeatures = require("./../utils/apiFeatures")
const DateWiseInfo = require("./../models/dateWiseInfoModel")
const CatchAsync = require("./../utils/catchAsync")
const AppError = require("./../utils/appError")

exports.getDateCrowdInfo = CatchAsync(async (req, res, next) => {
  const features = new APIFeatures(DateWiseInfo.find(), req.query).filter()

  const dateWiseInfo = await features.query

  res.status(200).json({
    status: "success",
    data: {
      dateWiseInfo,
    },
  })
})

exports.getSpecificDateCrowdInfo = CatchAsync(async (req, res, next) => {
  const date = req.params.date
  if (!date) {
    return next(new AppError("Enter valid date"), 400)
  }

  // const parsedDate = new Date(date)

  const desiredDate = await DateWiseInfo.findOne({ date: date })
  if (!desiredDate) {
    return next(new AppError("Date not found", 400))
  }

  res.status(200).json({
    status: "success",
    data: {
      desiredDate,
    },
  })
})

exports.createDateCrowdInfo = CatchAsync(async (req, res, next) => {
  const newInfo = await DateWiseInfo.create({
    date: req.body.date,
    maxCap: req.body.maxCap,
  })

  res.status(201).json({
    status: "success",
    data: {
      dateInfo: newInfo,
    },
  })
})

exports.setSpecificDateCrowdInfo = CatchAsync(async (req, res, next) => {
  const { date, maxCap } = req.body
  const parsedDate = new Date(date)

  const newDateInfo = await DateWiseInfo.create({
    date: parsedDate,
    maxCap: maxCap,
  })

  res.status(200).json({
    status: "success",
    data: {
      newDateInfo,
    },
  })
})
