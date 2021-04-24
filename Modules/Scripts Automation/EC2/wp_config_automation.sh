cat > /tmp/wordpress/wp-config.php <<EOF
<?php
define( 'DB_NAME', '$wp_db' );
define( 'DB_USER', '$wp_user' );
define( 'DB_PASSWORD', '$wp_password' );
define( 'DB_HOST', '$wp_host' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

$(wget https://api.wordpress.org/secret-key/1.1/salt/ -q -O -)

\$table_prefix = 'wp_';

define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';

EOF
