# To connect to PostgreSQL
1. Ensure /etc/krb5.conf includes the supported encoding required by KDC or DB
    default_tkt_enctypes = aes256-cts-hmac-sha1-96 des-cbc-md5 rc4-hmac
    default_tgs_enctypes = aes256-cts-hmac-sha1-96 des-cbc-md5 rc4-hmac

2. Create Kerberos ticket 
    kinit username@Example.COM
3. Connect
    psql -U username@Example.COM -p 5443 -h db.server.fqdn db_name
