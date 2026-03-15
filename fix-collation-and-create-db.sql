-- À exécuter en tant que postgres après mise à jour Windows (collation mismatch)
ALTER DATABASE postgres REFRESH COLLATION VERSION;
ALTER DATABASE template1 REFRESH COLLATION VERSION;
CREATE DATABASE storesemlali;
