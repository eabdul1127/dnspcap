var pcap = require("pcap");
var zmq = require("zeromq"),
    sock = zmq.socket("push");
var SysLogger = require("ain2"),
    logger = new SysLogger();
var config = require("/etc/dnspcap.js");
var Cryptr = require("cryptr"),
    cryptr = new Cryptr(config.secret_key, "aes-128-ctr");
var memoize = require("memoizee"),
    memoized = memoize(cryptr.encrypt, { maxAge: 1000*60*60*24 }); // 24 hours

var endpoint = "tcp://127.0.0.1:" + process.argv[2];
sock.setsockopt(zmq['ZMQ_SNDHWM'], 100000);
sock.connect(endpoint);

var sanitizePacket = function (packet) {
  var packetData = packet.payload.payload.payload.data;
  var hashed_ip = memoized(packet.payload.payload.daddr + config.secret_key);
  var hashed_mac = memoized(packet.payload.dhost.addr.join(".") + config.secret_key);
  return { mac: hashed_mac, ip: hashed_ip, packetData: packetData };
};

var handlePacket = function (raw_packet) {
  var packet;
  var sanitizedPacket;
  try {
    packet = pcap.decode.packet(raw_packet);
    sanitizedPacket = sanitizePacket(packet);
    sock.send(JSON.stringify(sanitizedPacket));
  } catch (e) {
    var errString = "Error Occurred: " + e + ", Packet: " + packet;
    if(sanitizedPacket != undefined)
      errString += ", Sanitized: " + sanitizedPacket;
    logger.error(errString);
  }
};

var pcap_session = pcap.createSession(process.argv[3], "ip proto 17 and src port 53");
pcap_session.on("packet", handlePacket);
