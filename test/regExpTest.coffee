expect = require('chai').expect

describe 'regExp matches URI', ->
  regExp = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?", "i")


  # In the case of the ...
  context 'with standard web urls', ->
    it 'should match www.example.com in the base case', ->
      urlRepresentation = 'http://www.example.com'

      expect(urlRepresentation).to.match(regExp)

    it 'should match when using https', ->
      urlRepresentation = 'https://www.example.com'

      expect(urlRepresentation).to.match(regExp)

    it 'should match when using domain name without http or https', ->
      urlRepresentation = 'www.example.com'

      expect(urlRepresentation).to.match(regExp)


  # In the case of the ...
  context 'with individual pages and query parameters', ->
    it 'should match URLs containing individual pages', ->
      urlRepresentation = 'http://www.example.com/index.html'

      expect(urlRepresentation).to.match(regExp)

    it 'should match URLs containing query parameters', ->
      urlRepresentation = 'http://www.example.com/index.html?zip=94109'

      expect(urlRepresentation).to.match(regExp)


  # In the case of the ...
  context 'with standard ftp', ->
    it 'should match when using domain name with ftp', ->
      urlRepresentation = 'ftp://ftp.example.com'

      expect(urlRepresentation).to.match(regExp)

    it 'should match when using domain name without ftp', ->
      urlRepresentation = 'ftp://example.com'

      expect(urlRepresentation).to.match(regExp)


  # In the case of the ...
  context 'with standard ftp with individual pages and query parameters', ->
    it 'should match FTPs containing individual pages', ->
      urlRepresentation = 'ftp://ftp.example.com/index.zip'

      expect(urlRepresentation).to.match(regExp)

    it 'should match when using domain name without ftp', ->
      urlRepresentation = 'ftp://example.com/index.html?file=requestedFileName.zip'

      expect(urlRepresentation).to.match(regExp)
