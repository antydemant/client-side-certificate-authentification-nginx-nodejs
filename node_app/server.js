const express = require('express');
const fs = require('fs');
const https = require('https');
const pem = require('pem');
const { pki } = require('node-forge');
const x509 = require('x509');

const opts = {
	key: fs.readFileSync('server.key'),
	cert: fs.readFileSync('server.crt'),
	ca: fs.readFileSync('ca.crt'),
	requestCert: true,
	rejectUnauthorized: false
};

/**
 * Chunks the string.
 * @fucntion chunk
 * @public
 * @param {String} str Input.
 * @param {Number} n Break.
 * @return {String[]} Chunks.
 */
function chunk(str, n) {
	var ret = [],
		i,
		len;
	for (i = 0, len = str.length; i < len; i += n) {
		ret.push(str.substr(i, n));
	}
	return ret;
}

const app = express();

// add clientCertificateAuth to the middleware stack, passing it a callback
// which will do further examination of the provided certificate.
app.use(function(err, req, res, next) {
	console.log(err);
	next();
});

app.get('/', function(req, res) {
	// const pem = pki.certificateFromPem(fs.readFileSync('ca.crt'));
	let cert = req.headers['x-ssl-cert'] && req.headers['x-ssl-cert'].replace(/\t/g, '\n');
	let t = null;

	cert = decodeURIComponent(cert);
	const interestingStuff = x509.getSubject(cert);
	console.log(x509.parseCert(cert));

	res.send(interestingStuff);

});

https.createServer(opts, app).listen(8000);
