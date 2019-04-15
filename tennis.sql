DROP TABLE player CASCADE CONSTRAINTS;
DROP TABLE player_past_rank CASCADE CONSTRAINTS;
DROP TABLE player_stats CASCADE CONSTRAINTS;
DROP TABLE player_stats_score CASCADE CONSTRAINTS;
DROP TABLE season CASCADE CONSTRAINTS;
DROP TABLE school_team CASCADE CONSTRAINTS;
DROP TABLE team_stats CASCADE CONSTRAINTS;
DROP TABLE team_past_rank CASCADE CONSTRAINTS;
DROP TABLE staff CASCADE CONSTRAINTS;
DROP TABLE schedule CASCADE CONSTRAINTS;

CREATE TABLE player(
firstname VARCHAR(15) CONSTRAINT pl_fn_nn NOT NULL,
lastname  VARCHAR(15) constraint pl_ln_nn NOT NULL,
school    VARCHAR(30) CONSTRAINT pl_sc_nn NOT NULL,
weight    NUMBER(3),
height    NUMBER(3),
school_year NUMBER(1),
dominant_hand VARCHAR(1),
home_country VARCHAR(20),
team_name VARCHAR(40),
conference VARCHAR(20),
CONSTRAINT pl_pk PRIMARY KEY(firstname, lastname));

CREATE TABLE player_past_rank(
record_time VARCHAR(20) CONSTRAINT ppr_rt_pk PRIMARY KEY,
firstname VARCHAR (15) CONSTRAINT ppr_fn_nn NOT NULL,
lastname VARCHAR (15) CONSTRAINT ppr_ln_nn NOT NULL,
conference VARCHAR (20),
singles VARCHAR (10),
doubles VARCHAR (10));

CREATE TABLE player_stats(
stat_date DATE CONSTRAINT ps_dt_pk PRIMARY KEY,
firstname VARCHAR(20) CONSTRAINT ps_fn_nn NOT NULL,
lastname VARCHAR(20) CONSTRAINT ps_ln_nn NOT NULL,
overall_result VARCHAR(10),
results VARCHAR(10),
singles VARCHAR(10),
doubles VARCHAR(10));

CREATE TABLE player_stats_score(
stat_date DATE CONSTRAINT pss_dt_nn NOT NULL,
score VARCHAR(10) CONSTRAINT pss_sc_nn NOT NULL,
CONSTRAINT pss_pk PRIMARY KEY (stat_date, score));

CREATE TABLE season(
conference VARCHAR(20) CONSTRAINT sn_cf_pk PRIMARY KEY,
division VARCHAR(20),
gender CHAR(1),
yearinschool NUMBER(1));

CREATE TABLE school_team(
team_name VARCHAR(40) CONSTRAINT st_tn_pk PRIMARY KEY,
conference VARCHAR(20),
team_location VARCHAR(20),
mascot VARCHAR(10));

CREATE TABLE team_stats(
stat_date DATE CONSTRAINT ts_dt_pk PRIMARY KEY,
team_name VARCHAR(40) CONSTRAINT ts_tn_nn NOT NULL,
overall_result VARCHAR(10),
results VARCHAR(10),
team_position NUMBER(3),
scores VARCHAR(10));

CREATE TABLE team_past_rank(
record_time VARCHAR(20) CONSTRAINT tpr_rt_pk PRIMARY KEY,
team_name VARCHAR(40) CONSTRAINT tpr_tn_nn NOT NULL,
conference VARCHAR(20),
team_rank NUMBER(3)
);

CREATE TABLE staff(
firstname VARCHAR(15) CONSTRAINT st_fn_nn NOT NULL,
lastname  VARCHAR(15) constraint st_ln_nn NOT NULL,
team_name VARCHAR(40),
title VARCHAR(15),
email VARCHAR(25),
CONSTRAINT st_pk PRIMARY KEY(firstname, lastname));

CREATE TABLE schedule(
game_time VARCHAR(5) CONSTRAINT sl_tm_nn NOT NULL,
game_date DATE CONSTRAINT sl_dt_nn NOT NULL,
team_name VARCHAR(40),
opponent VARCHAR(40),
game_result VARCHAR(10),
CONSTRAINT sl_pk PRIMARY KEY (game_time, game_date));

ALTER TABLE player
ADD CONSTRAINT pl_tn_fk FOREIGN KEY (team_name) REFERENCES school_team (team_name);

ALTER TABLE player
ADD CONSTRAINT pl_cf_fk FOREIGN KEY (conference) REFERENCES season (conference);

ALTER TABLE player_past_rank
ADD CONSTRAINT ppr_fn_fk FOREIGN KEY (firstname, lastname) REFERENCES player (firstname, lastname);

ALTER TABLE player_stats
ADD CONSTRAINT ps_fn_fk FOREIGN KEY (firstname, lastname) REFERENCES player (firstname, lastname);

ALTER TABLE player_stats_score
ADD CONSTRAINT pss_dt_fk FOREIGN KEY (stat_date) REFERENCES player_stats (stat_date);

ALTER TABLE school_team
ADD CONSTRAINT st_cf_fk FOREIGN KEY (conference) REFERENCES season (conference);

ALTER TABLE staff
ADD CONSTRAINT sf_tn_fk FOREIGN KEY (team_name) REFERENCES school_team (team_name);

ALTER TABLE schedule
ADD CONSTRAINT sd_tn_fk FOREIGN KEY (team_name) REFERENCES school_team (team_name);

ALTER TABLE team_stats
ADD CONSTRAINT ts_tn_fk FOREIGN KEY (team_name) REFERENCES school_team (team_name);

ALTER TABLE team_past_rank
ADD CONSTRAINT tpr_tn_fk FOREIGN KEY (team_name) REFERENCES school_team (team_name);

ALTER TABLE team_past_rank
ADD CONSTRAINT tpr_cf_fk FOREIGN KEY (conference) REFERENCES season (conference);

