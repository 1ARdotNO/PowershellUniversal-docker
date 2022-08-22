// Generates a MeshCentral login token
//
// Start by running the following on your server to get the login key:
//
//    node node_module/meshcentral --LoginTokenKey
//
// You can also run the following command to get a list of user identifiers
// 
//    node node_module/meshcentral --ListUserIDs
//
// Then run this tool, for example:
//
//    node meshgentoken.js 65381f2d9919e7dfe256ace9cbb... user//admin
//
// This will return a time limited login token.

if (process.argv.length != 4) {
    console.log('MeshCentral Login Token Generator');
    console.log('Usage: MeshGenToken [hexkey] [userid]');
} else {
    var loginCookieEncryptionKey = null;
    var userid = process.argv[3];
    try { loginCookieEncryptionKey = Buffer.from(process.argv[2], 'hex'); } catch (ex) { }
    if ((loginCookieEncryptionKey == null) || (loginCookieEncryptionKey.length < 32)) {
        console.log('Invalid key, must be at least 32 bytes long.');
    } else {
        console.log(encodeCookie({ u: userid, a: 3 }, loginCookieEncryptionKey));
    }
}

// Encode an object as a cookie using a key using AES-GCM. (key must be 32 bytes or more)
function encodeCookie(o, key) {
    try {
        var crypto = require('crypto');
        o.time = Math.floor(Date.now() / 1000 - 120); // Add the cookie creation time
        const iv = Buffer.from(crypto.randomBytes(12), 'binary'), cipher = crypto.createCipheriv('aes-256-gcm', key.slice(0, 32), iv);
        const crypted = Buffer.concat([cipher.update(JSON.stringify(o), 'utf8'), cipher.final()]);
        var r = Buffer.concat([iv, cipher.getAuthTag(), crypted]).toString('base64').replace(/\+/g, '@').replace(/\//g, '$');
        return r;
    } catch (ex) { console.log('ERR: Failed to encode AESGCM cookie due to exception: ' + ex); return null; }
};
