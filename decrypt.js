var config = require("/etc/dnspcap.js");
var Cryptr = require("cryptr"),
    cryptr = new Cryptr(config.secret_key, "aes-128-ctr");
if(process.argv[2] != undefined) {
  var ip_or_mac;
  try {
    ip_or_mac = cryptr.decrypt(process.argv[2]);    
  } 
  catch (e) {
    process.stderr.write("Could not successfully decrypt hash\n");
    process.exit(0);
  }
}
else {
  process.stderr.write("Usage: node " + process.argv[1] + " [hashed_ip_or_mac]\n");
  process.exit(0);
}
if(ip_or_mac.endsWith(config.secret_key))
  process.stdout.write(ip_or_mac.substring(0,ip_or_mac.length-config.secret_key.length) + '\n');
else 
  process.stderr.write("Could not successfully decrypt hash\n");