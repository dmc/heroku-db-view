# heroku-db-view
db-view for heroku

# access
https://db-view.herokuapp.com/

# databases presetting

modify presets array described in index.html

# preseted database

## postgresql-heroku
world.sql had imported.
world database has 3 tables as city,country and countrylanguage

so try sql like...

* select * from city
* select * from country
* select * from countrylanguage

you can also inspect database like

* select * from information_schema.tables
* select * from information_schema.columns


## mysql-heroku
* world.sql had imported.

try same sql as postgresql

## MySQL information_schema

You can inspect management databases of MySQL below

* CHARACTER_SETS
* COLLATIONS
* COLLATION_CHARACTER_SET_APPLICABILITY
* COLUMNS
* COLUMN_PRIVILEGES
* ENGINES
* EVENTS
* FILES
* GLOBAL_STATUS
* GLOBAL_VARIABLES
* KEY_COLUMN_USAGE
* PARAMETERS
* PARTITIONS
* PLUGINS
* PROCESSLIST
* PROFILING
* REFERENTIAL_CONSTRAINTS
* ROUTINES
* SCHEMATA
* SCHEMA_PRIVILEGES
* SESSION_STATUS
* SESSION_VARIABLES
* STATISTICS
* TABLES
* TABLESPACES
* TABLE_CONSTRAINTS
* TABLE_PRIVILEGES
* TRIGGERS
* USER_PRIVILEGES
* VIEWS
* INNODB_BUFFER_PAGE
* INNODB_TRX
* INNODB_BUFFER_POOL_STATS
* INNODB_LOCK_WAITS
* INNODB_CMPMEM
* INNODB_CMP
* INNODB_LOCKS
* INNODB_CMPMEM_RESET
* INNODB_CMP_RESET
* INNODB_BUFFER_PAGE_LRU
