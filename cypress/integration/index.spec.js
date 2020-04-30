describe('Index', () => {
    it('users should be able to view the "/" page', () => {
        cy
          .visit('localhost')
	  .get('h1').contains('UNITED NEPALI');
    });
});

