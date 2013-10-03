module.exports.setup = function(app) {
	
	var ArticleApi = require("./ArticleApi.js");
	var MagazineApi = require("./MagazineApi.js");
	var Generator = require("./../generators")
	var PrintGenerator = require("./../generators/PrintGenerator")
	
	// public Route
	app.get('/publicArticles', ArticleApi.publicArticles);
	
	// API
	app.get('/articles', ArticleApi.getArticles);
	app.post('/articles', ArticleApi.postArticles);
	app.put('/articles/:id', ArticleApi.updateArticle);
	app.delete('/articles/:id', ArticleApi.deleteArticle);
	
	app.get('/magazines', MagazineApi.getMagazines);
	app.post('/magazines', MagazineApi.postMagazines);
	app.put('/magazines/:id', MagazineApi.updateMagazine);
	app.delete('/magazines/:id', MagazineApi.deleteMagazine);
	
	
	// generator
	app.post("/generate", Generator.initialize);
	app.post("/generatePrint", PrintGenerator.generate);
		
		
	app.post("/downloadPrint", PrintGenerator.download);
};

