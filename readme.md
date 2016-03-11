# Xolphin API wrapper for Node.js

## Library installation

Library can be installed via [npm](http://npmjs.com/)

```
npm install xolphin-api-js
```

And updated via

```
npm update xolphin-api-js
```

## Usage

### Client initialization

```js
var xolphin = require('xolphin-api-js')

var client = new xolphin.Client('<username>', '<password>');
```

### Requests

#### Getting list of requests

```js
client.request.all(function(err, requests){
    requests.forEach(function(request){
        console.log(request.id, request._embedded.product.brand);
    });
});
```

### Getting request by ID

```js
client.request.get(961992625, function(err, request){
    console.log(err, request._embedded.product.id);
});
```

### Request certificate

```js
var ccr = client.request.create(24, 1, '<csr_string>', "EMAIL");
ccr.address = "Address";
ccr.approverFirstName = "FirstName";
ccr.approverLastName = "LastName";
ccr.approverPhone = "+12345678901";
ccr.approverEmail = "email@domain.com";
ccr.zipcode = "123456";
ccr.city = "City";
ccr.company = "Company";
ccr.subjectAlternativeNames.push("test1.domain.com");
ccr.subjectAlternativeNames.push("test2.domain.com");
ccr.dcv.push({
    domain: "test1.domain.com",
    dcvType: "EMAIL",
    approverEmail: "email1.domain.com"
});

client.request.send(ccr, function(err, result) {
    console.log(err, result.id);
});
```

### Certificate

#### Certificates list and expirations

```js
client.certificate.all(function(err, certificates){
    certificates.forEach(function(certificate){
        console.log(certificate.id, '-', (new Date(certificate.dateExpired).getTime() <= (new Date()).getTime()) );
    });
});
```

#### Download certificate

```js
var fs = require('fs');
client.certificate.download(961983489, 'CRT', function(err, certificate){
    fs.writeFileSync('cert.crt', certificate);
});
```

### Support

#### Products list

```js
client.support.products(function(err, products){
    products.forEach(function(product){
        console.log(product.id, product.brand);
    });
});
```

#### Decode CSR

```js
client.support.decodeCSR('<csr_string>', function(err, data){
    console.log(data.type, data.size);
});
```