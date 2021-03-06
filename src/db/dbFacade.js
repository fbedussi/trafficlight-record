import {config} from '../../package.json';
//import indexedDb from './services/indexedDb';
import firebase from './services/firebase';

var db;

// switch (config.db.toLowerCase()) {
//     case 'indexeddb':
//         db = indexedDb;
//         break;

//     case 'firebase':
//         db = firebase;
//         break;

//     default:
//         throw new Error('There is no service for db: ' + config.db);
//         break;
// }

db = firebase;

//All methods return a promise
window.dbInterface = {
    openDb: db.openDb,

    create: db.create,
    read: db.read,
    readAll: db.readAll,
    update: db.update,
    delete: db.delete,
    replaceAll: db.replaceAll
};