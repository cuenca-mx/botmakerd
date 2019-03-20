'use strict';

var AWS = require('aws-sdk');
AWS.config.update({region:'us-east-1'});

const app = require('../../app.js');
const chai = require('chai');
const expect = chai.expect;
var context;

var fs = require("fs");
var event = require("../../../event.json");

describe('Tests index', function () {
    it('verifies successful response', () => {
        /*app.lambdaHandler(event, context, function(err, result){
            console.log(result)
            expect(result.statusCode).to.equal(200);
        })
        
        expect(result).to.be.an('object');
        expect(result.statusCode).to.equal(200);
        expect(result.body).to.be.an('string');

        let response = JSON.parse(result.body);

        expect(response).to.be.an('object');
        expect(response.message).to.be.equal("hello world");
        // expect(response.location).to.be.an("string");*/
    });
});
