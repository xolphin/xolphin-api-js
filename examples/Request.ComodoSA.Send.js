// example for sending a Comodo Subscriber Agreement for a given request ID
(function(){
    var Xolphin = require('../lib/xolphin.js');
    var client = new Xolphin.Client('fake_login@xolphin.api', 'Sup3rSecre7P@s$w0rdForThe@p1', true);

    client.request.sendComodoSAEmail(960000000, 'mail@example.com', 'en',function(err, result){
        console.log('Errors: '+err);
        console.log('Message: '+result.message);
    });

}).call(this);

