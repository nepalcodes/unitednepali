const express = require('express')
const app = express()
const port = 3000

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));

const organizations = {}
let currId = 0



app.get('/', (req, res) => res.send('Hello United Nepali!'))

app.get('/health-check', (req, res) => res.send('OK'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

app.get('/organizations', (req, res) => res.send(organizations))

app.post('/organizations', function(req, res){
	let id_val = currId;
	currId = currId + 1;

	organizations[id_val] = {'Name':req.body.name};
	res.sendStatus(200);

})


// * [GET] [organizations/:id] Gets organization by ID
// * [POST] [organizations/:id] Creates new organization by ID 
// * [PUT] [organizations/:id] Updates new organization by ID 
// * [DELETE] [organizations/:id] Delete organization by ID


