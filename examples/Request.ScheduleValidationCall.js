// example for scheduling a validation call
(function(){
    var Xolphin = require('../lib/xolphin.js');
    var client = new Xolphin.Client('seleniumtest@xolphin.nl', 'HJKIvs92vnm81!<9d>m', true);
    client.request.scheduleValidationCall(960000000, new Date('2017-05-05 15:00:00'), function(data, message){
        console.log(data);
        console.log(message);
    });
}).call(this);