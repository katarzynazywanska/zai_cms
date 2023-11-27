/* Importing modules*/
const express = require('express');
const path = require('path');
const hbs = require('express-handlebars');
const flash = require('connect-flash');
const session = require('express-session');
const methodOverride = require('method-override');
const expFileUpload = require('express-fileupload');
const passport = require('passport');

const { selectOpt } = require('./config/utils');

const { postgreSQL, port, variables } = require('./config/configuration');
const { Client } = require('pg');
const client = new Client(postgreSQL);

const app = express();

const pg = require('pg')
const pool = new pg.Pool(postgreSQL);
module.exports = { client, pool };



/* Configure express*/
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'pagesFiles')))

/* Flash, session */
app.use(session({
    secret: 'any',
    saveUninitialized: true,
    resave: true
}));

app.use(flash());

app.use(passport.initialize());
app.use(passport.session());

app.use(variables);
app.use(expFileUpload());

/* Setup view engine
    Handlebars */
app.engine('handlebars', hbs.engine({
    defaultLayout: 'default',
    helpers: { select: selectOpt }
}));
app.set('view engine', 'handlebars');


/* Override method*/
app.use(methodOverride('newMethod'));


/* routes */
const defaultRoutes = require('./routes/defaultRoutes');
const adminRoutes = require('./routes/adminRoutes');

app.use('/', defaultRoutes);
app.use('/admin', adminRoutes);

app.listen(port, () => {
    console.log('Server is running on port ' + port);

});