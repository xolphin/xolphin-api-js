// example for creating a note for given request ID
(function(){
    var Xolphin = require('../lib/xolphin.js');
    var client = new Xolphin.Client('fake_login@xolphin.api', 'Sup3rSecre7P@s$w0rdForThe@p1', true);

    client.request.sendNote(960000000, 'My message',function(err, result){
        console.log('Errors: '+err);
        console.log('Message: '+result.message);
    });

}).call(this);

