% MKSQLITE Eine MATLAB Schnittstelle zu SQLite
%  SQLite ist eine Embedded SQL Engine, welche ohne Server SQL Datenbanken
%  innerhalb von Dateien verwalten kann. MKSQLITE bietet die Schnittstelle
%  zu dieser SQL Datenbank.

% Genereller Aufruf:
%  dbid = mksqlite([dbid, ] SQLBefehl [, Argument])
%    Der Parameter dbid ist optional und wird nur dann benötigt, wenn mit
%    mehreren Datenbanken gleichzeitig gearbeitet werden soll. Wird dbid
%    weggelassen, so wird automatisch die Datenbank Nr. 1 verwendet.

% Funktionsaufrufe:
%  mksqlite('open', 'datenbankdatei')
% oder
%  dbid = mksqlite(0, 'open', 'datenbankdatei')
% Öffnet die Datenbankdatei mit dem Dateinamen "datenbankdatei". Wenn eine
% solche Datei nicht existiert wird sie angelegt.
% Wenn eine dbid angegeben wird und diese sich auf eine bereits geöffnete
% Datenbank bezieht, so wird diese vor Befehlsausführung geschlossen. Bei
% Angabe der dbid 0 wird die nächste freie dbid zurück geliefert.

%  mksqlite('close')
% oder
%  mksqlite(dbid, 'close')
% oder
%  mksqlite(0, 'close')
% Schliesst eine Datenbankdatei. Bei Angabe einer dbid wird diese Datenbank
% geschlossen. Bei Angabe der dbid 0 werden alle offenen Datenbanken
% geschlossen.

%  mksqlite('SQL-Befehl')
% oder
%  mksqlite(dbid, 'SQL-Befehl')
% Führt SQL-Befehl aus.

% Beispiel:
%  mksqlite('open', 'testdb.db3');
%  result = mksqlite('select * from testtable');
%  mksqlite('close');
% Liest alle Felder der Tabelle "testtable" in der Datenbank "testdb.db3"
% in die Variable "result" ein.

% Beispiel:
%  mksqlite('open', 'testdb.db3')
%  mksqlite('show tables')
%  mksqlite('close')
% Zeigt alle Tabellen in der Datenbank "testdb.db3" an.

% (c) 2008 by Martin Kortmann <mail@kortmann.de>

%% english via google's translator

% Mksqlite A MATLAB interface to SQLite
%  SQLite is an embedded SQL engine, which without SQL Server databases
%  can manage within files. Mksqlite provides the interface
%  to this SQL database.

% General Usage:
%  dbid = mksqlite ([dbid,] SQLBefehl [, argument])
%    The parameter is optional and dbid is only needed when using
%    multiple databases to be worked simultaneously. If dbid
%    omitted, the database automatically No one is used.

% Function calls:
%  mksqlite ('open', 'database file')
% or
%  mksqlite dbid = (0, 'open', 'database file')
% Opens the database file with the filename "database file". If a
% Such a file does not exist, create it.
% If one is specified dbid and this on an already opened
% Database relates, it will be concluded before command execution. At
% 0 is an indication of the dbid dbid returns the next available delivery.

%  mksqlite ('close')
% or
%  mksqlite (dbid, 'close')
% or
%  mksqlite (0, 'close')
% Closes a database file. Quoted dbid is the database
% closed. If you specify the dbid 0, all open databases
% closed.

%  mksqlite ('SQL command')
% or
%  mksqlite (dbid, 'SQL command')
% Executes SQL command.

% Example:
%  mksqlite ('open', 'testdb.db3');
%  mksqlite result = ('select * from test table');
%  mksqlite ('close');
% Reads all fields of the table "test table" in the database "testdb.db3"
% in the variable "result" one.

% Example:
%  mksqlite ('open', 'testdb.db3')
%  mksqlite ('show tables')
%  mksqlite ('close')
% Shows all tables in the database to testdb.db3.

% (C) 2008 by Martin Kortmann <mail@kortmann.de>
