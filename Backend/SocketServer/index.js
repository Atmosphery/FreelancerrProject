const eurekahelper = require('./eureka-helper');
const express = require('express');
var http = require('http');
const cors = require('cors');
const app = express();
const port = 5000;
//implement eureka
eurekahelper.registerWithEureka("socketservice", 0);

// const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require('socket.io')(server, {
    cors: {
        origin: "*"
    }
});

//middleware
app.use(express.json());
app.use(cors());
var clients = {};

io.on("connection", (socket) => {
    console.log("Connected");
    console.log(socket.id, " has joined");

    socket.on("signin", (id) => {
        console.log("userid: " + id);
        clients[id]=socket;
        //console.log(clients);
    });

    socket.on("message", (msg) => {
        console.log("msg: " + msg.targetId + " " + msg.sourceId);
        let targetId = msg.targetId;
        if (clients[targetId]) {
            clients[targetId].emit("message", msg);
        }
    });
});

server.listen(port, "0.0.0.0", () => {
    console.log("Server started on", port);
});