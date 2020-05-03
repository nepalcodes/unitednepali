const express = require('express');

const app = express();
const port = 3000;

const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));

const organizations = {
  0: {
    Name: 'Nandu Business',
    'Net Worth': '6 Billion',
    'Business Type': 'Real Estate Dealer',
  },
  1: {
    Name: 'Sailesh Business',
    'Net Worth': '20 Billion',
    'Business Type': 'Food Dealer',
  },
};
const events = {
  0: {
    event: 'Teej',
    Location: 'Hindu Sabha Mandir',
    Date: '9/01',
    Price: '$39',
  },
  1: {
    event: 'Dashain',
    Location: 'My House',
    Date: '6/20',
    Price: '$62',
  },
};
let ID = 1;

function formattedTimestamp(inputDate) {
  let d = new Date();
  if (inputDate) {
    d = inputDate;
  }
  d = `${d.getFullYear()}-${`0${d.getMonth() + 1}`.slice(
    -2,
  )}-${`0${d.getDate()}`.slice(-2)} ${`0${d.getHours()}`.slice(
    -2,
  )}:${`0${d.getMinutes()}`.slice(-2)}:${`0${d.getSeconds()}`.slice(-2)}`;
  return d;
}

function getNewId() {
  ID += 1;
  return ID;
}

app.get('/api/', (req, res) => res.send('Hello United Nepali!'));

app.get('/api/health-check', (req, res) => res.send('OK'));

app.get('/api/organizations', (req, res) => {
  const { id } = req.query;
  if (id && organizations) {
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: organizations[id],
    });
  } else if (organizations) {
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: organizations,
    });
  } else {
    res.status(500);
    res.send({
      success: 0,
      timestamp: formattedTimestamp(),
      error: 'Organizations is empty',
    });
  }
});

app.delete('/api/organizations', (req, res) => {
  const { id } = req.query;
  if (id in organizations) {
    delete organizations[id];
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
    });
  } else {
    res.status(500);
    res.send({
      success: 0,
      timestamp: formattedTimestamp(),
      error: 'Organization does not exist',
    });
  }
});

app.post('/api/organizations', (req, res) => {
  let { id } = req.query;
  if (id && id in organizations) {
    // eslint-disable-next-line no-restricted-syntax
    for (const key in req.query) {
      if (key in organizations[id]) {
        organizations[id][key] = req.query.key;
      }
    }
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: organizations[id],
    });
  } else if (req.query) {
    id = getNewId();
    organizations[id] = {};
    // eslint-disable-next-line no-restricted-syntax
    for (const key in req.query) {
      if (key in organizations[id]) {
        organizations[id][key] = req.query.key;
      }
    }
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: organizations[id],
    });
  } else {
    res.status(500);
    res.send({
      success: 0,
      timestamp: formattedTimestamp(),
      error: 'Empty POST request',
    });
  }
});

app.put('/api/organization_id', (req, res) => {
  let { id } = req.query;
  if (id && id in organizations) {
    // eslint-disable-next-line no-restricted-syntax
    for (const key in req.query) {
      if (key in organizations[id]) {
        organizations[id][key] = req.query.key;
      }
    }
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: organizations[id],
    });
  } else if (req.query) {
    id = getNewId();
    organizations[id] = {};
    // eslint-disable-next-line no-restricted-syntax
    for (const key in req.query) {
      if (key in organizations[id]) {
        organizations[id][key] = req.query.key;
      }
    }
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: organizations[id],
    });
  } else {
    res.status(500);
    res.send({
      success: 0,
      timestamp: formattedTimestamp(),
      error: 'Empty POST request',
    });
  }
});

app.get('/api/events', (req, res) => {
  const { id } = req.query;
  if (events && id in events) {
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: events[id],
    });
  } else if (events) {
    res.status(200);
    res.send({
      success: 1,
      timestamp: formattedTimestamp(),
      results: events,
    });
  } else {
    res.status(500);
    res.send({
      success: 0,
      timestamp: formattedTimestamp(),
      error: 'Events is empty',
    });
  }
});

// eslint-disable-next-line no-console
app.listen(port, () => console.log(`Example app listening on port ${port}!`));
