Helper = require('hubot-test-helper')
helper = new Helper('../scripts/grabURI.coffee')
expect = require('chai').expect
nock   = require('nock')

describe 'Otis', ->
  context 'Interaction with User', ->

    it 'should reply to User when handed proper URL', ->
      room = helper.createRoom()
      do nock.disableNetConnect
      nock('http://fakeAPIwebsite.com')
        .post('/url')
        .reply 200, url: 'http://fakewebsite.com'

      room.user.say('user1', 'http://fakewebsite.com').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'http://fakewebsite.com' ]
          [ 'hubot', 'Meow, Uploading: http://fakewebsite.com' ]
        ]
      room.destroy()
      nock.cleanAll()


    it 'should reply to User when handed proper URL inside of text', ->
      room = helper.createRoom()
      do nock.disableNetConnect
      nock('http://fakeAPIwebsite.com')
        .post('/url')
        .reply 200, url: 'http://fakewebsite.com'

      room.user.say('user1', 'You should check out this link http://fakewebsite.com').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'You should check out this link http://fakewebsite.com' ]
          [ 'hubot', 'Meow, Uploading: http://fakewebsite.com' ]
        ]
      room.destroy()
      nock.cleanAll()


    it 'should not reply to User when handed text', ->
      room = helper.createRoom()
      do nock.disableNetConnect
      nock('http://fakeAPIwebsite.com')
        .post('/url')
        .reply 200, url: 'http://fakewebsite.com'

      room.user.say('user1', 'This is super amazing').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'This is super amazing' ]
        ]
      room.destroy()
      nock.cleanAll()
