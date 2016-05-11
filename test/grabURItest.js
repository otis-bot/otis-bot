var Helper = require('hubot-test-helper');
 // helper loads all scripts passed a directory
var helper = new Helper('../scripts/grabURI.js');
var expect = require('chai').expect;

describe('grabURI.coffee', function() {
  var room;

  beforeEach(function() {
    room = helper.createRoom();
  });

  afterEach(function() {
    room.destroy();
  });

  it('should reply to user', function() {
    room.user.say('http://fakewebsite.com');

    expect(room.messages).to.eql(['http://fakewebsite.com']);
  });
});
