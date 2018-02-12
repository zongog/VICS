DROP TABLE EA_tb
DROP TABLE CPA_tb
DROP TABLE Veteran_tb
DROP TABLE QnA_tb
DROP TABLE Questionnaire_tb;
DROP TABLE Questionnaire_Answer_tb;
DROP TABLE notice_tb;
DROP TABLE answer_tb

DROP SEQUENCE QnA_seq
DROP SEQUENCE Questionnaire_seq
DROP SEQUENCE Questionnaire_Answer_seq
DROP SEQUENCE Notice_seq
DROP SEQUENCE answer_seq

CREATE SEQUENCE QnA_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Questionnaire_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Questionnaire_Answer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Notice_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE EA_tb(
serial_number NUMBER PRIMARY KEY,
mail VARCHAR2(30),
pw VARCHAR2(20),
name VARCHAR2(40),
role VARCHAR2(10),
attachment VARCHAR2(4000),
permission VARCHAR2(10),
id VARCHAR2(2000)
);

CREATE TABLE CPA_tb(
serial_number NUMBER PRIMARY KEY,
mail VARCHAR2(30),
pw VARCHAR2(20),
name VARCHAR2(40),
role VARCHAR2(10),
attachment VARCHAR2(4000),
permission VARCHAR2(10),
id VARCHAR2(2000)
);

CREATE TABLE Veteran_tb(
serial_number NUMBER PRIMARY KEY,
mail VARCHAR2(30),
pw VARCHAR2(20),
name VARCHAR2(40),
role VARCHAR2(10),
attachment VARCHAR2(4000),
permission VARCHAR2(10),
id VARCHAR2(2000)
);

CREATE TABLE QnA_tb(
qna_id NUMBER PRIMARY KEY,
title VARCHAR2(300),
content VARCHAR2(4000),
qnadate date,
member VARCHAR2(10),
secret VARCHAR2(10),
attachment VARCHAR2(4000),
answer VARCHAR2(4000),
confirm VARCHAR2(10)
);

CREATE TABLE Questionnaire_tb(
version_id NUMBER,
version_title VARCHAR2(1000),
Q_number varchar2(100),
CONTENT VARCHAR2(4000),
doc varchar2(1000),
Constraint QUESTIONNAIRE_TB_PK Primary Key(version_id, Q_NUMBER)
);

CREATE TABLE Questionnaire_Answer_tb(
id NUMBER PRIMARY KEY,
version_id NUMBER,
Q_number VARCHAR2(100),
answer_list VARCHAR2(10)
);

CREATE TABLE Notice_tb(
id NUMBER PRIMARY KEY,
title VARCHAR2(300),
content VARCHAR2(4000),
hits int,
N_date date,
attachment VARCHAR2(4000)
);

CREATE TABLE answer_tb(
answer_id NUMBER PRIMARY KEY,
content VARCHAR2(100),
member VARCHAR2(100),
answer_date date,
qna_id int
);

CREATE SEQUENCE QnA_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Questionnaire_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Questionnaire_Answer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Notice_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE answer_seq START WITH 1 INCREMENT BY 1;




commit;