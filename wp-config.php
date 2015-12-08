<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

/*
 * Define which environment that we're currently in
 *
 *	local, staging, or production
 */
if ( !defined( 'DEV_ENVIRONMENT' ) ){
	define( 'DEV_ENVIRONMENT', 'local' );
}

/*
 * Check against our various config files and include the proper one for the environment.
 */
if ( DEV_ENVIRONMENT === 'local' ) {

	// Include our config
	include( dirname( __FILE__ ) . '/wp-config-local.php' );

	define( 'OTM_DEV', true );
	define( 'WP_DEBUG', true );		// Turn debug statements on
	define( 'WP_DEBUG_LOG', true );	// Turn debug logging on
	define( 'SAVEQUERIES', true );	// Save all queries for reference

} elseif ( DEV_ENVIRONMENT === 'staging' ) {

	// Include our config
	include( dirname( __FILE__ ) . '/wp-config-local.php' );

	define( 'OTM_DEV', false );
	define( 'WP_DEBUG', true );		// Turn debug statements on

} elseif ( DEV_ENVIRONMENT === 'production' ) {

	// Include our config
	include( dirname( __FILE__ ) . '/wp-config-production.php' );

	define( 'OTM_DEV', false );
	define( 'WP_DEBUG', false );	// No debug for you

}

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'zc;_g:|Z6<w}+SaqcJf9=%qu`/ouF#jPzGaY>T)c|y,8a{sOGIUN2~rzAlMMq/$x');
define('SECURE_AUTH_KEY',  'Y>oD=+s-wl5a:f|$}uzD@Om]C)y1+z}Or9LLf*&Ba<10,QC52w|^m0CwXl_-=Vx=');
define('LOGGED_IN_KEY',    '<1[0~T#^q42)+8a1D@9PMdU/#I491SaFR1=|CG%HX{3J+(o(8FJ;VIe-,~[qMW2Q');
define('NONCE_KEY',        'AbTP-TrZ>i63$^F{}XRbS8DE+7zS<C --<T%?jR-4-6-+5PZK;q-//~k*/SdZ[ w');
define('AUTH_SALT',        'cuo_d1b]!U qEe<W)tEYG`x9:|lPQ)/_D`2*b{lrUG]d.tv^:PxEn0[bxIPj`szl');
define('SECURE_AUTH_SALT', '$5<I1=o>bpcs;-PL]#I(g-^b@_{OWQ+ w,*,|!LFixvR?~-qgf|baI+Pv;D0?,-|');
define('LOGGED_IN_SALT',   'tmyvp)v$x?+nHNyZ.ZBWoZzsw]QR-`8n,7d+{cM|-xGh-jDv+?#! :wf|LHZ@*}<');
define('NONCE_SALT',       '}S*iYh;2*AEB^)T#qRQF+WpR3*j|p<FBy3/R|M1tZ2,qQxZ<MX2N2:dZY1d:e-eH');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/* Define custom content directory */
define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/content' );
define( 'WP_CONTENT_URL', WP_HOME . '/content' );

/* Security overrides */
define( 'DISALLOW_FILE_EDIT', true );				// Turn off file editors

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
