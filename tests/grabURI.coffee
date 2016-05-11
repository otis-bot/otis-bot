Helper = require('hubot-test-helper')
# helper loads all scripts passed a directory
helper = new Helper('./scripts')
co     = require('co')
expect = require('chai').expect

describe 'grabURI.coffee', ->

  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  context 'user posts URI', ->
    beforeEach ->
      co =>
        yield @room.user.say 'http://fakewebsite.com'

    it 'should reply to user', ->
      expect(@room.messages).to.eql [

      ]
