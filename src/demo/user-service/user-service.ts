import * as express from 'express';
import * as bodyParser from 'body-parser';

import { User } from './user';

const users: User[] = require('./users.json');
let maxId = Math.max(...users.map(user => user.id));
let nextId = maxId + 1;

runServer();

function runServer() {
  const app = createExpress();
  const port = process.env.PORT || 8080;
  app.listen(port);
  console.log('Express server started @ http://localhost:' + port);
}

function createExpress(): express.Express {
  const app = express();
  app.use(bodyParser.json()); // support json encoded bodies
  app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
  app.use(function (req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
  });
  return app;
}

function createRoutes(app: express.Express): void {
  // Define routes
  app.get('/users', (req, res) => {
    res.send(users);
  });

  app.get('/users/:lastName', (req, res) => {
    const lastName = req.params.lastName.toLowerCase();
    let filteredUsers = users.filter(user => user.lastName.toLowerCase().includes(lastName));
    res.send(filteredUsers);
  });

  app.post('/users', (req, res) => {
    let newUser = {
      id: nextId++,
      firstName: req.body.firstName,
      lastName: req.body.lastName
    };
    users.push(newUser);
    res.send(newUser);
  });

}
