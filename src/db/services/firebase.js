import firebase from './firebaseInit';

const db = firebase.database();
var userUid;

const openDb = (payload) => new Promise(({resolve, reject}) => {
  userUid = payload.userUid
  //resolve(dbInterface);
});

const createInStore = ({storeName = data, content}) => db
    //.ref(`users/${user.uid}/${storeName}/${content.id}`)
    //.ref(`${storeName}/${content.id}`)
    .ref(`users/${userUid}/${storeName}/`)
    .push(content)
;

const readInStore = ({storeName, contentId}) => db
  //.ref(`users/${user.uid}/${storeName}/${contentId}`)
  .ref(`users/${userUid}/${storeName}/${contentId}`)
  .once('value')
  .then((snapshot) => snapshot.val())
;

const readAllInStore = ({storeName = 'data'}) => db
  //.ref(`users/${user.uid}/${storeName}`)
  .ref(`users/${userUid}/${storeName}`)
  .once('value')
  .then((snapshot) => [].concat(snapshot.val()).filter((i) => i)) //convert everything into an array
;

const updateInStore = ({storeName, content}) => db
  //.ref(`users/${user.uid}/${storeName}/${content.id}`)
  .ref(`users/${userUid}/${storeName}/${content.id}`)
  .update(content)
;

const deleteInStore = ({storeName, contentId}) => db
  //.ref(`users/${user.uid}/${storeName}/${contentId}`)
  .ref(`users/${userUid}/${storeName}/${contentId}`)
  .remove()
;
  
const replaceAllInStore = ({storeName, data}) => {
  const writeAllRecords = data.map((record) => createInStore(storeName, record));
  
  return Promise.all(writeAllRecords);
}


const dbInterface = {
  openDb,

  create: createInStore,
  read: readInStore,
  readAll: readAllInStore,
  update: updateInStore,
  delete: deleteInStore,
  replaceAll: replaceAllInStore,
};

export default dbInterface;
