Helper = require('hubot-test-helper')
helper = new Helper('../scripts/grabURI.coffee')

expect = require('chai').expect
co     = require('co')


describe 'Otis', ->
  context 'User posts URL', ->
    room = helper.createRoom()
    co =>
      yield room.user.say('user1', 'http://fakewebsite.com')

    it 'should reply to user', ->
      expect(room.messages).to.eql [
        [ 'user1', 'http://fakewebsite.com' ]
        [ 'hubot', 'Meow, Uploading: http://fakewebsite.com' ]
      ]

    room.destroy()
