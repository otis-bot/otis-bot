# Copyright (C) 2016 The Firehose Project
#
# This software may be modified and distributed under the terms
# of the MIT license.  See the LICENSE file for details.

Helper  = require('hubot-test-helper')
helper  = new Helper('../scripts/grabURI.coffee')
expect  = require('chai').expect
nock    = require('nock')
co      = require('co')
Promise = require('bluebird')

describe 'Testing of Otis bot', ->
  
  #
  # testing of the ability to POST to the backend
  #

  context 'When successfully attempting to POST to the backend API', ->

    room = null

    beforeEach ->      
      # stub out both the room and the backend API server
      room = helper.createRoom()
      nock('http://www.APIBackend.com')
        .post('/url')
        .reply(200, { url: 'http://fakewebsite.com' })

    afterEach ->
      # destroy the toom and reset the mocks
      room.destroy()
      nock.cleanAll()

    it 'should reply to User with the URL posted in Slack chat', ->
      co =>
        yield room.user.say 'testUser', 'http://testURL.com'
        yield new Promise.delay(1000)

        expect(room.messages).to.eql [
          [ 'testUser', 'http://testURL.com' ]
          [ 'hubot', 'Meow, Uploading: http://testURL.com' ]
        ]

  context 'When unsuccessfully attempting to POST to the backend API', ->

    room = null

    beforeEach ->      
      # stub out both the room and the backend API server
      room = helper.createRoom()
      nock('http://www.APIBackend.com')
        .post('/url')
        .replyWithError('Error');

    afterEach ->
      # destroy the toom and reset the mocks
      room.destroy()
      nock.cleanAll()

    it 'should reply to User to indicate a server failure has occurred', ->
      co =>
        yield room.user.say 'testUser', 'http://testURL.com'
        yield new Promise.delay(1000)

        expect(room.messages).to.eql [
          [ 'testUser', 'http://testURL.com' ],
          [ 'hubot', 'Meow, Uploading: http://testURL.com' ],
          [ 'hubot', 'Otis has failed' ],
        ]

  #
  # testing of the RegEx
  #

  # http
  context 'when matched against variations of a standard web url', ->
    
    room = null
    urlRepresentation = null

    beforeEach ->
      room = helper.createRoom()

    afterEach ->
      room.destroy()

    it 'should match www.example.com in the base case', ->
      urlRepresentation = 'http://www.example.com'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match when using https', ->
      urlRepresentation = 'https://www.example.com'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should not match when using domain name without http or https', ->
      urlRepresentation = 'www.example.com'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
        ]

    it 'should match when using http and no www prefix', ->
      urlRepresentation = 'https://example.com'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should not match example.com without any prefix', ->
      urlRepresentation = 'example.com'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
        ]

    it 'should match URLs containing individual pages', ->
      urlRepresentation = 'http://www.example.com/index.html'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match URLs containing query parameters', ->
      urlRepresentation = 'http://www.example.com/index.html?zip=94109'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match when using domain name with tilda', ->
      urlRepresentation = 'https://www.cs.tut.fi/~jkorpela/ftpurl.html'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match when using domain name with anchor', ->
      urlRepresentation = 'http://fullurlhere.com/nbs-test-panel-of-diseases-2#anchorlink1'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

  # ftp
  context 'when matched against variations of a standard ftp uri', ->
    
    room = null
    urlRepresentation = null

    beforeEach ->
      room = helper.createRoom()

    afterEach ->
      room.destroy()

    it 'should match when using domain name with ftp', ->
      urlRepresentation = 'ftp://ftp.example.com'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match when using domain name without ftp', ->
      urlRepresentation = 'ftp://example.com'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match FTPs containing individual pages', ->
      urlRepresentation = 'ftp://ftp.example.com/index.zip'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match when using domain name without ftp', ->
      urlRepresentation = 'ftp://example.com/index.html?file=requestedFileName.zip'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]

    it 'should match when using domain name ftp with user password and decorator symbol', ->
      urlRepresentation = 'ftp://user:password@host.private'

      room.user.say('user1', "#{urlRepresentation}").then =>
        expect(room.messages).to.eql [
          [ 'user1', "#{urlRepresentation}" ]
          [ 'hubot', "Meow, Uploading: #{urlRepresentation}" ]
        ]