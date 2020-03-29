describe('organizations', () =>{
    Cypress.config('baseUrl','http://localhost:3000/')

    it('GET - read', () => {
      cy.request('/organizations').then((response) => {
          expect(response).to.have.property('status',200)
          expect(response.body).to.not.be.null
      }) 
  })

  it('POST-Create', () => {
      const item = {"success":1,"timestamp":"2020-03-25 15:38:30","results":{"0":{"Name":"Nandu Business","Net Worth":"6 Billion","Business Type":"Real Estate Dealer"},"1":{"Name":"Sailesh Business","Net Worth":"20 Billion","Business Type":"Food Dealer"}}}
      cy.request('organizations?id=0',item )
      .its('body')
      .its('results')
      .should('include',{Name:'Nandu Business'})
  })

  it('PUT - update', () => {
    const item = {"Name":"Saagr"}
    cy.request({method:'PUT', url:'/organizations?',body:item, failOnStatusCode: false})
  })
})