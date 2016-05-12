Helper = require('hubot-test-helper')
helper = new Helper('../scripts/grabURI.coffee')
expect = require('chai').expect

describe 'Otis', ->
  context 'User posts URL', ->
    it 'should reply to user', ->
      room = helper.createRoom()

      room.user.say('user1', 'http://fakewebsite.com').then ->
        expect(room.messages).to.eql [
          [ 'user1', 'http://fakewebsite.com']
          [ 'hubot', 'Meow, Uploading: http://fakewebsite.com' ]
        ]

      room.destroy()
