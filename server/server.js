const express = require('express')
const app = express()
const port = 3000

const organizations = {
	0: { 'Name': 'Nandu Business', 'Net Worth': '6 Billion', 'Business Type': 'Real Estate Dealer' },
	1: { 'Name': 'Sailesh Business', 'Net Worth': '20 Billion', 'Business Type': 'Food Dealer' }
}
const events = {
	0: {'event': 'Teej', 'Location': 'Hindu Sabha Mandir', 'Date': '9/01', 'Price': '$39' },
	1: {'event': 'Dashain', 'Location': 'My House',  'Date': '6/20', 'Price': '$62'}
}
var ID = 1;

function formatted_timestamp(input_date) {
  var d = new Date()
  if (input_date){
  	d = input_date
  }
  d = d.getFullYear() + "-" + ('0' + (d.getMonth() + 1)).slice(-2) + "-" + ('0' + d.getDate()).slice(-2) + " " + ('0' + d.getHours()).slice(-2) + ":" + ('0' + d.getMinutes()).slice(-2) + ":" + ('0' + d.getSeconds()).slice(-2);
  return d
}

function get_new_id() {
	ID++
	return ID
}

app.get('/', (req, res) => res.send('Hello United Nepali!'))

app.get('/health-check', (req, res) => res.send('OK'))

app.get('/organizations', function(req, res) {
	var id = req.query.id;
	if (id && organizations) {
	  res.status(200)
      res.send({
        "success": 1,
        "timestamp": formatted_timestamp(),
        "results": organizations[id]
      })
    }else if (organizations){
      res.status(200)
      res.send({
        "success": 1,
        "timestamp": formatted_timestamp(),
        "results": organizations
      })
    } else {
      res.status(500)
      res.send({
        "success": 0,
        "timestamp": formatted_timestamp(),
        "error": "Organizations is empty"
      })
   }
})


app.delete('/organizations', function (req, res) {
    var id = req.query.id
    if (id in organizations){
    	delete organizations[id]
    	res.send({
        "success": 1,
        "timestamp": formatted_timestamp()
        })
    }else{
      res.status(500)
      res.send({
        "success": 0,
        "timestamp": formatted_timestamp(),
        "error": "Organization does not exist"
      })
   }
})

app.post('/organizations', function(req, res) {
	var id = req.query.id;
	if (id && id in organizations){
		for (key in req.query){
			if (key in organizations[id]){
				organizations[id][key] = req.query.key;
			}
		}
		res.status(200)
        res.send({
          "success": 1,
          "timestamp": formatted_timestamp(),
          "results": organizations[id]
        })

	}else if (req.query){
		id = get_new_id();
		organizations[id] = {};
		for (key in req.query){
			if (key in organizations[id]){
				organizations[id][key] = req.query.key;
			}
		}
		res.status(200)
        res.send({
          "success": 1,
          "timestamp": formatted_timestamp(),
          "results": organizations[id]
        })
	}else{
		res.status(500)
        res.send({
          "success": 0,
          "timestamp": formatted_timestamp(),
          "error": "Empty POST request"
        })
	}

})

app.put('/organization_id', function(req, res) {
	var id = req.query.id;
	if (id && id in organizations){
		for (key in req.query){
			if (key in organizations[id]){
				organizations[id][key] = req.query.key;
			}
		}
		res.status(200)
        res.send({
          "success": 1,
          "timestamp": formatted_timestamp(),
          "results": organizations[id]
        })
	}else if (req.query){
		id = get_new_id();
		organizations[id] = {};
		for (key in req.query){
			if (key in organizations[id]){
				organizations[id][key] = req.query.key;
			}
		}
		res.status(200)
        res.send({
          "success": 1,
          "timestamp": formatted_timestamp(),
          "results": organizations[id]
        })
	}else{
		res.status(500)
        res.send({
          "success": 0,
          "timestamp": formatted_timestamp(),
          "error": "Empty POST request"
        })
	}
})

app.get('/events', function(req, res) {
	var id = req.query.id;
	if (events && id in events) {
	  res.status(200)
      res.send({
        "success": 1,
        "timestamp": formatted_timestamp(),
        "results": events[id]
      })
    }else if (events){
      res.status(200)
      res.send({
        "success": 1,
        "timestamp": formatted_timestamp(),
        "results": events
      })
    } else {
      res.status(500)
      res.send({
        "success": 0,
        "timestamp": formatted_timestamp(),
        "error": "Events is empty"
      })
   }
})


app.listen(port, () => console.log(`Example app listening on port ${ port }!`))
