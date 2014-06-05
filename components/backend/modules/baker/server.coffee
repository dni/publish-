Setting = require("./../settings/model/SettingSchema")
Magazine = require("./../magazine/model/MagazineSchema")
auth = require './../../utilities/auth'
http = require("http")
_ = require("underscore")
ApnToken = require(__dirname + "/model/ApnTokenSchema")
Issue = require(__dirname + "/model/IssueSchema")
PurchasedIssue = require(__dirname + "/model/PurchasedIssueSchema")
Receipt = require(__dirname + "/model/ReceiptSchema")
BakerGenerator = require(__dirname + "/generators/BakerGenerator")

module.exports.setup = (app) ->

  app.get "/downloadApp", BakerGenerator.download

  # BAKER SERVER API
  app.post "/purchase_confirmation", (req, res) ->
    receipt = new Receipt()
    receipt.app_id = req.body.app_id
    receipt.user_id = req.body.user_id
    receipt.purchase_type = req.body.purchase_type
    receipt.base64_receipt = req.body.base64_receipt
    options =
      host: "sandbox.itunes.apple.com"
      port: "80"
      path: "/verifyReceipt"
      method: "POST"

    post = http.request options, (res) ->
      console.log "verify user res: ", res
      console.log "Invalid receipt for $product_id : status " + data.status  if not res.data or (res.data.status isnt 0 and data.status isnt 21006)

    post.write(
      receipt_data: receipt.base64_receipt
      password: "dnilabs"
    ).end()
    console.log "Saving " + receipt.purchase_type + " " + "" + " app:" + receipt.app_id + " user:" + receipt.user_id + " in the receipt database"
    res.end()


  app.post "/post_apns_token", (req, res) ->
    token = new ApnToken()
    token.app_id = req.body.app_id
    token.apns_token = req.body.apns_token
    token.user_id = req.body.user_id
    console.log "/post_apns_token: " + token.apns_token + " app:" + token.app_id + " user:" + token.user_id + " in the database"
    token.save -> res.end()

  app.get "/shelf", (req, res) ->
    Magazine.find(published: 1).execFind (arr, magazines) ->
      json = []
      Setting.findOne(name: "Baker").execFind (arr, bakersetting) ->
        bakersetting = bakersetting[0]
        Setting.findOne(name: "General").execFind (arr, setting) ->
          setting = setting[0]
          _.each magazines, (magazine) ->
            item =
              name: magazine.title
              title: magazine.title
              info: magazine.info
              date: magazine.date
              cover: "http://" + setting.settings.domain.value + "/public/books/" + magazine.title + "/cover.png"
              url: "http://" + setting.settings.domain.value + "/issue/" + magazine.title
              product_id: magazine.product_id

            delete item.product_id if bakersetting.settings.apptype.value isnt "paid"

            json.push item

          res.send JSON.stringify(json)


  # endpoint for downloading hpub file (zip)
  app.get "/issue/:title", (req, res) ->

    magazine = req.params.title or req.body.name

    # only free issues so far
    spawn = require("child_process").spawn
    zip = spawn("zip", ["-r", "-", "hpub"], cwd: "./public/books/" + magazine)
    res.contentType "hpub"
    zip.stdout.on "data", (data) -> res.write data

    zip.on "exit", (code) ->
      if code isnt 0
        res.statusCode = 500
        console.log "zip process exited with code " + code
        res.end()
      else
        console.log "zip done"
        res.end()