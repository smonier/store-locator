const path = require('path');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;
const {CleanWebpackPlugin} = require('clean-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const CaseSensitivePathsPlugin = require('case-sensitive-paths-webpack-plugin');
const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');
const getModuleFederationConfig = require('@jahia/webpack-config/getModuleFederationConfig');
const packageJson = require('./package.json');

// const shared = require('./webpack.shared');

module.exports = (env, argv) => {
    let config = {
        entry: {
            main: path.resolve(__dirname, 'src/javascript/index')
        },
        output: {
            path: path.resolve(__dirname, 'src/main/resources/javascript/apps/'),
            filename: 'storeOpeningHours-editor.bundle.js',
            chunkFilename: '[name].storeOpeningHours.[chunkhash:6].js'
        },
        resolve: {
            mainFields: ['module', 'main'],
            extensions: ['.mjs', '.js', '.jsx', 'json', '.scss'],
            fallback: { "url": false }
        },
        module: {
            rules: [
                {
                    test: /\.m?js$/,
                    type: 'javascript/auto'
                },
                {
                    test: /\.jsx?$/,
                    include: [path.join(__dirname, 'src')],
                    exclude: /node_modules/,
                    use: {
                        loader: 'babel-loader',
                        options: {
                            presets: [
                                ['@babel/preset-env', {
                                    modules: false,
                                    targets: {chrome: '60', edge: '44', firefox: '54', safari: '12'}
                                }],
                                '@babel/preset-react'
                            ],
                            plugins: [
                                'lodash',
                                '@babel/plugin-syntax-dynamic-import'
                            ]
                        }
                    }
                },
                {
                    test: /\.css$/,
                    use: ['style-loader', 'css-loader']
                },
                {
                    test: /\.scss$/i,
                    sideEffects: true,
                    use: [
                        'style-loader',
                        // Translates CSS into CommonJS
                        {
                            loader: 'css-loader',
                            options: {
                                modules: {
                                    mode: 'local'
                                }
                            }
                        },
                        // Compiles Sass to CSS
                        // 'sass-loader'
                    ]
                },
                {
                    test: /\.(png|svg)$/,
                    type: 'asset/resource',
                    // use: ['file-loader']
                },
                {
                    test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                    type: 'asset/resource',
                    dependency: { not: ['url'] }
                    // use: [{
                    //     loader: 'file-loader',
                    //     options: {
                    //         name: '[name].[ext]',
                    //         outputPath: 'fonts/'
                    //     }
                    // }]
                }
            ]
        },
        plugins: [
            // new ModuleFederationPlugin({
            //     name: "quizQnAJsonEditor",
            //     library: { type: "assign", name: "appShell.remotes.quizQnAJsonEditor" },
            //     filename: "remoteEntry.js",
            //     exposes: {
            //         './init': './src/javascript/init'
            //     },
            //     remotes: {
            //         '@jahia/app-shell': 'appShellRemote'
            //     },
            //     shared
            // }),
            new ModuleFederationPlugin(getModuleFederationConfig(packageJson, {
                remotes: {
                    '@jahia/app-shell': 'appShellRemote'
                }
            })),
            new CleanWebpackPlugin({
                cleanOnceBeforeBuildPatterns: [`${path.resolve(__dirname, 'src/main/resources/javascript/apps/')}/**/*`],
                verbose: false
            }),
            new CopyWebpackPlugin({
                patterns: [{
                    from: './package.json',
                    to: ''
                }]
            }),
            // new CopyWebpackPlugin([{from: './package.json', to: ''}])
            new CaseSensitivePathsPlugin()
        ],
        mode: 'development'
    };

    config.devtool = (argv.mode === 'production') ? 'source-map' : 'eval-source-map';

    if (argv.analyze) {
        config.devtool = 'source-map';
        config.plugins.push(new BundleAnalyzerPlugin());
    }

    return config;
};