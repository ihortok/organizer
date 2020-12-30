const path = require( 'path' );
module.exports = {
    context: __dirname,
    entry: './app/assets/javascripts/main.js',
    output: {
        path: path.resolve( __dirname, './public/js' ),
        filename: 'main.min.js',
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: 'babel-loader',
            }
        ]
    }
};
