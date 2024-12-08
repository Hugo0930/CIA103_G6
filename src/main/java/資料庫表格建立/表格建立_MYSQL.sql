CREATE DATABASE IF NOT EXISTS voicebus;

use voicebus;

-- 清空並建立 cartlist 表
DROP TABLE IF EXISTS cartlist;
CREATE TABLE cartlist (
    memid INT NOT NULL,
    prodid INT NOT NULL,
    cartlistqty INT,
    PRIMARY KEY (memid, prodid)
);

-- 清空並建立 feature 表
DROP TABLE IF EXISTS feature;
CREATE TABLE feature (
    featureid INT NOT NULL AUTO_INCREMENT,
    featurename VARCHAR(100),
    description VARCHAR(255),
    PRIMARY KEY (featureid)
);

-- 清空並建立 orders 表
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    ordersid INT NOT NULL AUTO_INCREMENT,
    memid INT,
    ordersdate DATETIME,
    ordersamount INT,
    ordersshipfee INT,
    ordersadd VARCHAR(45),
    orderspaid INT,
    ordersmemo VARCHAR(45),
    ordersshipdate DATETIME,
    ordersstatus TINYINT,
    PRIMARY KEY (ordersid)
);

-- 清空並建立 ordersdetails 表
DROP TABLE IF EXISTS ordersdetails;
CREATE TABLE ordersdetails (
    ordersid INT NOT NULL,
    prodid INT NOT NULL,
    ordersqty INT,
    ordersunitprice INT,
    prodidstars INT,
    reportscontent VARCHAR(500),
    PRIMARY KEY (ordersid, prodid)
);

-- 清空並建立 permission 表
DROP TABLE IF EXISTS permission;
CREATE TABLE permission (
    featureid INT NOT NULL,
    adminid INT NOT NULL,
    PRIMARY KEY (featureid, adminid)
);

-- 清空並建立 reports 表
DROP TABLE IF EXISTS reports;
CREATE TABLE reports (
    repono VARCHAR(100) NOT NULL,
    memid INT,
    ordersid INT,
    prodid INT,
    reporeas VARCHAR(100),
    creartat DATETIME,
    repostatus TINYINT,
    PRIMARY KEY (repono)
);

-- 清空並建立 super 表
DROP TABLE IF EXISTS super;
CREATE TABLE super (
    adminid INT NOT NULL,
    email VARCHAR(100),
    status TINYINT,
    createdat DATETIME,
    updateat DATETIME,
    lastlogin DATETIME,
    phonenumber VARCHAR(20),
    PRIMARY KEY (adminid)
);
