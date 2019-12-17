const express = require("express");
const router = express.Router();
const passport = require("passport");
const dateFormat = require("dateformat");

// Test
router.get("/test", (req, res) => {
  res.json("Match works");
}); 

// Load match schema
const Match = require("../../models/Match");

router.post(
  "/add",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    const newMatch = new Match({
      user: req.user.id,
      date: req.body.date,
      // date=dateFormat(req.body.date,"yyyy-mm-dd"),
      time: req.body.time,
      team: req.body.team,
      name: req.body.name,
      phone: req.body.phone
    });
    Match.findOne({ user: req.user.id })
      .then(student => {
        new Match(newMatch)
          .save()
          .then(stu => res.json(stu))
          .catch(err => res.json(err));
      })
      .catch(err => res.json(err));
  }
);

// Get match by date
router.get(
  "/:date",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Match.find({
      $and: [{ user: req.user.id }, { date: req.params.date }]
    })
      .then(match => {
        if (match.length === 0) {
          res.status(404).json("No match on this date");
        }
        res.json(match);
      })
      .catch(err => res.json(err));
  }
);

// Get slots
router.get(
  "/:date/:time",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Match.find({
      $and: [
        { user: req.user.id },
        { date: req.params.date },
        { time: req.params.time }
      ]
    }).then(slot => {
      if (slot.length === 1) {
        if (slot[0].team === "7s") {
          res.json("No available slot in this time");
        } else if (slot[0].team === "5sA") {
          res.json("5sB");
        } else {
          res.json("5sA");
        }
      } else {
        res.json("No available slot");
      }
    });
  }
);

module.exports = router;
