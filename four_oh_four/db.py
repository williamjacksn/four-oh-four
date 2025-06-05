import datetime
import fort
import four_oh_four.settings

from typing import Dict, List


class Database(fort.PostgresDatabase):
    _version: int = None

    def __init__(self, settings: four_oh_four.settings.Settings):
        super().__init__(settings.db)
        self.settings = settings

    def add_href(self, href: str):
        sql = "insert into hrefs (recorded_at, href) values (now(), %(href)s)"
        params = {"href": href}
        self.u(sql, params)

    def get_hrefs(self) -> List[Dict]:
        sql = "select href, count(*) total from hrefs group by href order by total desc"
        return self.q(sql)

    def add_schema_version(self, schema_version: int):
        self._version = schema_version
        sql = """
            insert into schema_versions (schema_version, migration_timestamp)
            values (%(schema_version)s, %(migration_timestamp)s)
        """
        params = {
            "migration_timestamp": datetime.datetime.utcnow(),
            "schema_version": schema_version,
        }
        self.u(sql, params)

    def migrate(self):
        self.log.info(f"Database schema version is {self.version}")
        if self.version < 1:
            self.log.info("Migrating database to schema version 1")
            self.u("""
                create table schema_versions (
                    schema_version integer primary key,
                    migration_timestamp timestamp
                )
            """)
            self.u("""
                create table hrefs (
                    recorded_at timestamp,
                    href text
                )
            """)
            self.add_schema_version(1)

    def _table_exists(self, table_name: str) -> bool:
        sql = "select count(*) table_count from information_schema.tables where table_name = %(table_name)s"
        params = {"table_name": table_name}
        for r in self.q(sql, params):
            if r["table_count"] == 0:
                return False
        return True

    @property
    def version(self) -> int:
        if self._version is None:
            self._version = 0
            if self._table_exists("schema_versions"):
                sql = "select max(schema_version) current_version from schema_versions"
                current_version: int = self.q_val(sql)
                if current_version is not None:
                    self._version = current_version
        return self._version
