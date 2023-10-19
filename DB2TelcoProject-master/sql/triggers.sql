DROP TRIGGER IF EXISTS `dbtest`.`orderwithopt`;
DROP TRIGGER IF EXISTS dbtest.noninsolvent;
DROP TRIGGER IF EXISTS dbtest.totalsaleupdate;
DROP TRIGGER IF EXISTS dbtest.orderwithoptupdate;
DROP TRIGGER IF EXISTS dbtest.totalsale;
DROP TRIGGER IF EXISTS dbtest.suspendedorders;
DROP TRIGGER IF EXISTS dbtest.suspendedordersupdate;
DROP TRIGGER IF EXISTS dbtest.newopt;
DROP TRIGGER IF EXISTS dbtest.bestseller;
DROP TRIGGER IF EXISTS dbtest.newpackaverage;
DROP TRIGGER IF EXISTS dbtest.averageopt;
DROP TRIGGER IF EXISTS dbtest.averageoptupdate;
DROP TRIGGER IF EXISTS dbtest.newpack;
DROP TRIGGER IF EXISTS dbtest.newpackopt;
DROP TRIGGER IF EXISTS dbtest.insolventuser;
DROP TRIGGER IF EXISTS dbtest.newalert;


DELIMITER $$
USE dbtest$$
CREATE DEFINER=CURRENT_USER TRIGGER `insolventuser` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
IF NEW.Insolvent = 1 THEN
	IF(New.UserId NOT IN (SELECT userid FROM insolventusers)) THEN
		INSERT INTO insolventusers (userid)
        VALUE (NEW.UserId);
	END IF;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER=CURRENT_USER TRIGGER `newpack` AFTER INSERT ON `packages` FOR EACH ROW BEGIN
insert into packagessold
values (NEW.Pkgid, 12, 0);
insert into packagessold
values (NEW.Pkgid, 24, 0);
insert into packagessold
values (NEW.Pkgid, 36, 0);
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER=CURRENT_USER TRIGGER `newpackopt` AFTER INSERT ON `packages` FOR EACH ROW BEGIN
INSERT INTO packagessoldwithopt
VALUES (New.PkgId, 0, 0);
INSERT INTO packagessoldwithopt
VALUES (NEW.PkgId, 1, 0);
END
$$
USE
DELIMITER $$
USE `dbtest`$$
CREATE DEFINER = CURRENT_USER TRIGGER `dbtest`.`orderwithopt` AFTER INSERT ON `orders` FOR EACH ROW
BEGIN
IF(New.Paid = true) THEN
IF New.HasOpt = true THEN
UPDATE dbtest.packagessoldwithopt
SET Sales = Sales + New.TotalValue
WHERE (PkgId = New.PkgId AND OptProduct = true);
ELSE
UPDATE dbtest.packagessoldwithopt
SET Sales = Sales + New.TotalValue
WHERE (PkgId = New.PkgId AND OptProduct = false);
END IF;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.noninsolvent AFTER UPDATE ON users FOR EACH ROW
BEGIN
IF(NEW.Insolvent = 0 AND OLD.Insolvent = 1) THEN
	DELETE FROM dbtest.insolventusers
    WHERE userid = NEW.UserID;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.totalsaleupdate AFTER UPDATE ON orders FOR EACH ROW
BEGIN
IF(New.Paid = 1 AND Old.Paid = 0) THEN
	UPDATE dbtest.packagessold
    SET Sales = Sales +1
    WHERE (PkgId = New.PkgId AND Period = New.ValidityPeriod);
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.orderwithoptupdate AFTER UPDATE ON orders FOR EACH ROW
BEGIN
IF(New.Paid = 1 AND Old.Paid = 0) THEN
	IF New.HasOpt = true THEN
    UPDATE dbtest.packagessoldwithopt
    SET Sales = Sales + NEW.TotalValue
    WHERE (PkgId = New.PkgId AND OptProduct = true);
    ELSE
    UPDATE dbtest.packagessoldwithopt
    SET Sales = Sales + NEW.TotalValue
    WHERE (PkgId = New.PkgId AND OptProduct = false);
    END IF;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER `totalsale` AFTER INSERT ON `orders` FOR EACH ROW 
BEGIN
IF (NEW.Paid = true) THEN
	UPDATE dbtest.packagessold
	SET Sales = Sales + 1
	WHERE PkgId = New.PkgId AND Period = New.ValidityPeriod;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.suspendedorders AFTER INSERT ON orders FOR EACH ROW
BEGIN
IF(New.Paid = 0) THEN
	INSERT INTO dbtest.suspendedorders
    VALUES (New.OrderId);
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.suspendedordersupdate AFTER UPDATE ON orders FOR EACH ROW
BEGIN
IF (NEW.Paid = 1 AND OLD.Paid = 0) THEN
	DELETE FROM dbtest.suspendedorders
    WHERE OrderId = New.OrderId;
END IF;
END
$$
DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.newopt AFTER INSERT ON optionalproducts FOR EACH ROW
BEGIN
INSERT INTO dbtest.optsales (OptProdId)
VALUES (NEW.ProdId);
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.bestseller AFTER INSERT ON selectedoptproducts FOR EACH ROW
BEGIN
IF((SELECT o.Paid FROM orders o WHERE NEW.OrderId = o.OrderId) = 1) THEN
	UPDATE dbtest.optsales
    SET TotalValue = TotalValue + (SELECT o.MonthlyFee FROM optionalproducts o WHERE NEW.OptProductId = o.ProdId)*(SELECT o.ValidityPeriod FROM orders o WHERE NEW.OrderId = o.OrderId)
    WHERE OptProdId = New.OptProductId;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.newpackaverage AFTER INSERT ON packages FOR EACH ROW
BEGIN
INSERT INTO averageoptperpkg
VALUES (NEW.PkgId, "0.00");
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.averageopt AFTER INSERT ON orders FOR EACH ROW
BEGIN
DECLARE packagessold INT;
SET packagessold = (SELECT sum(p.Sales) FROM packagessold p WHERE p.PkgId = New.PkgId);
IF(New.Paid = 1 AND New.HasOpt = true) THEN
	UPDATE averageoptperpkg
    SET Average = (Average*(packagessold-1)+NEW.OptNumber)/(packagessold)
    WHERE PkgId = New.PkgId;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.averageoptupdate AFTER UPDATE ON orders FOR EACH ROW
BEGIN
DECLARE packagessold INT;
SET packagessold = (SELECT sum(p.Sales) FROM packagessold p WHERE p.PkgId = New.PkgId);
IF(New.Paid = 1 AND New.HasOpt = true AND OLD.Paid = 0) THEN
	UPDATE averageoptperpkg
    SET Average = (Average*(packagessold-1)+NEW.OptNumber)/(packagessold)
    WHERE PkgId = New.PkgId;
END IF;
END
$$
DELIMITER $$
USE dbtest$$
CREATE DEFINER = CURRENT_USER TRIGGER dbtest.newalert AFTER UPDATE ON alerts FOR EACH ROW
BEGIN
INSERT INTO alerttrigger
VALUES (New.AlertId);
END
$$

 

