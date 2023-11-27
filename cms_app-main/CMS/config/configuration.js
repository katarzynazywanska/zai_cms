module.exports = {
    postgreSQL: {
        host: "postgres",
        user: "postgres",
        port: "5432",
        password: "postgres",
        database: "postgres"
    },
    port: process.env.port || 3000,
    variables: (req, res, next) => {
        res.locals.successMessage = req.flash('success-message');
        res.locals.errorMessage = req.flash('error-message');
        res.locals.user = req.user || null;
        next();
    }
};