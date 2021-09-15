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


dbURI='mongodb://myname%40SERVER.COM@db1.server.com,db2.server.com,db3.server.com/dbName?replicaSet=myReplica&authMechanism=GSSAPI&authSource=$external'
mongoexport \
--ssl \
--sslAllowInvalidHostnames \
--uri $dbURI \
--collection=users \
--type=csv \
--fields=uid,firstName,lastName,lastLoginTime,applications \
--out=my-users.csv \
--query='{"uid":
    {"$in":
        ["123ABC","456DEF"]
    }
}'
