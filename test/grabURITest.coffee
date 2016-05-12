Helper = require('hubot-test-helper')
helper = new Helper('../scripts/grabURI.coffee')
expect = require('chai').expect
nock   = require('nock')

describe 'Otis', ->
  context 'Interaction with User', ->

    it 'should reply to User when handed proper URL', ->
      room = helper.createRoom()
      room.user.say('user1', 'http://fakewebsite.com').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'http://fakewebsite.com' ]
          [ 'hubot', 'Meow, Uploading: http://fakewebsite.com' ]
        ]
      room.destroy()

    it 'should reply to User when handed proper URL inside of text', ->
      room = helper.createRoom()
      room.user.say('user1', 'You should check out this link http://fakewebsiteAgainTest.com').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'You should check out this link http://fakewebsiteAgainTest.com' ]
          [ 'hubot', 'Meow, Uploading: http://fakewebsiteAgainTest.com' ]
        ]
      room.destroy()

    it 'should not reply to User when handed text', ->
      room = helper.createRoom()
      room.user.say('user1', 'This is super amazing').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'This is super amazing' ]
        ]
      room.destroy()

describe 'HTTP', ->

  context 'user posts url', ->
    it 'should respond with url', ->
      @room = helper.createRoom()
      do nock.disableNetConnect
      nock('http://fakeAPIwebsite.com')
        .post('/url')
        .reply 200

      @room.user.say('user1', 'Here is the site https://amazingWebSiteYouGotThere.com').then =>
        expect(@room.messages).to.eql [
          [ 'user1', 'Here is the site https://amazingWebSiteYouGotThere.com' ]
          [ 'hubot', 'Meow, Uploading: https://amazingWebSiteYouGotThere.com' ]
        ]

      @room.destroy()
      nock.cleanAll()
