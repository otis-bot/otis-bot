Helper = require('hubot-test-helper')
helper = new Helper('../scripts/grabURI.coffee')
expect = require('chai').expect
nock   = require('nock')

describe 'Otis Tests', ->
  context 'Interaction with User', ->
    room = null

    beforeEach ->
      room = helper.createRoom()
      do nock.disableNetConnect
      nock('http://fakeAPIwebsite.com')
        .post('/url')
        .reply 200, url: 'http://fakewebsite.com'

    afterEach ->
      room.destroy()
      nock.cleanAll()

    it 'should reply to User when handed proper URL', ->
      room.user.say('user1', 'http://fakewebsite.com').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'http://fakewebsite.com' ]
          [ 'hubot', 'Meow, Uploading: http://fakewebsite.com' ]
        ]

    it 'should reply to User when handed proper URL inside of text', ->
      room.user.say('user1', 'Check out this link http://fakewebsite.com').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'Check out this link http://fakewebsite.com' ]
          [ 'hubot', 'Meow, Uploading: http://fakewebsite.com' ]
        ]

    it 'should not reply to User when handed text', ->
      room.user.say('user1', 'This is super amazing').then =>
        expect(room.messages).to.eql [
          [ 'user1', 'This is super amazing' ]
        ]

  context 'matches with standard web urls', ->
    room = null
    urlRepresentation = null

    beforeEach ->
      room = helper.createRoom()
      do nock.disableNetConnect
      nock('http://fakeAPIwebsite.com')
        .post('/url')
        .reply 200, url: "#{urlRepresentation}"

    afterEach ->
      room.destroy()
      nock.cleanAll()

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
