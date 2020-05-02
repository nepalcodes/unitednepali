describe('API endpoints Check', () => {
  it('returns Hello United Nepali', () => {
    cy
      .visit('localhost/api')
	  .contains('Hello United Nepali!');
  });

  it('returns OK', () => {
    cy
      .visit('localhost/api/health-check')
      .contains('OK');
  });
});
