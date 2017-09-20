echo "USAGE: export_old database user"

DATABASE=$1 # festverwaltung_v2_development
USER=$2 

mkdir csvs

PGPASSWORD=baum


psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM councils" > csvs/councils.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM notes" > csvs/notes.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM parties" > csvs/parties.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM people" > csvs/people.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM rights" > csvs/rights.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM section_managers" > csvs/section_managers.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT id,name,visible,text,party_id,created_at,updated_at FROM sections" > csvs/sections.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM shifts" > csvs/shifts.csv
psql -U $USER -h localhost  -d $DATABASE -P format=unaligned -P fieldsep=\, -c "SELECT * FROM statuses" > csvs/statuses.csv
