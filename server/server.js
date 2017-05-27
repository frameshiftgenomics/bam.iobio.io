const express = require('express');
const path = require('path');
const spawn = require('child_process').spawn;
const app = express()

app.use(express.static( path.join(__dirname, '../app/') ));

// add middleware
// app.use(cors())

app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname, '../index.html'));
})

app.get('/baireaddepth', function (req, res) {
	var baiReadDepth = spawn(path.join(__dirname,'/scripts/baireaddepth.sh'), [req.query.baiUrl]);
  baiReadDepth.stdout.pipe(res);
})

app.get('/bamstatsalive', function (req, res) {
  // Convert json regions into samtools regions for easy processing
  var sam_regions = JSON.parse(req.query.r).map(function(d) { return d.chr + ':' + d.start + '-' + d.end}).join(' ');
  var args = [ "-b", req.query.b, "-u", req.query.u, "-k", req.query.k, "-r", req.query.r, sam_regions ]

  var bamstatsalive = spawn(path.join(__dirname,'/scripts/bamstatsalive.sh'), args);
  bamstatsalive.stdout.pipe(res);
})

// app.post('/clientbai', function(req, res) {
//     var baiReadDepth = spawn('/Users/chase/Code/minion/bin/bamReadDepther');
//     baiReadDepth.stdout.pipe(res);
//     req.pipe(baiReadDepth.stdin);
// });

app.post('/clientbam', function(req, res) {
    var args = ["-u", req.query.u, "-k", req.query.k, "-r", req.query.r, '-s']
    var bamstatsalive = spawn('/Users/chase/Code/playground/monolith_test/bamstatsalive.sh', args);
    bamstatsalive.stdout.on('error', function(e) { console.log('out = ' + e)})
    bamstatsalive.stdin.on('error', function(e) { console.log(e)})
    req.pipe(bamstatsalive.stdin);
    bamstatsalive.stdout.pipe(res);
});

var server = app.listen(4000, function () {
  console.log('Listening on port %d', server.address().port);
})
