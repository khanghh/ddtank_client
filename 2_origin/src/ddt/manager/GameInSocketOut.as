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
         var _loc1_:PackageOut = new PackageOut(341);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public static function sendGodOfWealthInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(341);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public static function sendSXCreateMap(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1.length / 3);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeInt(param1[_loc3_]);
            _loc2_.writeInt(param1[_loc3_ + 1]);
            _loc2_.writeInt(param1[_loc3_ + 2]);
            _loc3_ = _loc3_ + 3;
         }
         sendPackage(_loc2_);
      }
      
      public static function sendSXRequireMapInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public static function sendSXPropCrossBomb(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(41);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendSXPropSquareBomb(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(48);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendSXPropClearColor(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(49);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendSXPropChangeColor(param1:Boolean, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(329);
         _loc5_.writeByte(50);
         _loc5_.writeBoolean(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public static function sendSXBoom(param1:int, param2:int, param3:int, param4:int, param5:Array) : void
      {
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:PackageOut = new PackageOut(329);
         _loc7_.writeByte(3);
         _loc7_.writeInt(param1);
         _loc7_.writeInt(param2);
         _loc7_.writeInt(param3);
         _loc7_.writeInt(param4);
         _loc6_ = param5.length;
         _loc7_.writeInt(_loc6_);
         _loc11_ = 0;
         while(_loc11_ < _loc6_)
         {
            _loc10_ = param5[_loc11_];
            _loc8_ = (_loc10_ as Array).length;
            _loc7_.writeInt(int(_loc8_ / 2));
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc7_.writeInt(_loc10_[_loc9_]);
               _loc7_.writeInt(_loc10_[_loc9_ + 1]);
               _loc9_ = _loc9_ + 2;
            }
            _loc11_++;
         }
         sendPackage(_loc7_);
      }
      
      public static function sendSXFillCellList(param1:Vector.<SXCellData>) : void
      {
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(4);
         var _loc3_:int = param1.length;
         _loc2_.writeInt(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.writeInt(param1[_loc4_].row);
            _loc2_.writeInt(param1[_loc4_].column);
            _loc2_.writeInt(param1[_loc4_].type);
            _loc4_++;
         }
         sendPackage(_loc2_);
      }
      
      public static function sendSXRequireViewData() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public static function sendSXGainPrise(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendSXBuyItem(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(8);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendSXHitsEnd() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public static function sendSXBuyOneTimes(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(15);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendSXRewardsData() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(17);
         sendPackage(_loc1_);
      }
      
      public static function sendSXStoreData() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(18);
         sendPackage(_loc1_);
      }
      
      public static function sendGradeBuy(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(325);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendEvolutionMaterials(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc2_:PackageOut = new PackageOut(384);
         var _loc4_:int = param1.length;
         _loc2_.writeInt(_loc4_);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1[_loc5_] as Object;
            _loc2_.writeInt(_loc3_.bagType);
            _loc2_.writeInt(_loc3_.place);
            _loc2_.writeInt(_loc3_.count);
            _loc5_++;
         }
         sendPackage(_loc2_);
      }
      
      public static function sendIsMaster() : void
      {
         var _loc1_:PackageOut = new PackageOut(323);
         sendPackage(_loc1_);
      }
      
      public static function sendDdtKingLetterCompose() : void
      {
         var _loc1_:PackageOut = new PackageOut(322);
         sendPackage(_loc1_);
      }
      
      public static function sendBringUpLockStatusUpdate(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(313);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendBringUpEat(param1:int, ... rest) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageOut = new PackageOut(308);
         _loc3_.writeInt(param1);
         if(param1 > 0)
         {
            rest = rest[0];
            _loc4_ = 0;
            while(_loc4_ < param1)
            {
               _loc3_.writeInt(rest.shift());
               _loc3_.writeInt(rest.shift());
               _loc4_++;
            }
         }
         else
         {
            _loc3_.writeInt(rest.shift());
            _loc3_.writeInt(rest.shift());
         }
         sendPackage(_loc3_);
      }
      
      public static function sendUseGirlNewPhoto(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(339);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendUseGirlPhoto(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(307);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendRedPkgGain(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(303);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendRedPkgSend(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(303);
         _loc5_.writeByte(2);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeUTF(param3);
         _loc5_.writeInt(param4 == true?1:0);
         sendPackage(_loc5_);
      }
      
      public static function sendRedPkgSendRecord() : void
      {
         var _loc1_:PackageOut = new PackageOut(303);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public static function sendRedPkgGainRecord(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(303);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendRequestEnterPyramidSystem() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public static function sendPyramidTurnCard(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(3);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendPyramidStartOrstop(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(2);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendPyramidRevive(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(4);
         _loc3_.writeBoolean(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendLanternIsOpen() : void
      {
         var _loc1_:PackageOut = new PackageOut(300);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public static function sendLanternRequireData() : void
      {
         var _loc1_:PackageOut = new PackageOut(300);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public static function sendLanternMakeLantern(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(300);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendLanternCookLantern(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(300);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendLanternWish(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(300);
         _loc2_.writeByte(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendLanternGainWishGift() : void
      {
         var _loc1_:PackageOut = new PackageOut(300);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public static function sendMaxBtnState(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(538);
         _loc2_.writeByte(2);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendRequireMaxBtnState() : void
      {
         var _loc1_:PackageOut = new PackageOut(538);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public static function sendWorshipTheMoon(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(281);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendWorshipTheMoonIsActivityOpen() : void
      {
         var _loc1_:PackageOut = new PackageOut(281);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public static function sendBagLockStates(param1:ByteArray = null) : void
      {
         var _loc2_:PackageOut = new PackageOut(25);
         _loc2_.writeByte(2);
         if(param1 == null)
         {
            _loc2_.writeByte(0);
         }
         else
         {
            _loc2_.writeByte(1);
            _loc2_.writeBytes(param1);
         }
         sendPackage(_loc2_);
      }
      
      public static function sendWorshipTheMoonFreeCount() : void
      {
         var _loc1_:PackageOut = new PackageOut(281);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public static function sendWorshipTheMoonAwardsList() : void
      {
         var _loc1_:PackageOut = new PackageOut(281);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public static function sendGainThe200timesAwardBox() : void
      {
         var _loc1_:PackageOut = new PackageOut(281);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public static function sendGypsyBuy(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(278);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendGypsyRefreshItemList() : void
      {
         var _loc1_:PackageOut = new PackageOut(278);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public static function sendGypsyManualRefreshItemList() : void
      {
         var _loc1_:PackageOut = new PackageOut(278);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public static function sendGypsyManualRefreshItemListWithRMB(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(278);
         _loc2_.writeByte(6);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGypsyRefreshRareList() : void
      {
         var _loc1_:PackageOut = new PackageOut(278);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public static function sendRequestGypsyNPCState() : void
      {
         var _loc1_:PackageOut = new PackageOut(278);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public static function sendGetScenePlayer(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(69);
         _loc2_.writeByte(param1);
         _loc2_.writeByte(6);
         sendPackage(_loc2_);
      }
      
      public static function sendInviteGame(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(70);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendBuyProp(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(54);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendSellProp(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(55);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendGameRoomSetUp(param1:int, param2:int, param3:Boolean = false, param4:String = "", param5:String = "", param6:int = 2, param7:int = 0, param8:int = 0, param9:Boolean = false, param10:int = 0, param11:Boolean = false, param12:int = 0) : void
      {
         var _loc14_:int = PlayerManager.Instance.Self.Grade < 5?4:param6;
         var _loc13_:PackageOut = new PackageOut(94);
         _loc13_.writeInt(2);
         _loc13_.writeInt(param1);
         _loc13_.writeByte(param2);
         _loc13_.writeBoolean(param3);
         _loc13_.writeUTF(param4);
         _loc13_.writeUTF(param5);
         _loc13_.writeByte(_loc14_);
         _loc13_.writeByte(param7);
         _loc13_.writeInt(param8);
         _loc13_.writeBoolean(param9);
         _loc13_.writeInt(param10);
         _loc13_.writeInt(param12);
         _loc13_.writeBoolean(param11);
         sendPackage(_loc13_);
      }
      
      public static function sendCreateRoom(param1:String, param2:int, param3:int = 2, param4:String = "", param5:Boolean = false) : void
      {
         var _loc6_:int = PlayerManager.Instance.Self.Grade < 5?4:param3;
         var _loc7_:PackageOut = new PackageOut(94);
         _loc7_.writeInt(0);
         _loc7_.writeByte(param2);
         _loc7_.writeByte(_loc6_);
         _loc7_.writeUTF(param1);
         _loc7_.writeUTF(param4);
         _loc7_.writeBoolean(param5);
         sendPackage(_loc7_);
      }
      
      public static function sendGameRoomPlaceState(param1:int, param2:int, param3:Boolean = false, param4:int = -100) : void
      {
         var _loc5_:PackageOut = new PackageOut(94);
         _loc5_.writeInt(10);
         _loc5_.writeByte(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeBoolean(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public static function sendGameRoomKick(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(3);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendExitScene() : void
      {
         var _loc1_:PackageOut = new PackageOut(21);
         sendPackage(_loc1_);
      }
      
      public static function sendGamePlayerExit() : void
      {
         var _loc1_:PackageOut = new PackageOut(94);
         _loc1_.writeInt(5);
         sendPackage(_loc1_);
      }
      
      public static function sendGameTeam(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(6);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendFlagMode(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(97);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGameStart() : void
      {
         var _loc1_:PackageOut = new PackageOut(94);
         _loc1_.writeInt(7);
         sendPackage(_loc1_);
      }
      
      public static function sendGameMissionStart(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(82);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGameMissionPrepare(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(91);
         _loc3_.writeByte(116);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendLoadingProgress(param1:Number) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(16);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendPlayerState(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(15);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendStartOrPreCheckEnergy() : void
      {
         var _loc1_:PackageOut = new PackageOut(94);
         _loc1_.writeInt(20);
         sendPackage(_loc1_);
      }
      
      public static function sendGameCMDBlast(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(91);
         _loc5_.writeByte(3);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public static function sendGameCMDChange(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(91);
         _loc6_.writeByte(19);
         _loc6_.writeInt(param1);
         _loc6_.writeInt(param2);
         _loc6_.writeInt(param3);
         _loc6_.writeInt(param4);
         _loc6_.writeInt(param5);
         sendPackage(_loc6_);
      }
      
      public static function sendGameCMDDirection(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGameCMDStunt(param1:int = 0) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(15);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGameCMDShoot(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(91);
         _loc5_.writeByte(2);
         _loc5_.writeInt(int(param1));
         _loc5_.writeInt(int(param2));
         _loc5_.writeInt(int(param3));
         _loc5_.writeInt(int(param4));
         sendPackage(_loc5_);
      }
      
      public static function sendGameSkipNext(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(12);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendTransmissionGate(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(137);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGameStartMove(param1:Number, param2:int, param3:int, param4:Number, param5:Boolean, param6:Number) : void
      {
         var _loc7_:PackageOut = new PackageOut(91);
         _loc7_.writeByte(9);
         _loc7_.writeBoolean(true);
         _loc7_.writeByte(param1);
         _loc7_.writeInt(param2);
         _loc7_.writeInt(param3);
         _loc7_.writeByte(param4);
         _loc7_.writeBoolean(param5);
         _loc7_.writeShort(param6);
         sendPackage(_loc7_);
      }
      
      public static function sendGameStopMove(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(91);
         _loc4_.writeByte(10);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendGameTakeOut(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(98);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendBossTakeOut(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(130);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGetTropToBag(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(108);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendShootTag(param1:Boolean, param2:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(91);
         _loc3_.writeByte(96);
         _loc3_.writeBoolean(param1);
         if(param1)
         {
            _loc3_.writeByte(param2);
         }
         sendPackage(_loc3_);
      }
      
      public static function sendBeat(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:PackageOut = new PackageOut(91);
         _loc4_.writeByte(22);
         _loc4_.writeShort(param1);
         _loc4_.writeShort(param2);
         _loc4_.writeShort(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendThrowProp(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(75);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendUseProp(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(91);
         _loc4_.writeByte(32);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendCancelWait() : void
      {
         var _loc1_:PackageOut = new PackageOut(94);
         _loc1_.writeInt(11);
         sendPackage(_loc1_);
      }
      
      public static function sendSingleRoomBegin(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(18);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGameStyle(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(12);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGhostTarget(param1:Point) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(54);
         _loc2_.writeInt(param1.x);
         _loc2_.writeInt(param1.y);
         sendPackage(_loc2_);
      }
      
      public static function sendPaymentTakeCard(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(91);
         _loc3_.writeByte(114);
         _loc3_.writeByte(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendMissionTryAgain(param1:int, param2:Boolean, param3:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(91);
         _loc4_.writeByte(119);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendFightLibInfoChange(param1:int, param2:int = -1) : void
      {
         var _loc3_:PackageOut = new PackageOut(91);
         _loc3_.writeByte(-1);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendPassStory() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(133);
         _loc1_.writeBoolean(true);
         sendPackage(_loc1_);
      }
      
      public static function sendClientScriptStart() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(23);
         _loc1_.writeInt(3);
         sendPackage(_loc1_);
      }
      
      public static function sendClientScriptEnd() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(23);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public static function sendFightLibAnswer(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(91);
         _loc3_.writeByte(23);
         _loc3_.writeInt(4);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendFightLibReanswer() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(23);
         _loc1_.writeInt(5);
         sendPackage(_loc1_);
      }
      
      public static function sendUpdatePlayStep(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(25);
         _loc2_.writeInt(6);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGodCardInfoAttribute() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(20);
         sendPackage(_loc1_);
      }
      
      public static function sendGodCardOpenCard(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(21);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendGodCardOperateCard(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(329);
         _loc4_.writeByte(22);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendGodCardExchange(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(23);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendGodCardPointAwardAttribute(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(24);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendSelectObject(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(91);
         _loc3_.writeByte(138);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendGetActivePveInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(342);
         sendPackage(_loc1_);
      }
      
      public static function sendMoneyTreeSpeedUp(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(296);
         _loc4_.writeByte(2);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public static function sendMoneyTreeSendRedPackage(param1:Array) : void
      {
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = param1.length;
         var _loc6_:int = 80;
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc4_ = Math.min(_loc5_,_loc8_ + _loc6_);
            _loc7_ = param1.slice(_loc8_,_loc4_);
            _loc3_ = new PackageOut(296);
            _loc3_.writeByte(3);
            _loc3_.writeInt(_loc7_.length);
            var _loc10_:int = 0;
            var _loc9_:* = _loc7_;
            for each(var _loc2_ in _loc7_)
            {
               _loc3_.writeInt(_loc2_);
            }
            sendPackage(_loc3_);
            _loc8_ = _loc8_ + _loc6_;
         }
      }
      
      public static function sendMoneyTreePick(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(296);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendMoneyTreeRequireInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(296);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public static function sendOrdinaryFB(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(258);
         _loc3_.writeByte(17);
         _loc3_.writeBoolean(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendKingDivisionGameStart(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(328);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendGetConsortionMessageThisZone() : void
      {
         var _loc1_:PackageOut = new PackageOut(328);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public static function sendGetConsortionMessageAllZone() : void
      {
         var _loc1_:PackageOut = new PackageOut(328);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public static function sendGetEliminateConsortionMessageThisZone() : void
      {
         var _loc1_:PackageOut = new PackageOut(328);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public static function sendGetEliminateConsortionMessageAllZone() : void
      {
         var _loc1_:PackageOut = new PackageOut(328);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public static function sendDiceRefreshData() : void
      {
         var _loc1_:PackageOut = new PackageOut(134);
         _loc1_.writeByte(12);
         sendPackage(_loc1_);
      }
      
      public static function sendStartDiceInfo(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(134);
         _loc3_.writeByte(11);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendRequestEnterDiceSystem() : void
      {
         var _loc1_:PackageOut = new PackageOut(134);
         _loc1_.writeByte(10);
         sendPackage(_loc1_);
      }
      
      public static function sendGetBattleSkillInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(132);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public static function sendUpdateBattleSkill(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(132);
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public static function sendBringBattleSkill(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(132);
         _loc3_.writeByte(7);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public static function sendGetFriendPack(param1:String, param2:String, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(358);
         _loc5_.writeUTF(param1);
         _loc5_.writeUTF(param2);
         _loc5_.writeByte(param3);
         _loc5_.writeInt(param4);
         _loc5_.writeBoolean(true);
         sendPackage(_loc5_);
      }
      
      public static function sendQuestionAnswer(param1:AnswerInfo) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(56);
         _loc2_.writeUTF(param1.answer);
         _loc2_.writeUTF(param1.qq);
         _loc2_.writeUTF(param1.phone);
         _loc2_.writeUTF(param1.suggest);
         sendPackage(_loc2_);
      }
      
      public static function sendGoldmineInfoAttribute() : void
      {
         var _loc1_:PackageOut = new PackageOut(624);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public static function sendGoldmineUse() : void
      {
         var _loc1_:PackageOut = new PackageOut(624);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public static function sendChangeRoomHost(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(23);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      private static function sendPackage(param1:PackageOut) : void
      {
         _socket.send(param1);
      }
      
      public static function sendCalendarPet() : void
      {
         var _loc1_:PackageOut = new PackageOut(13);
         _loc1_.writeInt(11);
         sendPackage(_loc1_);
      }
   }
}
