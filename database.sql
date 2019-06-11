CREATE TABLE IF NOT EXISTS hardware (
  id SERIAL PRIMARY KEY,
  provider TEXT NOT NULL,
  name TEXT NOT NULL);

INSERT INTO hardware(provider, name) VALUES ('Amazon', 'c5');
INSERT INTO hardware(provider, name) VALUES ('Azure', 'H16mr');
