describe('Health Check', function() {
  it('returns OK', function() {
    cy.visit('localhost:3000/health-check')
    cy.contains('OK')
  })
})
