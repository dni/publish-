var ph;
var fs = require('fs');
var scissors = require('scissors');
var path = require('path');
var mime = require('mime');


module.exports.download = function(req, res){
  var file = "./public/magazines/" + req.body.title + "/pdf/Print.pdf";
  res.download(file);
};

module.exports.generate = function(req, res) {

	var pdfMerger = function() {

		var cover = scissors("./public/magazines/" + req.body.title + "/pdf/Book Cover.pdf"), 
			page1 = scissors("./public/magazines/" + req.body.title + "/pdf/Page1.pdf"), 
			page2 = scissors("./public/magazines/" + req.body.title + "/pdf/Page2.pdf"), 
			page3 = scissors("./public/magazines/" + req.body.title + "/pdf/Page3.pdf"), 
			page4 = scissors("./public/magazines/" + req.body.title + "/pdf/Page4.pdf"), 
			page5 = scissors("./public/magazines/" + req.body.title + "/pdf/Page5.pdf"), 
			page6 = scissors("./public/magazines/" + req.body.title + "/pdf/Page6.pdf"), 
			page7 = scissors("./public/magazines/" + req.body.title + "/pdf/Page7.pdf"), 
			page8 = scissors("./public/magazines/" + req.body.title + "/pdf/Page8.pdf"),
			back = scissors("./public/magazines/" + req.body.title + "/pdf/Book Back.pdf");

		var stream = fs.createWriteStream("./public/magazines/" + req.body.title + "/pdf/Print.pdf");
		
		stream.on("end",function(){
			stream.end();
			res.sendFile("./public/magazines/" + req.body.title + "/pdf/Print.pdf");
		});
		
		stream.on("error", function(){
			console.log("stream error");
			stream.end();
		});

		scissors.join(back, cover, page8, page1, page2, page7, page6, page3, page4, page5).pdfStream().pipe(stream);
	};

	fs.readdir("./public/magazines/" + req.body.title + "/hpub/", function(err, data) {
		if (err)
			return;
		data = data.reverse();
		var i = 0, newData = [];
		for (var key = 0; key < data.length; key++) {
			var split = data[key].split(".");
			var string = split.pop();
			if (string === "html") {
				newData[i] = data[key];
				i++;
			}
		}

		var files = newData;
		var renderPages = function(file) {
			if (!file)
				file = files.pop();

			ph.createPage(function(page) {
				console.log("./public/magazines/" + req.body.title + "/hpub/" + file);
				return page.open("./public/magazines/" + req.body.title + "/hpub/" + file, function(status) {
					if (status !== "success") {
						console.log("unable to open page");
						//ph.exit();
					}
					return page.evaluate(function() {
						return document;
					}, function(result) {
						var split = file.split(".");
						page.set('paperSize', {
							format : "A5",
							orientation : 'portrait',
							margin : '0'
						})
						// page.paperSize = { format: "A5", orientation: 'portrait', margin: '1cm' };
						page.render("./public/magazines/" + req.body.title + "/pdf/" + split.shift() + ".pdf");
					});
				});

			});
			setTimeout(function() {
				var nextPage = files.pop();
				if (nextPage) {
					renderPages(nextPage);
				} else {
					setTimeout(function() {
						pdfMerger();
					}, 2000);
				}
				return;
			}, 500);
		};
		renderPages();
	});

};

module.exports.startPhantom = function(phantom) {
	ph = phantom;
}
