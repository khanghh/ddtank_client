package ddt.manager
{
   import cardCollectAward.data.AnswerInfo;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import road7th.comm.ByteSocket;
   import road7th.comm.PackageOut;
   import sanXiao.model.SXCellData;
   
   public class GameInSocketOut
   {
      
      private static var _socket:ByteSocket = SocketManager.Instance.socket;
       
      
      public function GameInSocketOut()
      {
         super();
      }
      
      public static function sendGodOfWealthPay() : void
      {
         var pkg:PackageOut = new PackageOut(341);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public static function sendGodOfWealthInfo() : void
      {
         var pkg:PackageOut = new PackageOut(341);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public static function sendSXCreateMap(map:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(1);
         pkg.writeInt(map.length / 3);
         for(i = 0; i < map.length; )
         {
            pkg.writeInt(map[i]);
            pkg.writeInt(map[i + 1]);
            pkg.writeInt(map[i + 2]);
            i = i + 3;
         }
         sendPackage(pkg);
      }
      
      public static function sendSXRequireMapInfo() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public static function sendSXPropCrossBomb(isBind:Boolean, needMoney:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(41);
         pkg.writeBoolean(isBind);
         pkg.writeInt(needMoney);
         sendPackage(pkg);
      }
      
      public static function sendSXPropSquareBomb(isBind:Boolean, needMoney:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(48);
         pkg.writeBoolean(isBind);
         pkg.writeInt(needMoney);
         sendPackage(pkg);
      }
      
      public static function sendSXPropClearColor(isBind:Boolean, needMoney:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(49);
         pkg.writeBoolean(isBind);
         pkg.writeInt(needMoney);
         sendPackage(pkg);
      }
      
      public static function sendSXPropChangeColor(isBind:Boolean, needMoney:int, originalType:int, changeToType:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(50);
         pkg.writeBoolean(isBind);
         pkg.writeInt(needMoney);
         pkg.writeInt(originalType);
         pkg.writeInt(changeToType);
         sendPackage(pkg);
      }
      
      public static function sendSXBoom(rowA:int, columnA:int, rowB:int, columnB:int, boomList:Array) : void
      {
         var lenType:int = 0;
         var i:int = 0;
         var typeList:* = null;
         var len:int = 0;
         var j:int = 0;
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(3);
         pkg.writeInt(rowA);
         pkg.writeInt(columnA);
         pkg.writeInt(rowB);
         pkg.writeInt(columnB);
         lenType = boomList.length;
         pkg.writeInt(lenType);
         for(i = 0; i < lenType; )
         {
            typeList = boomList[i];
            len = (typeList as Array).length;
            pkg.writeInt(int(len / 2));
            for(j = 0; j < len; )
            {
               pkg.writeInt(typeList[j]);
               pkg.writeInt(typeList[j + 1]);
               j = j + 2;
            }
            i++;
         }
         sendPackage(pkg);
      }
      
      public static function sendSXFillCellList($list:Vector.<SXCellData>) : void
      {
         var i:int = 0;
         if($list == null)
         {
            return;
         }
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(4);
         var len:int = $list.length;
         pkg.writeInt(len);
         for(i = 0; i < len; )
         {
            pkg.writeInt($list[i].row);
            pkg.writeInt($list[i].column);
            pkg.writeInt($list[i].type);
            i++;
         }
         sendPackage(pkg);
      }
      
      public static function sendSXRequireViewData() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public static function sendSXGainPrise(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(7);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public static function sendSXBuyItem(id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(8);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public static function sendSXHitsEnd() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public static function sendSXBuyOneTimes(times:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(15);
         pkg.writeInt(times);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public static function sendSXRewardsData() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(17);
         sendPackage(pkg);
      }
      
      public static function sendSXStoreData() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(18);
         sendPackage(pkg);
      }
      
      public static function sendGradeBuy(typeTempleteID:int, giftTempleteID:int) : void
      {
         var pkg:PackageOut = new PackageOut(325);
         pkg.writeInt(typeTempleteID);
         pkg.writeInt(giftTempleteID);
         sendPackage(pkg);
      }
      
      public static function sendEvolutionMaterials(arr:Array) : void
      {
         var obj:* = null;
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(384);
         var len:int = arr.length;
         pkg.writeInt(len);
         for(i = 0; i < len; )
         {
            obj = arr[i] as Object;
            pkg.writeInt(obj.bagType);
            pkg.writeInt(obj.place);
            pkg.writeInt(obj.count);
            i++;
         }
         sendPackage(pkg);
      }
      
      public static function sendIsMaster() : void
      {
         var pkg:PackageOut = new PackageOut(323);
         sendPackage(pkg);
      }
      
      public static function sendDdtKingLetterCompose() : void
      {
         var pkg:PackageOut = new PackageOut(322);
         sendPackage(pkg);
      }
      
      public static function sendBringUpLockStatusUpdate(bagType:int, place:int, isLocked:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(313);
         pkg.writeInt(bagType);
         pkg.writeInt(place);
         pkg.writeBoolean(isLocked);
         sendPackage(pkg);
      }
      
      public static function sendBringUpEat(count:int, ... arg) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(308);
         pkg.writeInt(count);
         if(count > 0)
         {
            arg = arg[0];
            for(i = 0; i < count; )
            {
               pkg.writeInt(arg.shift());
               pkg.writeInt(arg.shift());
               i++;
            }
         }
         else
         {
            pkg.writeInt(arg.shift());
            pkg.writeInt(arg.shift());
         }
         sendPackage(pkg);
      }
      
      public static function sendUseGirlNewPhoto($isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(339);
         pkg.writeBoolean($isBind);
         sendPackage(pkg);
      }
      
      public static function sendUseGirlPhoto(isUse:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(307);
         pkg.writeBoolean(isUse);
         sendPackage(pkg);
      }
      
      public static function sendRedPkgGain(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(303);
         pkg.writeByte(1);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public static function sendRedPkgSend(moneyNum:int, pkgNum:int, wishWords:String, isAverage:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(303);
         pkg.writeByte(2);
         pkg.writeInt(moneyNum);
         pkg.writeInt(pkgNum);
         pkg.writeUTF(wishWords);
         pkg.writeInt(isAverage == true?1:0);
         sendPackage(pkg);
      }
      
      public static function sendRedPkgSendRecord() : void
      {
         var pkg:PackageOut = new PackageOut(303);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public static function sendRedPkgGainRecord(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(303);
         pkg.writeByte(4);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public static function sendRequestEnterPyramidSystem() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public static function sendPyramidTurnCard(layer:int, position:int, bindFlag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(3);
         pkg.writeInt(layer);
         pkg.writeInt(position);
         pkg.writeBoolean(bindFlag);
         sendPackage(pkg);
      }
      
      public static function sendPyramidStartOrstop(isStart:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(2);
         pkg.writeBoolean(isStart);
         sendPackage(pkg);
      }
      
      public static function sendPyramidRevive(isRevive:Boolean, bindFlag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(4);
         pkg.writeBoolean(isRevive);
         pkg.writeBoolean(bindFlag);
         sendPackage(pkg);
      }
      
      public static function sendLanternIsOpen() : void
      {
         var pkg:PackageOut = new PackageOut(300);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public static function sendLanternRequireData() : void
      {
         var pkg:PackageOut = new PackageOut(300);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public static function sendLanternMakeLantern(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(300);
         pkg.writeByte(2);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public static function sendLanternCookLantern(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(300);
         pkg.writeByte(3);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public static function sendLanternWish(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(300);
         pkg.writeByte(5);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public static function sendLanternGainWishGift() : void
      {
         var pkg:PackageOut = new PackageOut(300);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public static function sendMaxBtnState(isPackUp:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(538);
         pkg.writeByte(2);
         pkg.writeBoolean(isPackUp);
         sendPackage(pkg);
      }
      
      public static function sendRequireMaxBtnState() : void
      {
         var pkg:PackageOut = new PackageOut(538);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public static function sendWorshipTheMoon(counts:int, isBindTickets:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(281);
         pkg.writeByte(3);
         pkg.writeInt(counts);
         pkg.writeBoolean(isBindTickets);
         sendPackage(pkg);
      }
      
      public static function sendWorshipTheMoonIsActivityOpen() : void
      {
         var pkg:PackageOut = new PackageOut(281);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public static function sendBagLockStates(stateData:ByteArray = null) : void
      {
         var pkg:PackageOut = new PackageOut(25);
         pkg.writeByte(2);
         if(stateData == null)
         {
            pkg.writeByte(0);
         }
         else
         {
            pkg.writeByte(1);
            pkg.writeBytes(stateData);
         }
         sendPackage(pkg);
      }
      
      public static function sendWorshipTheMoonFreeCount() : void
      {
         var pkg:PackageOut = new PackageOut(281);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public static function sendWorshipTheMoonAwardsList() : void
      {
         var pkg:PackageOut = new PackageOut(281);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public static function sendGainThe200timesAwardBox() : void
      {
         var pkg:PackageOut = new PackageOut(281);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public static function sendGypsyBuy(id:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(278);
         pkg.writeByte(3);
         pkg.writeInt(id);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public static function sendGypsyRefreshItemList() : void
      {
         var pkg:PackageOut = new PackageOut(278);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public static function sendGypsyManualRefreshItemList() : void
      {
         var pkg:PackageOut = new PackageOut(278);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public static function sendGypsyManualRefreshItemListWithRMB(isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(278);
         pkg.writeByte(6);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public static function sendGypsyRefreshRareList() : void
      {
         var pkg:PackageOut = new PackageOut(278);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public static function sendRequestGypsyNPCState() : void
      {
         var pkg:PackageOut = new PackageOut(278);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public static function sendGetScenePlayer(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(69);
         pkg.writeByte(index);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public static function sendInviteGame(playerid:int) : void
      {
         var pkg:PackageOut = new PackageOut(70);
         pkg.writeInt(playerid);
         sendPackage(pkg);
      }
      
      public static function sendBuyProp(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(54);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public static function sendSellProp(id:int, GoodsID:int) : void
      {
         var pkg:PackageOut = new PackageOut(55);
         pkg.writeInt(id);
         pkg.writeInt(GoodsID);
         sendPackage(pkg);
      }
      
      public static function sendGameRoomSetUp(id:int, type:int, isOpenBoss:Boolean = false, pass:String = "", name:String = "", secondType:int = 2, permission:int = 0, levelLimits:int = 0, allowCrossZone:Boolean = false, tempID:int = 0, isBand:Boolean = false, gameType:int = 0) : void
      {
         var secType:int = PlayerManager.Instance.Self.Grade < 5?4:secondType;
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(2);
         pkg.writeInt(id);
         pkg.writeByte(type);
         pkg.writeBoolean(isOpenBoss);
         pkg.writeUTF(pass);
         pkg.writeUTF(name);
         pkg.writeByte(secType);
         pkg.writeByte(permission);
         pkg.writeInt(levelLimits);
         pkg.writeBoolean(allowCrossZone);
         pkg.writeInt(tempID);
         pkg.writeInt(gameType);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public static function sendCreateRoom(name:String, roomType:int, timeType:int = 2, pass:String = "", isDouble:Boolean = false) : void
      {
         var secType:int = PlayerManager.Instance.Self.Grade < 5?4:timeType;
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(0);
         pkg.writeByte(roomType);
         pkg.writeByte(secType);
         pkg.writeUTF(name);
         pkg.writeUTF(pass);
         pkg.writeBoolean(isDouble);
         sendPackage(pkg);
      }
      
      public static function sendGameRoomPlaceState(index:int, isOpened:int, toNewPlace:Boolean = false, _newPlace:int = -100) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(10);
         pkg.writeByte(index);
         pkg.writeInt(isOpened);
         pkg.writeBoolean(toNewPlace);
         pkg.writeInt(_newPlace);
         sendPackage(pkg);
      }
      
      public static function sendGameRoomKick(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(3);
         pkg.writeByte(index);
         sendPackage(pkg);
      }
      
      public static function sendExitScene() : void
      {
         var pkg:PackageOut = new PackageOut(21);
         sendPackage(pkg);
      }
      
      public static function sendGamePlayerExit() : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(5);
         sendPackage(pkg);
      }
      
      public static function sendGameTeam(team:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(6);
         pkg.writeByte(team);
         sendPackage(pkg);
      }
      
      public static function sendFlagMode(flag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(97);
         pkg.writeBoolean(flag);
         sendPackage(pkg);
      }
      
      public static function sendGameStart() : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(7);
         sendPackage(pkg);
      }
      
      public static function sendGameMissionStart(isStart:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(82);
         pkg.writeBoolean(isStart);
         sendPackage(pkg);
      }
      
      public static function sendGameMissionPrepare(place:int, isRead:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(116);
         pkg.writeBoolean(isRead);
         sendPackage(pkg);
      }
      
      public static function sendLoadingProgress(progress:Number) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(16);
         pkg.writeInt(progress);
         sendPackage(pkg);
      }
      
      public static function sendPlayerState(ready:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(15);
         pkg.writeByte(ready);
         sendPackage(pkg);
      }
      
      public static function sendStartOrPreCheckEnergy() : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(20);
         sendPackage(pkg);
      }
      
      public static function sendGameCMDBlast(id:int, x:int, y:int, t:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(3);
         pkg.writeInt(id);
         pkg.writeInt(x);
         pkg.writeInt(y);
         pkg.writeInt(t);
         sendPackage(pkg);
      }
      
      public static function sendGameCMDChange(id:int, bombPosX:int, bombPosY:int, vx:int, vy:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(19);
         pkg.writeInt(id);
         pkg.writeInt(bombPosX);
         pkg.writeInt(bombPosY);
         pkg.writeInt(vx);
         pkg.writeInt(vy);
         sendPackage(pkg);
      }
      
      public static function sendGameCMDDirection(direction:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(7);
         pkg.writeInt(direction);
         sendPackage(pkg);
      }
      
      public static function sendGameCMDStunt(skillId:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(15);
         pkg.writeByte(skillId);
         sendPackage(pkg);
      }
      
      public static function sendGameCMDShoot(x:int, y:int, force:int, angle:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(2);
         pkg.writeInt(int(x));
         pkg.writeInt(int(y));
         pkg.writeInt(int(force));
         pkg.writeInt(int(angle));
         sendPackage(pkg);
      }
      
      public static function sendGameSkipNext(time:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(12);
         pkg.writeByte(time);
         sendPackage(pkg);
      }
      
      public static function sendTransmissionGate(value:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(137);
         pkg.writeBoolean(value);
         sendPackage(pkg);
      }
      
      public static function sendGameStartMove(type:Number, x:int, y:int, dir:Number, isLiving:Boolean, turnIndex:Number) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(9);
         pkg.writeBoolean(true);
         pkg.writeByte(type);
         pkg.writeInt(x);
         pkg.writeInt(y);
         pkg.writeByte(dir);
         pkg.writeBoolean(isLiving);
         pkg.writeShort(turnIndex);
         sendPackage(pkg);
      }
      
      public static function sendGameStopMove(posX:int, posY:int, isUser:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(10);
         pkg.writeInt(posX);
         pkg.writeInt(posY);
         pkg.writeBoolean(isUser);
         sendPackage(pkg);
      }
      
      public static function sendGameTakeOut(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(98);
         pkg.writeByte(place);
         sendPackage(pkg);
      }
      
      public static function sendBossTakeOut(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(130);
         pkg.writeByte(place);
         sendPackage(pkg);
      }
      
      public static function sendGetTropToBag(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(108);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public static function sendShootTag(b:Boolean, time:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(96);
         pkg.writeBoolean(b);
         if(b)
         {
            pkg.writeByte(time);
         }
         sendPackage(pkg);
      }
      
      public static function sendBeat(x:Number, y:Number, angle:Number) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(22);
         pkg.writeShort(x);
         pkg.writeShort(y);
         pkg.writeShort(angle);
         sendPackage(pkg);
      }
      
      public static function sendThrowProp(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(75);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public static function sendUseProp(type:int, place:int, tempid:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(32);
         pkg.writeByte(type);
         pkg.writeInt(place);
         pkg.writeInt(tempid);
         sendPackage(pkg);
      }
      
      public static function sendCancelWait() : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(11);
         sendPackage(pkg);
      }
      
      public static function sendSingleRoomBegin(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(18);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public static function sendGameStyle(style:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(12);
         pkg.writeInt(style);
         sendPackage(pkg);
      }
      
      public static function sendGhostTarget(pos:Point) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(54);
         pkg.writeInt(pos.x);
         pkg.writeInt(pos.y);
         sendPackage(pkg);
      }
      
      public static function sendPaymentTakeCard(place:int, bool:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(114);
         pkg.writeByte(place);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public static function sendMissionTryAgain(tryAgain:int, isHost:Boolean, bool:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(119);
         pkg.writeInt(tryAgain);
         pkg.writeBoolean(isHost);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public static function sendFightLibInfoChange(id:int, difficult:int = -1) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(-1);
         pkg.writeInt(id);
         pkg.writeInt(difficult);
         sendPackage(pkg);
      }
      
      public static function sendPassStory() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(133);
         pkg.writeBoolean(true);
         sendPackage(pkg);
      }
      
      public static function sendClientScriptStart() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(23);
         pkg.writeInt(3);
         sendPackage(pkg);
      }
      
      public static function sendClientScriptEnd() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(23);
         pkg.writeInt(2);
         sendPackage(pkg);
      }
      
      public static function sendFightLibAnswer(questionID:int, answerID:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(23);
         pkg.writeInt(4);
         pkg.writeInt(questionID);
         pkg.writeInt(answerID);
         sendPackage(pkg);
      }
      
      public static function sendFightLibReanswer() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(23);
         pkg.writeInt(5);
         sendPackage(pkg);
      }
      
      public static function sendUpdatePlayStep(cmd:String) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(25);
         pkg.writeInt(6);
         pkg.writeUTF(cmd);
         sendPackage(pkg);
      }
      
      public static function sendGodCardInfoAttribute() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(20);
         sendPackage(pkg);
      }
      
      public static function sendGodCardOpenCard(type:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(21);
         pkg.writeInt(type);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public static function sendGodCardOperateCard(type:int, id:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(22);
         pkg.writeInt(type);
         pkg.writeInt(id);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public static function sendGodCardExchange(id:int, useGodCard:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(23);
         pkg.writeInt(id);
         pkg.writeBoolean(useGodCard);
         sendPackage(pkg);
      }
      
      public static function sendGodCardPointAwardAttribute(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(24);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public static function sendSelectObject(id:int, zoneID:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(138);
         pkg.writeInt(id);
         pkg.writeInt(zoneID);
         sendPackage(pkg);
      }
      
      public static function sendGetActivePveInfo() : void
      {
         var pkg:PackageOut = new PackageOut(342);
         sendPackage(pkg);
      }
      
      public static function sendMoneyTreeSpeedUp(position:int, times:int, bind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(296);
         pkg.writeByte(2);
         pkg.writeInt(position);
         pkg.writeInt(times);
         pkg.writeBoolean(bind);
         sendPackage(pkg);
      }
      
      public static function sendMoneyTreeSendRedPackage(sendList:Array) : void
      {
         var i:int = 0;
         var endIndex:int = 0;
         var tempList:* = null;
         var pkg:* = null;
         var len:int = sendList.length;
         var step:int = 80;
         for(i = 0; i < len; )
         {
            endIndex = Math.min(len,i + step);
            tempList = sendList.slice(i,endIndex);
            pkg = new PackageOut(296);
            pkg.writeByte(3);
            pkg.writeInt(tempList.length);
            var _loc10_:int = 0;
            var _loc9_:* = tempList;
            for each(var id in tempList)
            {
               pkg.writeInt(id);
            }
            sendPackage(pkg);
            i = i + step;
         }
      }
      
      public static function sendMoneyTreePick(position:int) : void
      {
         var pkg:PackageOut = new PackageOut(296);
         pkg.writeByte(4);
         pkg.writeInt(position);
         sendPackage(pkg);
      }
      
      public static function sendMoneyTreeRequireInfo() : void
      {
         var pkg:PackageOut = new PackageOut(296);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public static function sendOrdinaryFB(flag:Boolean, double:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(17);
         pkg.writeBoolean(flag);
         pkg.writeBoolean(double);
         sendPackage(pkg);
      }
      
      public static function sendKingDivisionGameStart(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(328);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public static function sendGetConsortionMessageThisZone() : void
      {
         var pkg:PackageOut = new PackageOut(328);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public static function sendGetConsortionMessageAllZone() : void
      {
         var pkg:PackageOut = new PackageOut(328);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public static function sendGetEliminateConsortionMessageThisZone() : void
      {
         var pkg:PackageOut = new PackageOut(328);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public static function sendGetEliminateConsortionMessageAllZone() : void
      {
         var pkg:PackageOut = new PackageOut(328);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public static function sendDiceRefreshData() : void
      {
         var pkg:PackageOut = new PackageOut(134);
         pkg.writeByte(12);
         sendPackage(pkg);
      }
      
      public static function sendStartDiceInfo(type:int, position:int) : void
      {
         var pkg:PackageOut = new PackageOut(134);
         pkg.writeByte(11);
         pkg.writeInt(type);
         pkg.writeInt(position);
         sendPackage(pkg);
      }
      
      public static function sendRequestEnterDiceSystem() : void
      {
         var pkg:PackageOut = new PackageOut(134);
         pkg.writeByte(10);
         sendPackage(pkg);
      }
      
      public static function sendGetBattleSkillInfo() : void
      {
         var pkg:PackageOut = new PackageOut(132);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public static function sendUpdateBattleSkill(skillId:int) : void
      {
         var pkg:PackageOut = new PackageOut(132);
         pkg.writeByte(6);
         pkg.writeInt(skillId);
         sendPackage(pkg);
      }
      
      public static function sendBringBattleSkill(skillID:int, skillPlace:int) : void
      {
         var pkg:PackageOut = new PackageOut(132);
         pkg.writeByte(7);
         pkg.writeInt(skillID);
         pkg.writeInt(skillPlace);
         sendPackage(pkg);
      }
      
      public static function sendGetFriendPack(name:String, content:String, bagType:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(358);
         pkg.writeUTF(name);
         pkg.writeUTF(content);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeBoolean(true);
         sendPackage(pkg);
      }
      
      public static function sendQuestionAnswer(info:AnswerInfo) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(56);
         pkg.writeUTF(info.answer);
         pkg.writeUTF(info.qq);
         pkg.writeUTF(info.phone);
         pkg.writeUTF(info.suggest);
         sendPackage(pkg);
      }
      
      public static function sendGoldmineInfoAttribute() : void
      {
         var pkg:PackageOut = new PackageOut(624);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public static function sendGoldmineUse() : void
      {
         var pkg:PackageOut = new PackageOut(624);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public static function sendChangeRoomHost(roomHostID:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(23);
         pkg.writeInt(roomHostID);
         sendPackage(pkg);
      }
      
      private static function sendPackage(pkg:PackageOut) : void
      {
         _socket.send(pkg);
      }
      
      public static function sendCalendarPet() : void
      {
         var pkg:PackageOut = new PackageOut(13);
         pkg.writeInt(11);
         sendPackage(pkg);
      }
   }
}
