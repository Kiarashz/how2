/* js script to pass to mongo command like below
mongo.exe `
--tls `
--tlsAllowInvalidHostnames `
--host my.mongodb.server.com `
--username myname@SERVER.COM `
--authenticationMechanism=GSSAPI `
--authenticationDatabase='$external' `
databaseName `
this_script_filename.js
*/

appUsers=['123ABC', '456DEF']

print('start!!!!!!!!!!')
appUsers.forEach(function (aUser) {
    cursor = db.users.find({'uid': {'$regex' : `^${aUser}$`, '$options' : 'i'}},  
        { _id: 0, uid: 1, firstName: 1, lastName: 1, applications: 1, lastLoginTime: 1 })
    if ( cursor.hasNext() ){
        printjson( cursor.next() );
    }
    else {
        print(`${aUser} not found!`)
    }
});
print('done!!!!!!!!!!!!')
