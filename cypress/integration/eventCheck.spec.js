describe('organizations', () =>{
    Cypress.config('baseUrl','http://localhost:3000/')

    it('Get- read', () => {
      cy.request('/events').then((response) => {
          expect(response).to.have.property('status',200)
          expect(response.body).to.not.be.null
      }) 
  })

  it('POST-Create', () => {
      const item = {"success":1,"timestamp":"2020-03-25 16:52:19","results":{"0":{"event":"Teej","Location":"Hindu Sabha Mandir","Date":"9/01","Price":"$39"},"1":{"event":"Dashain","Location":"My House","Date":"6/20","Price":"$62"}}}
      cy.request('events?id=0',item )
      .its('body')
      .its('results')
      .should('include',{event:'Teej'})
  })

  it('PUT - Update', () => {
    const item = {"event":"Holi"}
    cy.request({method:'PUT',url:'events?id=0',body:item, failOnStatusCode: false})

  })
})