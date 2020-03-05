const express = require('express')
const app = express()
const port = 3000

const organizations = {
	0: { 'Name': 'Nandu Business', 'Net Worth': '6 Billion', 'Business Type': 'Real Estate Dealer' },
	1: { 'Name': 'Sailesh Business', 'Net Worth': '20 Billion', 'Business Type': 'Food Dealer' }
}
const event = {
	0: {'event': 'Teej', 'Location': 'niggerLand', 'Date': '9/11', 'Price': '$69' },
	1: {'event': 'Christmas', 'Location': 'CuckLand',  'Date': '4/20', 'Price': '$69'}
}

app.get('/', (req, res) => res.send('Hello United Nepali!'))

app.get('/health-check', (req, res) => res.send('OK'))

app.get('/nepali-check', (req, res) => res.send('Bhaat Khaiyo?'))

app.get('/organizations', (req, res) => res.send(organizations))

app.get('/organizations_id', function (req, res) {
	var id = req.query.id;
	let org = organizations[id]
	res.send(org)
})

app.delete('/organization_id', function (req, res) {
    var id = req.query.id;
    let org = organizations[id]
    delete organizations[id]
    res.sendStatus(200)
})

app.post('/organization_id', function(req, res) {
	var id = req.query.id;
	organizations[id] = req.query;
	res.sendStatus(200);
})

app.put('/organization_id', function(req, res) {
	var id = req.query.id;
	var org = organizations[id];

	for(var key in req.query){
		if (key in org){
			org[key] = req.query[key];
		}
	}
	organizations[id] = org;

	res.sendStatus(200);
})

app.get('/event', (req, res) => res.send(event))

app.get('/event_details', function(req, res){
	var id = req.query.id;
	let lit = event[id]
	res.send(lit)
})

app.listen(port, () => console.log(`Example app listening on port ${ port }!`))