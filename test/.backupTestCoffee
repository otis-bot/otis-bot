Helper = require('hubot-test-helper')
expect = require('chai').expect
helper = new Helper('../scripts/grabURI.coffee')

describe 'grabURI.coffee', ->
  room = null

  beforeEach ->
    room = helper.createRoom()

  afterEach ->
    room.destroy()

  context 'user posts URI', ->
    beforeEach ->
      room.user.say 'http://fakewebsite.com'

    it 'should reply to user', ->
      expect(room.messages).to.eql [
        ['http://fakewebsite.com']
      ]
