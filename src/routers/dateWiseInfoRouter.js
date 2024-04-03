const express = require("express")
const dateWiseInfoController = require("./../controllers/dateWiseInfoController")
const router = express.Router()

//specific date-crowd info
router.get(
  "/dateCrowdInfo/:date",
  dateWiseInfoController.getSpecificDateCrowdInfo
)

//all date crowd info
router.get("/dateCrowdInfo", dateWiseInfoController.getDateCrowdInfo)

//post specific date data
router.post("/dateCrowdInfo", dateWiseInfoController.setSpecificDateCrowdInfo)
