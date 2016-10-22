import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    property var database

    Component.onCompleted: {
        database = LocalStorage.openDatabaseSync("MessageDatabase", "1.0",
            "Database to store messages", 1000000);
        database.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS MessageDatabase(
                 id INTEGER PRIMARY KEY,
                 message TEXT)");
        });
    }

    function addMessage(message) {
        database.transaction(function(tx) {
            tx.executeSql("INSERT INTO MessageDatabase(message) VALUES(?)", [message]);
        });
    }

    function retrieveAllMessages(callback) {
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM MessageDatabase");
            callback(result.rows);
        });
    }

    function clearMessages() {
        database.transaction(function(tx) {
            tx.executeSql("DELETE FROM MessageDatabase");
        });
    }
}

