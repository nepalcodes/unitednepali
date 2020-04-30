describe('API endpoints Check', function() {
    it('returns Hello United Nepali', function() {
        cy
          .visit('localhost/api')
	  .contains('Hello United Nepali!')
    });

    it('returns OK', function() {
        cy
          .visit('localhost/api/health-check')
          .contains('OK')
    });
});
