var http = require("http"), 
io = require("./node_modules/socket.io"),       
socket_server = http.createServer(function(req, res) {});   
socket_server.listen(614, null); 
var socket = io.listen(socket_server); 

console.log("BUILDEST Main Server");
console.log("Developed by. Han Yun Do")
console.log("Listening on server.yun.do:614")

var adapter;
var clients=[], names=[], teams=[];

socket.on("connection", function(client) {
	console.log("Connection!")
	
	
	client.emit("who_are_you", {});
	client.on("disconnect", function() {
		console.log("disconnection!")
		if(clients.indexOf(client)>=0) {
			adapter.emit("data", {type:"bye_user","clientID":clients.indexOf(client)})
		}
	});
	client.on("iamadapter", function(msg) {
		console.log("Hi, Adapter!");
		adapter = client;
		adapter.emit("adapter", {});
	});
	client.on("iamplayer", function(msg) {
		
		clients.push(client);
	
		clientID = clients.indexOf(client);
		names[clientID] = msg.name;
		teams[clientID] = msg.team;
		
		console.log(msg);
		adapter.emit("data", {type:"new_user","clientID":clientID,"name":names[clientID],"team":teams[clientID], "chara":msg.chara})
		client.emit("auth",{});
	});
	
	
	client.on("btn_pop", function(json){
		clientID = clients.indexOf(client);
		if(clientID > -1) {
			adapter.emit("data",{type:"pop", btn:json.target, "clientID":clientID});
		}
	});
	client.on("btn_push",function(json){
		clientID = clients.indexOf(client);
		if(clientID > -1) {
			adapter.emit("data",{type:"push", btn:json.target, "clientID":clientID});
		}
	});
	
	
});

