var node = document.getElementById('main');
var app = Elm.App.embed(node);
app.ports.infoForOutside.subscribe(function (cmd) {
    if (!cmd.tag || !cmd.tag.length) {
        return;
    }

    var payload = cmd.data;
    switch (cmd.tag) {
        case 'login':
            authInterface.logIn(payload)
                .then((user) => {
                    app.ports.infoForElm.send({
                        tag: 'loginResult',
                        data: user.uid
                    })
                })
                .catch((error) => {
                    app.ports.infoForElm.send({
                        tag: 'error',
                        data: error
                    })
                })
            ;
            break;
        
        case 'openDb':
            dbInterface.openDb(payload)
                .then((result, error) => {
                    app.ports.infoForElm.send({
                        tag: 'dbOpened',
                        data: result
                    })
                })
                .catch((error) => {
                    app.ports.infoForElm.send({
                        tag: 'error',
                        data: error
                    })
                })
            ;
            break;

        case 'readAllData':
            dbInterface.readAll(payload)
                .then((result, error) => {
                    var resultToSend = Object.assign({north: {}, south: {}, east: {}, west: {}}, result[0])
                    app.ports.infoForElm.send({
                        tag: 'allData',
                        data: resultToSend
                    })
                })
                .catch((error) => {
                    app.ports.infoForElm.send({
                        tag: 'error',
                        data: error
                    })
                })
            ;
            break;

        case 'writeData':
            var storeName = `data/${payload.direction}`;
            var content = payload.passageData;
            dbInterface.create({storeName, content})
                .then((result) => {
                    console.log(result);
                    // app.ports.infoForElm.send({
                    //     tag: 'allData',
                    //     data: result[0]
                    // })
                })
                .catch((error) => {
                    console.log(error);
                    // app.ports.infoForElm.send({
                    //     tag: 'error',
                    //     data: error
                    // })
                })
            ;
            break;

        default:
            dbInterface[cmd.tag](payload)
                .then((result, error) => {
                    app.ports.infoForElm.send(result)
                })
                .catch((error) => {
                    app.ports.infoForElm.send(error)
                })
            ;
            break;
    }
});