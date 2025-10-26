r"""Interface to sqlite commands"""
import sqlite3
from typing import List, Tuple
from collections import OrderedDict
import re
        
SQL_COLUMN_TYPES = ("INTEGER", "TEXT", "REAL")
SQL_COLUMN_PROPERTIES = OrderedDict({"NN": "NOT NULL", 
                                 "U": "UNIQUE", 
                                 "PK": "PRIMARY KEY",
                                 "AI": "AUTOINCREMENT"})


class SqlColumn(OrderedDict):
    r"""Ordered dictionnary representing a SQL column."""
    def __init__(self, colname:str, coltype:str, not_null=False, unique=False, primarykey=False, autoincrement=False):
        super().__init__()
        print(colname, coltype)
        self["name"] = re.sub(r"W", "", colname)
        if coltype not in SQL_COLUMN_TYPES:
            raise ValueError(f"coltype can only be: {SQL_COLUMN_TYPES}")
        self["type"] = coltype
        self["NN"] = not_null
        self["U"] = unique
        self["PK"] = primarykey
        self["AI"] = autoincrement

    def get_sql(self)->str:
        command = f"{self['name']} {self['type']}" 
        if self["NN"]:
            command += f" {SQL_COLUMN_PROPERTIES['NN']}"
        if self["U"]:
            command += f" {SQL_COLUMN_PROPERTIES['U']}"
        if self["PK"]:
            command += f" {SQL_COLUMN_PROPERTIES['PK']}"
        if self["AI"]:
            command += f" {SQL_COLUMN_PROPERTIES['AI']}"
        return command


class SqlCommands():
    r"""Class for generating SQL commands. See __init__.__doc__."""
    def __init__(self):
        r"""Class for generating SQL commands."""
        self._sql_types = ("INTEGER", "TEXT", "REAL")
        self._sql_col_prop = OrderedDict({"NN": "NOT NULL", 
                                 "U": "UNIQUE", 
                                 "PK": "PRIMARY KEY",
                                 "AI": "AUTOINCREMENT"})

    def _toggle_foreign_keys(self, flag: str):
        r"""Toggle foreign keys constraints."""
        command = f"PRAGMA foreign_keys={flag}"
        return command
    
    def fetch_table_info(self, name:str, prop:str=None)->str:
        r"""fetch table info."""
        if prop in ("cid", "name", "type", "notnull", "dflt_value", "pk"):
            col = prop
        else:
            col = "*"
        command = f"SELECT {col} FROM pragma_table_info(\'{name}\')"
        return command
    
    def enable_foreign_keys(self)->str:
        r"""Enable foreign keys constraint."""
        return self._toggle_foreign_keys(flag="ON")
    
    def disable_foreign_keys(self)->str:
        r"""Enable foreign keys constraint."""
        return self._toggle_foreign_keys(flag="OFF")

    def create_table(self, name:str, cols: Tuple[SqlColumn])->str:
        r"""Create new table."""
        command = f"CREATE TABLE IF NOT EXISTS {name} ("
        tmp = []
        for col in cols:
            tmp.append(f"{col.get_sql()}")
        command += ", ".join(tmp)
        command += ")"
        return command
    
    def delete_table(self, name:str)->str:
        r"""Delete table."""
        command = f"DROP TABLE IF EXISTS {name}"
        return command
    
    def add_column(self, name:str, col: SqlColumn):
        r"""Add a column to a table."""
        command = f"ALTER TABLE {name} ADD {col.get_sql()}"
        return command
    
    def del_column(self, name:str, colname: str):
        r"""Add a column to a table."""
        command = f"ALTER TABLE {name} DROP COLUMN {colname}"
        return command
    
    def insert(self, name:str, colname:str, value:str):
        r"""Insert row."""
        command = f"INSERT INTO {name} ({colname}) VALUES('{value}')"
        return command

    def update(self, name:str, col2modify:str, value:str, conditions: str):
        r"""Update row."""
        command = f"UPDATE {name} SET {col2modify} = {value} WHERE {conditions}"
        return command
    

if __name__ == "__main__":

    conn = sqlite3.Connection(":memory:")
    c = conn.cursor()

    sqlc = SqlCommands()

    cmd = sqlc.enable_foreign_keys()
    print(cmd)
    c.execute(cmd)
    conn.commit()

    c0 = SqlColumn("ID", "INTEGER")
    c1 = SqlColumn("Name", "TEXT", unique=True)
    c2 = SqlColumn("Comments", "TEXT")

    cmd = sqlc.create_table("newtable", (c0, c1))
    c.execute(cmd)
    conn.commit()

    cmd = sqlc.add_column("newtable", c2)
    c.execute(cmd)
    conn.commit()

    cmd = sqlc.fetch_table_info("newtable", prop="*")
    print(cmd)
    c.execute(cmd)
    conn.commit()
    print(c.fetchall())

    cmd = sqlc.del_column("newtable", "comments")
    c.execute(cmd)
    conn.commit()
    
    cmd = sqlc.insert("newtable", "Name", "Milan")
    print(cmd)
    c.execute(cmd)
    conn.commit()

    cmd = sqlc.delete_table(name="newtable")
    print(cmd)
    c.execute(cmd)
    conn.commit()

    conn.close()
