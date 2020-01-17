const https =   require('https')
const express = require('express');
const path =    require('path');
const fs =      require("fs");

const app = express();

var options = {
    secureProtocol: 'TLSv1_2_server_method',
    secureOptions: require('constants').SSL_OP_NO_TLSv1 | require('constants').SSL_OP_NO_SSLv3 | require('constants').SSL_OP_NO_TLSv1_1,
    cert: fs.readFileSync("./cert.pem"),
    key: fs.readFileSync("./key.pem"),
    ciphers: [
        "ECDHE-RSA-AES256-SHA384",
        "DHE-RSA-AES256-SHA384",
        "ECDHE-RSA-AES256-SHA256",
        "DHE-RSA-AES256-SHA256",
        "ECDHE-RSA-AES128-SHA256",
        "DHE-RSA-AES128-SHA256",
        "HIGH",
        "!aNULL",
        "!eNULL",
        "!EXPORT",
        "!DES",
        "!RC4",
        "!MD5",
        "!PSK",
        "!SRP",
        "!CAMELLIA"
    ].join(':'),
    honorCipherOrder: true
};

app.use(express.static(path.join(__dirname, 'build')));
app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

const httpServer = https.createServer(options, app)
httpServer.listen({ port: 3000 }, () => {})
