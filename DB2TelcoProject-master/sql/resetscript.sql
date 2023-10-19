DELETE FROM `dbtest`.`alerts` WHERE (`AlertId`>4);
DELETE FROM `dbtest`.`selectedoptproducts` WHERE (`OrderId`>4);
DELETE FROM dbtest.suspendedorders WHERE OrderId >4;
DELETE FROM `dbtest`.`orders` WHERE (`OrderId` > '37');
UPDATE `dbtest`.`users` SET `FailedPayments` = '0' WHERE (`UserId` = '3' OR UserId = '1');
UPDATE `dbtest`.`users` SET `Insolvent` = '0' WHERE (`UserId` = '3' OR UserId = '1');
DELETE FROM `dbtest`.`optionalproducts` WHERE (`ProdId` >= '6');
DELETE FROM `dbtest`.`packagesprices` WHERE (`PackageId` >= '3');
DELETE FROM `dbtest`.`connectedproducts` WHERE (`PackageId` >= '3');
DELETE FROM `dbtest`.`packagessold` WHERE (`PkgId` > '3');
DELETE FROM `dbtest`.`packagessoldwithopt` WHERE (`PkgId` > '3');
DELETE FROM `dbtest`.`packages` WHERE (`Pkgid` >= '3');
DELETE FROM `dbtest`.`users` WHERE (`UserId` > '5');
UPDATE `dbtest`.`packagessold` SET `Sales` = '0' WHERE (`PkgId` >= '0');
UPDATE `dbtest`.`packagessold` SET `Sales` = '1' WHERE (`PkgId` = '2' AND `Period` = '12');
UPDATE dbtest.packagessoldwithopt SET Sales = '0' WHERE (PkgId >= '0');
UPDATE dbtest.packagessoldwithopt SET Sales = '1' WHERE (PkgId = '2' AND OptProduct = '1');

