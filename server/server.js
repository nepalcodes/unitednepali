const express = require('express')
const app = express()
const port = 3000

const organizations = []

app.get('/', (req, res) => res.send('Hello United Nepali!'))

app.get('/health-check', (req, res) => res.send('OK'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))

app.get('/organizations', (req, res) => res.send(organizations))


