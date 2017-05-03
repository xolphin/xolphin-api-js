// example for getting all notes for given request ID
(function(){
    var Xolphin = require('../lib/xolphin.js');
    var client = new Xolphin.Client('fake_login@xolphin.api', 'Sup3rSecre7P@s$w0rdForThe@p1', true);

    client.request.getNotes(960000000, function(err, result){
        result.forEach(function(v){
           console.log('Message: '+v.message);
        });
    });

}).call(this);

