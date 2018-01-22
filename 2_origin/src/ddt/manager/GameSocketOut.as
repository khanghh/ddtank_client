package ddt.manager
{
   import Indiana.IndianaEPackageType;
   import baglocked.BaglockedManager;
   import cloudBuyLottery.model.CloudBuyLotteryPackageType;
   import ddt.data.AccountInfo;
   import ddt.data.SendGoodsExchangeInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.events.CEvent;
   import ddt.utils.CrytoUtils;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import foodActivity.event.FoodActivityEvent;
   import gemstone.info.GemstnoeSendInfo;
   import horseRace.controller.HorseRaceManager;
   import road7th.comm.ByteSocket;
   import road7th.comm.PackageOut;
   import road7th.math.randRange;
   import trainer.controller.WeakGuildManager;
   import uiModeManager.bombUI.HappyLittleGameManager;
   import wonderfulActivity.data.GiftChildInfo;
   import wonderfulActivity.data.SendGiftInfo;
   import worldBossHelper.data.WorldBossHelperTypeData;
   
   public class GameSocketOut
   {
       
      
      private var _socket:ByteSocket;
      
      public function GameSocketOut(param1:ByteSocket)
      {
         super();
         _socket = param1;
      }
      
      public function sendLogin(param1:AccountInfo, param2:Boolean) : void
      {
         var _loc8_:int = 0;
         _socket.resetKey();
         var _loc6_:Date = new Date();
         var _loc5_:ByteArray = new ByteArray();
         var _loc3_:int = randRange(100,10000);
         _loc5_.writeShort(_loc6_.fullYearUTC);
         _loc5_.writeByte(_loc6_.monthUTC + 1);
         _loc5_.writeByte(_loc6_.dateUTC);
         _loc5_.writeByte(_loc6_.hoursUTC);
         _loc5_.writeByte(_loc6_.minutesUTC);
         _loc5_.writeByte(_loc6_.secondsUTC);
         var _loc7_:Array = [Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255)];
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc5_.writeByte(_loc7_[_loc8_]);
            _loc8_++;
         }
         _loc5_.writeUTFBytes(param1.Account + "," + param1.Password);
         _loc5_ = CrytoUtils.rsaEncry5(param1.Key,_loc5_);
         _loc5_.position = 0;
         var _loc4_:PackageOut = new PackageOut(1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeInt(5498628);
         _loc4_.writeInt(DesktopManager.Instance.desktopType);
         _loc4_.writeBytes(_loc5_);
         sendPackage(_loc4_);
         _socket.setKey(_loc7_);
      }
      
      public function sendWeeklyClick() : void
      {
         var _loc1_:PackageOut = new PackageOut(219);
         sendPackage(_loc1_);
      }
      
      public function sendLoginDebug() : void
      {
         var _loc1_:PackageOut = new PackageOut(1);
         sendPackage(_loc1_);
      }
      
      public function sendRandomSuitUse(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(337);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendGameLogin(param1:int, param2:int, param3:int = -1, param4:String = "", param5:Boolean = false) : void
      {
         var _loc6_:PackageOut = new PackageOut(94);
         _loc6_.writeInt(1);
         _loc6_.writeBoolean(param5);
         _loc6_.writeInt(param1);
         _loc6_.writeInt(param2);
         if(param2 == -1)
         {
            _loc6_.writeInt(param3);
            _loc6_.writeUTF(param4);
         }
         sendPackage(_loc6_);
      }
      
      public function sendRefreshServer() : void
      {
         var _loc1_:PackageOut = new PackageOut(306);
         sendPackage(_loc1_);
      }
      
      public function sendReconnection() : void
      {
         var _loc1_:PackageOut = new PackageOut(94);
         _loc1_.writeInt(21);
         sendPackage(_loc1_);
      }
      
      public function sendFastInviteCall() : void
      {
         var _loc1_:PackageOut = new PackageOut(94);
         _loc1_.writeInt(19);
         sendPackage(_loc1_);
      }
      
      public function sendSceneLogin(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(16);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGameStyle(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(12);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDailyAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(13);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRestroDaily(param1:Date) : void
      {
         var _loc2_:PackageOut = new PackageOut(13);
         _loc2_.writeInt(6);
         _loc2_.writeDate(param1);
         sendPackage(_loc2_);
      }
      
      public function sendSignAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(90);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBuyGoods(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array = null, param7:int = 0, param8:Array = null, param9:Array = null) : void
      {
         var _loc11_:* = null;
         var _loc13_:* = 0;
         if(param1.length > 50)
         {
            if(param9 && param9.length > 50)
            {
               _loc11_ = param9.splice(0,50);
            }
            else
            {
               _loc11_ = param9;
            }
            if(param6 == null)
            {
               sendBuyGoods(param1.splice(0,50),param2.splice(0,50),param3.splice(0,50),param4.splice(0,50),param5.splice(0,50),null,param7,param8,_loc11_);
            }
            else
            {
               sendBuyGoods(param1.splice(0,50),param2.splice(0,50),param3.splice(0,50),param4.splice(0,50),param5.splice(0,50),param6.splice(0,50),param7,param8,_loc11_);
            }
            sendBuyGoods(param1,param2,param3,param4,param5,param6,param7,param8,param9);
            return;
         }
         var _loc12_:PackageOut = new PackageOut(44);
         var _loc10_:int = param1.length;
         _loc12_.writeInt(_loc10_);
         _loc13_ = uint(0);
         while(_loc13_ < _loc10_)
         {
            if(!param8)
            {
               _loc12_.writeInt(1);
            }
            else
            {
               _loc12_.writeInt(param8[_loc13_]);
            }
            _loc12_.writeInt(param1[_loc13_]);
            _loc12_.writeInt(param2[_loc13_]);
            _loc12_.writeUTF(param3[_loc13_]);
            _loc12_.writeBoolean(param5[_loc13_]);
            if(param6 == null)
            {
               _loc12_.writeUTF("");
            }
            else
            {
               _loc12_.writeUTF(param6[_loc13_]);
            }
            _loc12_.writeInt(param4[_loc13_]);
            if(param9)
            {
               _loc12_.writeBoolean(param9[_loc13_]);
            }
            else
            {
               _loc12_.writeBoolean(false);
            }
            _loc13_++;
         }
         _loc12_.writeInt(param7);
         sendPackage(_loc12_);
      }
      
      public function sendNewBuyGoods(param1:int, param2:int, param3:int = 1, param4:String = "", param5:int = 0, param6:Boolean = false, param7:String = "", param8:int = 0, param9:int = 1, param10:Boolean = true) : void
      {
         var _loc11_:PackageOut = new PackageOut(345);
         _loc11_.writeInt(param3);
         _loc11_.writeInt(param9);
         _loc11_.writeInt(param1);
         _loc11_.writeInt(param2);
         _loc11_.writeUTF(param4);
         _loc11_.writeBoolean(param6);
         _loc11_.writeUTF(param7);
         _loc11_.writeInt(param5);
         _loc11_.writeBoolean(param10);
         _loc11_.writeInt(param8);
         sendPackage(_loc11_);
      }
      
      public function sendBuyProp(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(54);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendSellProp(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(55);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendQuickBuyGoldBox(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(126);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBuyGiftBag(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(46);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendButTransnationalGoods(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(156);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPresentGoods(param1:Array, param2:Array, param3:Array, param4:Array, param5:String, param6:String, param7:Array = null, param8:Array = null) : void
      {
         var _loc11_:* = 0;
         var _loc10_:PackageOut = new PackageOut(57);
         var _loc9_:int = param1.length;
         _loc10_.writeUTF(param5);
         _loc10_.writeUTF(param6);
         _loc10_.writeInt(_loc9_);
         _loc11_ = uint(0);
         while(_loc11_ < _loc9_)
         {
            _loc10_.writeInt(param1[_loc11_]);
            _loc10_.writeInt(param2[_loc11_]);
            _loc10_.writeUTF(param3[_loc11_]);
            if(param7 == null)
            {
               _loc10_.writeUTF("");
            }
            else
            {
               _loc10_.writeUTF(param7[_loc11_]);
            }
            _loc10_.writeInt(param4[_loc11_]);
            _loc11_++;
         }
         sendPackage(_loc10_);
      }
      
      public function sendGoodsContinue(param1:Array) : void
      {
         var _loc4_:* = 0;
         var _loc2_:int = param1.length;
         var _loc3_:PackageOut = new PackageOut(62);
         _loc3_.writeInt(_loc2_);
         _loc4_ = uint(0);
         while(_loc4_ < _loc2_)
         {
            _loc3_.writeByte(param1[_loc4_][0]);
            _loc3_.writeInt(param1[_loc4_][1]);
            _loc3_.writeInt(param1[_loc4_][2]);
            _loc3_.writeByte(param1[_loc4_][3]);
            _loc3_.writeBoolean(param1[_loc4_][4]);
            _loc3_.writeInt(param1[_loc4_][5]);
            _loc4_++;
         }
         sendPackage(_loc3_);
      }
      
      public function sendSellGoods(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(48);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUpdateGoodsCount() : void
      {
         var _loc1_:PackageOut = new PackageOut(168);
         sendPackage(_loc1_);
      }
      
      public function sendEmail(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(116);
         _loc2_.writeUTF(param1.NickName);
         _loc2_.writeUTF(param1.Title);
         _loc2_.writeUTF(param1.Content);
         _loc2_.writeBoolean(param1.isPay);
         _loc2_.writeInt(param1.hours);
         _loc2_.writeInt(param1.SendedMoney);
         while(_loc3_ < 4)
         {
            if(param1["Annex" + _loc3_])
            {
               _loc2_.writeByte(param1["Annex" + _loc3_].split(",")[0]);
               _loc2_.writeInt(param1["Annex" + _loc3_].split(",")[1]);
               _loc2_.writeInt(param1.Count);
            }
            else
            {
               _loc2_.writeByte(0);
               _loc2_.writeInt(-1);
               _loc2_.writeInt(0);
            }
            _loc3_++;
         }
         sendPackage(_loc2_);
      }
      
      public function sendUpdateMail(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(114);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDeleteSentMail(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(340);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDeleteMail(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(112);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function untreadEmail(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(118);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGetMail(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(113);
         _loc3_.writeInt(param1);
         _loc3_.writeByte(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPint() : void
      {
         var _loc1_:PackageOut = new PackageOut(4);
         sendPackage(_loc1_);
      }
      
      public function sendSuicide(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(17);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendKillSelf(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(21);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendItemCompose(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(58);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendItemTransfer(param1:Boolean = true, param2:Boolean = true, param3:int = 12, param4:int = 0, param5:int = 12, param6:int = 1) : void
      {
         var _loc7_:PackageOut = new PackageOut(61);
         _loc7_.writeBoolean(param1);
         _loc7_.writeBoolean(param2);
         _loc7_.writeInt(param3);
         _loc7_.writeInt(param4);
         _loc7_.writeInt(param5);
         _loc7_.writeInt(param6);
         sendPackage(_loc7_);
      }
      
      public function sendItemStrength(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(59);
         _loc3_.writeBoolean(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendItemExalt() : void
      {
         var _loc1_:PackageOut = new PackageOut(138);
         sendPackage(_loc1_);
      }
      
      public function sendExaltRestore() : void
      {
         var _loc1_:PackageOut = new PackageOut(354);
         sendPackage(_loc1_);
      }
      
      public function sendItemLianhua(param1:int, param2:int, param3:Array, param4:int, param5:int, param6:int, param7:int) : void
      {
         var _loc9_:int = 0;
         var _loc8_:PackageOut = new PackageOut(210);
         _loc8_.writeInt(param1);
         _loc8_.writeInt(param2);
         _loc9_ = 0;
         while(_loc9_ < param3.length)
         {
            _loc8_.writeInt(param3[_loc9_]);
            _loc9_++;
         }
         _loc8_.writeInt(param4);
         _loc8_.writeInt(param5);
         _loc8_.writeInt(param6);
         _loc8_.writeInt(param7);
         sendPackage(_loc8_);
      }
      
      public function sendBeadEquip(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(121);
         _loc3_.writeByte(1);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBeadUpgrade(param1:Array) : void
      {
         var _loc2_:PackageOut = new PackageOut(121);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1.length);
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc2_.writeInt(_loc3_);
         }
         sendPackage(_loc2_);
      }
      
      public function sendOpenBead(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(121);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBeadLock(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(121);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBeadOpenHole(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(121);
         _loc4_.writeByte(5);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendBeadAdvanceExchange(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(121);
         _loc4_.writeByte(7);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendItemEmbedBackout(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(125);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendItemOpenFiveSixHole(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(217);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendItemTrend(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(120);
         _loc6_.writeInt(param1);
         _loc6_.writeInt(param2);
         _loc6_.writeInt(param3);
         _loc6_.writeInt(param4);
         _loc6_.writeInt(param5);
         sendPackage(_loc6_);
      }
      
      public function sendClearStoreBag() : void
      {
         PlayerManager.Instance.Self.StoreBag.items.clear();
         PlayerManager.Instance.Self.StoreBag.dispatchEvent(new CEvent("clearStoreBag"));
         var _loc1_:PackageOut = new PackageOut(122);
         sendPackage(_loc1_);
      }
      
      public function sendCheckCode(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(200);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEquipRetrieve() : void
      {
         var _loc1_:PackageOut = new PackageOut(222);
         sendPackage(_loc1_);
      }
      
      public function sendItemFusion(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(78);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendSBugle(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(71);
         _loc2_.writeInt(PlayerManager.Instance.Self.ID);
         _loc2_.writeUTF(PlayerManager.Instance.Self.NickName);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBBugle(param1:String, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(72);
         _loc3_.writeInt(param2);
         _loc3_.writeInt(PlayerManager.Instance.Self.ID);
         _loc3_.writeUTF(PlayerManager.Instance.Self.NickName);
         _loc3_.writeUTF(param1);
         sendPackage(_loc3_);
      }
      
      public function sendCBugle(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(73);
         _loc2_.writeInt(PlayerManager.Instance.Self.ID);
         _loc2_.writeUTF(PlayerManager.Instance.Self.NickName);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDefyAffiche(param1:String, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(123);
         _loc3_.writeBoolean(param2);
         _loc3_.writeUTF(param1);
         sendPackage(_loc3_);
      }
      
      public function sendGameMode(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(12);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAddFriend(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) : void
      {
         if(param1 == "")
         {
            return;
         }
         var _loc5_:PackageOut = new PackageOut(160);
         _loc5_.writeByte(160);
         _loc5_.writeUTF(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeBoolean(param3);
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function sendDelFriend(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(160);
         _loc2_.writeByte(161);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendFriendState(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(160);
         _loc2_.writeByte(165);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBagLocked(param1:String, param2:int, param3:String = "", param4:String = "", param5:String = "", param6:String = "", param7:String = "") : void
      {
         var _loc8_:PackageOut = new PackageOut(25);
         _loc8_.writeByte(1);
         BaglockedManager.TEMP_PWD = param3 != ""?param3:param1;
         _loc8_.writeUTF(param1);
         _loc8_.writeUTF(param3);
         _loc8_.writeInt(param2);
         _loc8_.writeUTF(param4);
         _loc8_.writeUTF(param5);
         _loc8_.writeUTF(param6);
         _loc8_.writeUTF(param7);
         sendPackage(_loc8_);
      }
      
      public function sendBagLockedII(param1:String, param2:String, param3:String, param4:String, param5:String) : void
      {
      }
      
      public function sendConsortiaEquipConstrol(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(24);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeInt(param1[_loc3_]);
            _loc3_++;
         }
         sendPackage(_loc2_);
      }
      
      public function sendErrorMsg(param1:String) : void
      {
         var _loc2_:* = null;
         if(param1.length < 1000)
         {
            _loc2_ = new PackageOut(8);
            _loc2_.writeUTF(param1);
            sendPackage(_loc2_);
         }
      }
      
      public function sendItemOverDue(param1:int, param2:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(77);
         _loc3_.writeByte(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendHideLayer(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(60);
         _loc3_.writeBoolean(param2);
         _loc3_.writeInt(param1);
         sendPackage(_loc3_);
      }
      
      public function sendQuestManuGet(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(273);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendQuestAdd(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(176);
         _loc2_.writeInt(param1.length);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == 3025)
            {
               trace(param1[_loc3_]);
            }
            _loc2_.writeInt(param1[_loc3_]);
            _loc3_++;
         }
         sendPackage(_loc2_);
      }
      
      public function sendQuestRemove(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(177);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendQuestFinish(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(179);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendQuestOneToFinish(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(86);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendImproveQuest(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(83);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendQuestCheck(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(181);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendItemOpenUp(param1:int, param2:int, param3:int = 1, param4:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(63);
         _loc5_.writeByte(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function sendUseLoveFeelingly(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(330);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendItemEquip(param1:*, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(74);
         if(!param2)
         {
            _loc3_.writeBoolean(true);
            _loc3_.writeInt(param1);
         }
         else if(param2)
         {
            _loc3_.writeBoolean(false);
            _loc3_.writeUTF(param1);
         }
         sendPackage(_loc3_);
      }
      
      public function sendMateTime(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(85);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPlayerGift(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(218);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendActivePullDown(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(11);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function auctionGood(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean) : void
      {
         var _loc9_:PackageOut = new PackageOut(192);
         _loc9_.writeByte(param1);
         _loc9_.writeInt(param2);
         _loc9_.writeByte(param3);
         _loc9_.writeInt(param4);
         _loc9_.writeInt(param5);
         _loc9_.writeInt(param6);
         _loc9_.writeInt(param7);
         _loc9_.writeBoolean(param8);
         sendPackage(_loc9_);
      }
      
      public function auctionCancelSell(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(194);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function auctionBid(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(193);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function syncStep(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(15);
         _loc3_.writeByte(1);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function syncWeakStep(param1:int) : void
      {
         WeakGuildManager.Instance.setStepFinish(param1);
         var _loc2_:PackageOut = new PackageOut(15);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendCreateConsortia(param1:String, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(1);
         _loc3_.writeUTF(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsortiaTryIn(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(0);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaCancelTryIn() : void
      {
         var _loc1_:PackageOut = new PackageOut(129);
         _loc1_.writeInt(0);
         _loc1_.writeInt(0);
         sendPackage(_loc1_);
      }
      
      public function sendConsortiaInvate(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(11);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendReleaseConsortiaTask(param1:int, param2:Boolean = true, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(129);
         _loc4_.writeInt(22);
         _loc4_.writeInt(param1);
         if(param1 == 0)
         {
            _loc4_.writeInt(param3);
         }
         else
         {
            _loc4_.writeBoolean(param2);
         }
         sendPackage(_loc4_);
      }
      
      public function addSpeed(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(155);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsortiaInvatePass(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(12);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaInvateDelete(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(13);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaUpdateDescription(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(14);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaUpdatePlacard(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(15);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaUpdateDuty(param1:int, param2:String, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(129);
         _loc4_.writeInt(10);
         _loc4_.writeInt(param1);
         _loc4_.writeByte(param1 == -1?1:2);
         _loc4_.writeUTF(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendConsortiaUpgradeDuty(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(10);
         _loc3_.writeInt(param1);
         _loc3_.writeByte(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsoritaApplyStatusOut(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(7);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaOut(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaMemberGrade(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(18);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsortiaUserRemarkUpdate(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(17);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsortiaDutyDelete(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(9);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaTryinPass(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaTryinDelete(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendForbidSpeak(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(16);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsortiaDismiss() : void
      {
         var _loc1_:PackageOut = new PackageOut(129);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function sendConsortiaChangeChairman(param1:String = "") : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(19);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaRichOffer(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(6);
         _loc2_.writeInt(param1);
         _loc2_.writeBoolean(false);
         sendPackage(_loc2_);
      }
      
      public function sendDonate(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(23);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsortiaLevelUp(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(21);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAirPlane() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(40);
         sendPackage(_loc1_);
      }
      
      public function useDeputyWeapon() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(84);
         sendPackage(_loc1_);
      }
      
      public function sendGamePick(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(49);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPetSkill(param1:int, param2:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(91);
         _loc3_.writeByte(144);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPackage(param1:PackageOut) : void
      {
         _socket.send(param1);
      }
      
      public function sendMoveGoods(param1:int, param2:int, param3:int, param4:int, param5:int = 1, param6:Boolean = false) : void
      {
         var _loc7_:PackageOut = new PackageOut(49);
         _loc7_.writeByte(param1);
         _loc7_.writeInt(param2);
         _loc7_.writeByte(param3);
         _loc7_.writeInt(param4);
         _loc7_.writeInt(param5);
         _loc7_.writeBoolean(param6);
         sendPackage(_loc7_);
      }
      
      public function reclaimGoods(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(127);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendMoveGoodsAll(param1:int, param2:Array, param3:int, param4:Boolean = false) : void
      {
         var _loc7_:int = 0;
         if(param2.length <= 0)
         {
            return;
         }
         var _loc6_:int = param2.length;
         var _loc5_:PackageOut = new PackageOut(124);
         _loc5_.writeBoolean(param4);
         _loc5_.writeInt(_loc6_);
         _loc5_.writeInt(param1);
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_.writeInt(param2[_loc7_].Place);
            _loc5_.writeInt(_loc7_ + param3);
            _loc7_++;
         }
         sendPackage(_loc5_);
      }
      
      public function sendForSwitch() : void
      {
         var _loc1_:PackageOut = new PackageOut(225);
         sendPackage(_loc1_);
      }
      
      public function sendCIDCheck() : void
      {
         var _loc1_:PackageOut = new PackageOut(224);
         sendPackage(_loc1_);
      }
      
      public function sendCIDInfo(param1:String, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(224);
         _loc3_.writeBoolean(false);
         _loc3_.writeUTF(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendChangeColor(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String, param7:int) : void
      {
         var _loc8_:PackageOut = new PackageOut(182);
         _loc8_.writeInt(param1);
         _loc8_.writeInt(param2);
         _loc8_.writeInt(param3);
         _loc8_.writeInt(param4);
         _loc8_.writeUTF(param5);
         _loc8_.writeUTF(param6);
         _loc8_.writeInt(param7);
         sendPackage(_loc8_);
      }
      
      public function sendUseCard(param1:int, param2:int, param3:Array, param4:int, param5:Boolean = false, param6:Boolean = true, param7:int = 1) : void
      {
         var _loc10_:int = 0;
         var _loc8_:PackageOut = new PackageOut(183);
         _loc8_.writeInt(param1);
         _loc8_.writeInt(param2);
         _loc8_.writeInt(param3.length);
         var _loc9_:int = param3.length;
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            _loc8_.writeInt(param3[_loc10_]);
            _loc10_++;
         }
         _loc8_.writeInt(param4);
         _loc8_.writeBoolean(param5);
         _loc8_.writeBoolean(param6);
         _loc8_.writeInt(param7);
         sendPackage(_loc8_);
      }
      
      public function sendUseProp(param1:int, param2:int, param3:Array, param4:int, param5:Boolean = false) : void
      {
         var _loc8_:int = 0;
         var _loc6_:PackageOut = new PackageOut(66);
         _loc6_.writeInt(param1);
         _loc6_.writeInt(param2);
         _loc6_.writeInt(param3.length);
         var _loc7_:int = param3.length;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc6_.writeInt(param3[_loc8_]);
            _loc8_++;
         }
         _loc6_.writeInt(param4);
         _loc6_.writeBoolean(param5);
         sendPackage(_loc6_);
      }
      
      public function sendUseChangeColorShell(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(205);
         _loc3_.writeByte(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendChangeColorShellTimeOver(param1:int, param2:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(206);
         _loc3_.writeByte(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendRouletteBox(param1:int, param2:int, param3:int = -1) : void
      {
         trace("[sendRouletteBox]" + getTimer());
         var _loc4_:PackageOut = new PackageOut(26);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendStartTurn(param1:int = 1) : void
      {
         var _loc2_:PackageOut = new PackageOut(27);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendFinishRoulette() : void
      {
         var _loc1_:PackageOut = new PackageOut(28);
         sendPackage(_loc1_);
      }
      
      public function sendSellAll() : void
      {
         var _loc1_:PackageOut = new PackageOut(232);
         sendPackage(_loc1_);
      }
      
      public function sendconverted(param1:Boolean, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(215);
         _loc4_.writeBoolean(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendExchange() : void
      {
         var _loc1_:PackageOut = new PackageOut(211);
         sendPackage(_loc1_);
      }
      
      public function sendOpenAll() : void
      {
      }
      
      public function sendOpenDead(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(26);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendRequestAwards(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(245);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendQequestBadLuck(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(45);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendQequestLuckky(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(97);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUseReworkName(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(171);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendUseConsortiaReworkName(param1:int, param2:int, param3:int, param4:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(188);
         _loc5_.writeInt(param1);
         _loc5_.writeByte(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeUTF(param4);
         sendPackage(_loc5_);
      }
      
      public function sendValidateMarry(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(246);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPropose(param1:int, param2:String, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(247);
         _loc5_.writeInt(param1);
         _loc5_.writeUTF(param2);
         _loc5_.writeBoolean(param3);
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function sendProposeRespose(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(250);
         _loc4_.writeBoolean(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendUnmarry(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(248);
         _loc2_.writeBoolean(param1);
         _loc2_.writeBoolean(PlayerManager.Instance.merryActivity);
         sendPackage(_loc2_);
      }
      
      public function sendMarryRoomLogin() : void
      {
         var _loc1_:PackageOut = new PackageOut(240);
         sendPackage(_loc1_);
      }
      
      public function sendExitMarryRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(21);
         sendPackage(_loc1_);
      }
      
      public function sendCreateRoom(param1:String, param2:String, param3:int, param4:int, param5:Boolean, param6:String, param7:int) : void
      {
         var _loc8_:PackageOut = new PackageOut(241);
         _loc8_.writeUTF(param1);
         _loc8_.writeUTF(param2);
         _loc8_.writeInt(param3);
         _loc8_.writeInt(param4);
         _loc8_.writeInt(100);
         _loc8_.writeBoolean(param5);
         _loc8_.writeUTF(param6);
         _loc8_.writeBoolean(PlayerManager.Instance.merryActivity);
         _loc8_.writeInt(param7);
         sendPackage(_loc8_);
      }
      
      public function sendEnterRoom(param1:int, param2:String, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(242);
         _loc4_.writeInt(param1);
         _loc4_.writeUTF(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendExitRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(244);
         sendPackage(_loc1_);
      }
      
      public function sendCurrentState(param1:uint) : void
      {
         var _loc2_:PackageOut = new PackageOut(251);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUpdateRoomList(param1:int, param2:int, param3:int = 10000, param4:int = 1013) : void
      {
         var _loc5_:PackageOut = new PackageOut(94);
         _loc5_.writeInt(9);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         if(param1 == 2 && param2 == -2 || param1 == 7)
         {
            _loc5_.writeInt(param3);
            _loc5_.writeInt(param4);
         }
         sendPackage(_loc5_);
      }
      
      public function sendChurchMove(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(249);
         _loc4_.writeByte(1);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendStartWedding(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(249);
         _loc2_.writeByte(2);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendChurchContinuation(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(249);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendChurchInvite(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(249);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendChurchLargess(param1:uint) : void
      {
         var _loc2_:PackageOut = new PackageOut(249);
         _loc2_.writeByte(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function refund() : void
      {
         var _loc1_:PackageOut = new PackageOut(249);
         _loc1_.writeByte(12);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function requestRefund() : void
      {
         var _loc1_:PackageOut = new PackageOut(249);
         _loc1_.writeByte(12);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendUseFire(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(249);
         _loc4_.writeByte(6);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendChurchKick(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(249);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendChurchMovieOver(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(167);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendChurchForbid(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(249);
         _loc2_.writeByte(8);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPosition(param1:Number, param2:Number) : void
      {
         var _loc3_:PackageOut = new PackageOut(249);
         _loc3_.writeByte(10);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendModifyChurchDiscription(param1:String, param2:Boolean, param3:String, param4:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(253);
         _loc5_.writeUTF(param1);
         _loc5_.writeBoolean(param2);
         _loc5_.writeUTF(param3);
         _loc5_.writeUTF(param4);
         sendPackage(_loc5_);
      }
      
      public function sendSceneChange(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(233);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGunSalute(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(249);
         _loc3_.writeByte(11);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendRequestSeniorChurch() : void
      {
         var _loc1_:PackageOut = new PackageOut(338);
         sendPackage(_loc1_);
      }
      
      public function sendRegisterInfo(param1:int, param2:Boolean, param3:String = null) : void
      {
         var _loc4_:PackageOut = new PackageOut(236);
         _loc4_.writeBoolean(param2);
         _loc4_.writeUTF(param3);
         _loc4_.writeInt(param1);
         sendPackage(_loc4_);
      }
      
      public function sendModifyInfo(param1:Boolean, param2:String = null) : void
      {
         var _loc3_:PackageOut = new PackageOut(229);
         _loc3_.writeBoolean(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendForMarryInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(235);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGetLinkGoodsInfo(param1:int, param2:String, param3:String = "") : void
      {
         var _loc4_:PackageOut = new PackageOut(119);
         _loc4_.writeInt(param1);
         _loc4_.writeUTF(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendGetTropToBag(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(108);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function createUserGuide(param1:int = 10) : void
      {
         trace("SocketManager.Instance.out.createUserGuide(14);");
         var _loc3_:String = String(Math.random());
         var _loc2_:PackageOut = new PackageOut(94);
         _loc2_.writeInt(0);
         _loc2_.writeByte(param1);
         _loc2_.writeByte(3);
         _loc2_.writeUTF("");
         _loc2_.writeUTF(_loc3_);
         sendPackage(_loc2_);
      }
      
      public function enterUserGuide(param1:int, param2:int = 10) : void
      {
         var _loc5_:String = String(Math.random());
         var _loc3_:int = PlayerManager.Instance.Self.Grade < 5?4:3;
         var _loc4_:PackageOut = new PackageOut(94);
         _loc4_.writeInt(2);
         _loc4_.writeInt(param1);
         _loc4_.writeByte(param2);
         _loc4_.writeBoolean(false);
         _loc4_.writeUTF(_loc5_);
         _loc4_.writeUTF("");
         _loc4_.writeByte(_loc3_);
         _loc4_.writeByte(0);
         _loc4_.writeInt(0);
         _loc4_.writeBoolean(false);
         _loc4_.writeInt(0);
         _loc4_.writeInt(0);
         _loc4_.writeBoolean(false);
         sendPackage(_loc4_);
      }
      
      public function userGuideStart() : void
      {
         var _loc1_:PackageOut = new PackageOut(94);
         _loc1_.writeInt(7);
         sendPackage(_loc1_);
      }
      
      public function sendSaveDB() : void
      {
         var _loc1_:PackageOut = new PackageOut(172);
         sendPackage(_loc1_);
      }
      
      public function createMonster() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(23);
         _loc1_.writeInt(0);
         sendPackage(_loc1_);
      }
      
      public function deleteMonster() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(23);
         _loc1_.writeInt(1);
         sendPackage(_loc1_);
      }
      
      public function sendHotSpringEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(187);
         sendPackage(_loc1_);
      }
      
      public function sendHotSpringRoomCreate(param1:*) : void
      {
         var _loc2_:PackageOut = new PackageOut(175);
         _loc2_.writeUTF(param1.roomName);
         _loc2_.writeUTF(param1.roomPassword);
         _loc2_.writeUTF(param1.roomIntroduction);
         _loc2_.writeInt(param1.maxCount);
         sendPackage(_loc2_);
      }
      
      public function sendHotSpringRoomEdit(param1:*) : void
      {
         var _loc2_:PackageOut = new PackageOut(191);
         _loc2_.writeByte(6);
         _loc2_.writeUTF(param1.roomName);
         _loc2_.writeUTF(param1.roomPassword);
         _loc2_.writeUTF(param1.roomIntroduction);
         sendPackage(_loc2_);
      }
      
      public function sendHotSpringRoomQuickEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(190);
         sendPackage(_loc1_);
      }
      
      public function sendHotSpringRoomEnterConfirm(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(212);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHotSpringRoomEnter(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(202);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendHotSpringRoomEnterView(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(201);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHotSpringRoomPlayerRemove() : void
      {
         var _loc1_:PackageOut = new PackageOut(169);
         sendPackage(_loc1_);
      }
      
      public function sendHotSpringRoomPlayerTargetPoint(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc4_:PackageOut = new PackageOut(191);
         _loc4_.writeByte(1);
         var _loc2_:Array = param1.walkPath.concat();
         var _loc3_:Array = [];
         while(_loc6_ < _loc2_.length)
         {
            _loc3_.push(int(_loc2_[_loc6_].x),int(_loc2_[_loc6_].y));
            _loc6_++;
         }
         var _loc5_:String = _loc3_.toString();
         _loc4_.writeUTF(_loc5_);
         _loc4_.writeInt(param1.playerInfo.ID);
         _loc4_.writeInt(param1.currentWalkStartPoint.x);
         _loc4_.writeInt(param1.currentWalkStartPoint.y);
         _loc4_.writeInt(1);
         _loc4_.writeInt(param1.playerDirection);
         sendPackage(_loc4_);
      }
      
      public function sendHotSpringRoomRenewalFee(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(191);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHotSpringRoomInvite(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(191);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHotSpringRoomAdminRemovePlayer(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(191);
         _loc2_.writeByte(9);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHotSpringRoomPlayerContinue(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(191);
         _loc2_.writeByte(10);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGetTimeBox(param1:int, param2:int, param3:int = -1, param4:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(53);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function sendAchievementFinish(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(230);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendReworkRank(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(189);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendLookupEffort(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(203);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBeginFightNpc() : void
      {
         var _loc1_:PackageOut = new PackageOut(50);
         sendPackage(_loc1_);
      }
      
      public function sendRequestUpdate() : void
      {
         var _loc1_:PackageOut = new PackageOut(225);
         sendPackage(_loc1_);
      }
      
      public function sendQuestionReply(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(89);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOpenVip(param1:String, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(92);
         _loc4_.writeUTF(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         _loc4_.writeBoolean(PlayerManager.Instance.vipActivity);
         sendPackage(_loc4_);
      }
      
      public function sendAcademyRegister(param1:int, param2:Boolean, param3:String = null, param4:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(141);
         _loc5_.writeByte(1);
         _loc5_.writeInt(param1);
         _loc5_.writeBoolean(param2);
         _loc5_.writeUTF(param3);
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function sendAcademyRemoveRegister() : void
      {
         var _loc1_:PackageOut = new PackageOut(141);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendAcademyApprentice(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(141);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendAcademyMaster(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(141);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendAcademyMasterConfirm(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(141);
         if(param1)
         {
            _loc3_.writeByte(6);
         }
         else
         {
            _loc3_.writeByte(8);
         }
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendAcademyApprenticeConfirm(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(141);
         if(param1)
         {
            _loc3_.writeByte(7);
         }
         else
         {
            _loc3_.writeByte(9);
         }
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendAcademyFireMaster(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(141);
         _loc2_.writeByte(12);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAcademyFireApprentice(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(141);
         _loc2_.writeByte(13);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUseLog(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(213);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBuyGift(param1:String, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(221);
         _loc5_.writeUTF(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function sendReloadGift() : void
      {
         var _loc1_:PackageOut = new PackageOut(214);
         sendPackage(_loc1_);
      }
      
      public function sendSnsMsg(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(40);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getPlayerCardInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(18);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendMoveCards(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(216);
         _loc3_.writeInt(0);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendOpenViceCard(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(216);
         _loc2_.writeInt(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOpenCardBox(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(216);
         _loc4_.writeInt(1);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendOpenRandomBox(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(216);
         _loc3_.writeInt(4);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendOpenSpecialCardBox(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(216);
         _loc4_.writeInt(9);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendOpenNationWord(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(288);
         _loc4_.writeByte(4);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendUpGradeCard(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(216);
         _loc2_.writeInt(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUpdateSLOT(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(170);
         _loc3_.writeInt(0);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendResetCardSoul(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(170);
         _loc2_.writeInt(1);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendCardReset(param1:int, param2:int, param3:Array, param4:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc5_:PackageOut = new PackageOut(196);
         _loc5_.writeInt(0);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc6_ = 0;
         while(_loc6_ < param3.length)
         {
            _loc5_.writeInt(param3[_loc6_]);
            _loc6_++;
         }
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function sendReplaceCardProp(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(196);
         _loc2_.writeInt(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendSortCards(param1:Vector.<int>) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:PackageOut = new PackageOut(216);
         _loc4_.writeInt(2);
         var _loc5_:int = param1.length;
         _loc4_.writeInt(_loc5_);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1[_loc6_];
            _loc3_ = _loc6_ + 5;
            _loc4_.writeInt(_loc2_);
            _loc4_.writeInt(_loc3_);
            _loc6_++;
         }
         sendPackage(_loc4_);
      }
      
      public function sendFirstGetCards() : void
      {
         var _loc1_:PackageOut = new PackageOut(216);
         _loc1_.writeInt(3);
         sendPackage(_loc1_);
      }
      
      public function sendFace(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(20);
         _loc2_.writeInt(param1);
         _loc2_.writeInt(0);
         sendPackage(_loc2_);
      }
      
      public function sendOpition(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(64);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortionMail(param1:String, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(29);
         _loc3_.writeUTF(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsortionPoll(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(25);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortionSkill(param1:Boolean, param2:int, param3:int, param4:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(129);
         _loc5_.writeInt(26);
         _loc5_.writeBoolean(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function sendOns() : void
      {
         var _loc1_:PackageOut = new PackageOut(160);
         _loc1_.writeByte(45);
         sendPackage(_loc1_);
      }
      
      public function sendWithBrithday(param1:Vector.<FriendListPlayer>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(223);
         _loc2_.writeInt(param1.length);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeInt(param1[_loc3_].ID);
            _loc2_.writeUTF(param1[_loc3_].NickName);
            _loc2_.writeDate(param1[_loc3_].BirthdayDate);
            _loc3_++;
         }
         sendPackage(_loc2_);
      }
      
      public function sendChangeDesignation(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(34);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDailyRecord() : void
      {
         var _loc1_:PackageOut = new PackageOut(103);
         sendPackage(_loc1_);
      }
      
      public function sendCollectInfoValidate(param1:int, param2:String, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(32);
         _loc4_.writeByte(param1);
         _loc4_.writeUTF(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendGoodsExchange(param1:Vector.<SendGoodsExchangeInfo>, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:PackageOut = new PackageOut(31);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param1.length);
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc5_.writeInt(param1[_loc6_].id);
            _loc5_.writeInt(param1[_loc6_].place);
            _loc5_.writeInt(param1[_loc6_].bagType);
            _loc6_++;
         }
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function sendTexp(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(99);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function sendMark(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(160);
         _loc3_.writeByte(162);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendCustomFriends(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(160);
         _loc4_.writeByte(208);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendOneOnOneTalk(param1:int, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(160);
         _loc4_.writeByte(51);
         _loc4_.writeInt(param1);
         _loc4_.writeUTF(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendUserLuckyNum(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(161);
         _loc3_.writeBoolean(param2);
         _loc3_.writeInt(param1);
         sendPackage(_loc3_);
      }
      
      public function sendPicc(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(30);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBuyBadge(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(129);
         _loc2_.writeInt(28);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGetEliteGameState() : void
      {
         var _loc1_:PackageOut = new PackageOut(162);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendGetSelfRankSroce() : void
      {
         var _loc1_:PackageOut = new PackageOut(162);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendGetPaarungDetail(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(162);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEliteGameStart() : void
      {
         var _loc1_:PackageOut = new PackageOut(162);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function sendStartTurn_LeftGun() : void
      {
         var _loc1_:PackageOut = new PackageOut(128);
         _loc1_.writeInt(1);
         sendPackage(_loc1_);
      }
      
      public function sendEndTurn_LeftGun() : void
      {
         var _loc1_:PackageOut = new PackageOut(130);
         _loc1_.writeInt(1);
         sendPackage(_loc1_);
      }
      
      public function sendWishBeadEquip(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:PackageOut = new PackageOut(106);
         _loc7_.writeInt(param1);
         _loc7_.writeInt(param2);
         _loc7_.writeInt(param3);
         _loc7_.writeInt(param4);
         _loc7_.writeInt(param5);
         _loc7_.writeInt(param6);
         sendPackage(_loc7_);
      }
      
      public function sendPetCellUnlock(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(10);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPetMove(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPetFightUnFight(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(17);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPetFeed(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(68);
         _loc4_.writeByte(4);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendEquipPetSkill(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(68);
         _loc4_.writeByte(7);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendPetRename(param1:int, param2:String, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(68);
         _loc4_.writeByte(9);
         _loc4_.writeInt(param1);
         _loc4_.writeUTF(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendReleasePet(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(68);
         _loc4_.writeByte(8);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendAdoptPet(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(68);
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRefreshPet(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(5);
         _loc3_.writeBoolean(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendUpdatePetInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(68);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPaySkill(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(68);
         _loc2_.writeByte(16);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAddPet(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(2);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendNewTitleCard(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(265);
         _loc3_.writeByte(param2);
         _loc3_.writeInt(param1);
         sendPackage(_loc3_);
      }
      
      public function enterFarm(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function seeding(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(81);
         _loc3_.writeByte(2);
         _loc3_.writeByte(13);
         _loc3_.writeInt(param2);
         _loc3_.writeInt(param1);
         sendPackage(_loc3_);
      }
      
      public function sendCompose(param1:int, param2:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(81);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function doMature(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(81);
         _loc4_.writeByte(3);
         _loc4_.writeByte(13);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param3);
         _loc4_.writeInt(param2);
         sendPackage(_loc4_);
      }
      
      public function toGather(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(81);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function toSpread(param1:Array, param2:int, param3:Boolean) : void
      {
         if(!param1 || param1.length == 0)
         {
            return;
         }
         var _loc5_:PackageOut = new PackageOut(81);
         _loc5_.writeByte(6);
         _loc5_.writeInt(param1.length);
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc4_ in param1)
         {
            _loc5_.writeInt(_loc4_);
         }
         _loc5_.writeInt(param2);
         _loc5_.writeBoolean(param3);
         sendPackage(_loc5_);
      }
      
      public function toSpreadByProsperity(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(246);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendWish() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(148);
         sendPackage(_loc1_);
      }
      
      public function sendChangeSex(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(252);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendVipCoupons(param1:int, param2:int, param3:int, param4:String, param5:String) : void
      {
         var _loc6_:PackageOut = new PackageOut(369);
         _loc6_.writeInt(param1);
         _loc6_.writeInt(param2);
         _loc6_.writeInt(param3);
         _loc6_.writeUTF(param4);
         _loc6_.writeUTF(param5);
         sendPackage(_loc6_);
      }
      
      public function toFarmHelper(param1:Array, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageOut = new PackageOut(81);
         _loc3_.writeByte(9);
         _loc3_.writeInt(param1.length);
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_];
            _loc3_.writeInt(_loc4_.currentfindIndex);
            _loc3_.writeInt(_loc4_.currentSeedText);
            _loc3_.writeInt(_loc4_.currentSeedNum);
            _loc3_.writeInt(_loc4_.currentFertilizerText);
            _loc3_.writeInt(_loc4_.autoFertilizerNum);
            _loc3_.writeBoolean(param2);
            _loc5_++;
         }
         sendPackage(_loc3_);
      }
      
      public function sendBeginHelper(param1:Array) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(9);
         _loc2_.writeBoolean(param1[0]);
         if(param1[0])
         {
            _loc2_.writeInt(param1[1]);
            _loc2_.writeInt(param1[2]);
            _loc2_.writeInt(param1[3]);
            _loc2_.writeInt(param1[4]);
            _loc2_.writeInt(param1[5]);
            _loc2_.writeInt(param1[6]);
            _loc2_.writeBoolean(param1[7]);
         }
         sendPackage(_loc2_);
      }
      
      public function toKillCrop(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function toHelperRenewMoney(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(81);
         _loc3_.writeByte(8);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function exitFarm(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(16);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function fastForwardGrop(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(81);
         _loc4_.writeByte(18);
         _loc4_.writeBoolean(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function giftPacks(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(20);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getFarmPoultryLevel(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(21);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function initFarmTree() : void
      {
         var _loc1_:PackageOut = new PackageOut(81);
         _loc1_.writeByte(22);
         sendPackage(_loc1_);
      }
      
      public function callFarmPoultry(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(23);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function wakeFarmPoultry(param1:uint) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(24);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function inviteWakeFarmPoultry() : void
      {
         var _loc1_:PackageOut = new PackageOut(81);
         _loc1_.writeByte(34);
         sendPackage(_loc1_);
      }
      
      public function feedFarmPoultry(param1:uint) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(33);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function farmCondenser(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(25);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function farmWater(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(81);
         _loc2_.writeByte(32);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getPlayerPropertyAddition() : void
      {
         var _loc1_:PackageOut = new PackageOut(164);
         sendPackage(_loc1_);
      }
      
      public function enterWorldBossRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(102);
         _loc1_.writeByte(32);
         sendPackage(_loc1_);
      }
      
      public function openOrCloseWorldBossHelper(param1:WorldBossHelperTypeData) : void
      {
         var _loc2_:PackageOut = new PackageOut(102);
         _loc2_.writeByte(39);
         _loc2_.writeByte(param1.requestType);
         if(param1.requestType == 2)
         {
            _loc2_.writeBoolean(param1.isOpen);
            _loc2_.writeInt(param1.buffNum);
            _loc2_.writeInt(param1.type);
            _loc2_.writeInt(param1.openType);
         }
         sendPackage(_loc2_);
      }
      
      public function quitWorldBossHelperView() : void
      {
         var _loc1_:PackageOut = new PackageOut(102);
         _loc1_.writeByte(40);
         _loc1_.writeBoolean(false);
         sendPackage(_loc1_);
      }
      
      public function sendAddPlayer(param1:Point) : void
      {
         var _loc2_:PackageOut = new PackageOut(102);
         _loc2_.writeByte(34);
         _loc2_.writeInt(param1.x);
         _loc2_.writeInt(param1.y);
         sendPackage(_loc2_);
      }
      
      public function sendAddAllWorldBossPlayer() : void
      {
         var _loc1_:PackageOut = new PackageOut(102);
         _loc1_.writeByte(14);
         sendPackage(_loc1_);
      }
      
      public function sendWorldBossRoomMove(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(102);
         _loc4_.writeByte(35);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendWorldBossRoomStauts(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(102);
         _loc2_.writeByte(36);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public function sendLeaveBossRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(102);
         _loc1_.writeByte(33);
         sendPackage(_loc1_);
      }
      
      public function sendBuyWorldBossBuff(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(102);
         _loc2_.writeByte(38);
         _loc2_.writeInt(param1.length);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeInt(param1[_loc3_]);
            _loc3_++;
         }
         sendPackage(_loc2_);
      }
      
      public function sendNewBuyWorldBossBuff(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(102);
         _loc3_.writeByte(38);
         _loc3_.writeInt(1);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendRevertPet(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(18);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function requestForLuckStone() : void
      {
         var _loc1_:PackageOut = new PackageOut(165);
         sendPackage(_loc1_);
      }
      
      public function sendOpenOneTotem(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(136);
         _loc3_.writeBoolean(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendNewChickenBox() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(10);
         sendPackage(_loc1_);
      }
      
      public function sendChickenBoxUseEagleEye(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(87);
         _loc2_.writeByte(11);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendChickenBoxTakeOverCard(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(87);
         _loc2_.writeByte(13);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOverShowItems() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(12);
         sendPackage(_loc1_);
      }
      
      public function sendFlushNewChickenBox() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(14);
         sendPackage(_loc1_);
      }
      
      public function sendClickStartBntNewChickenBox() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(15);
         sendPackage(_loc1_);
      }
      
      public function labyrinthRequestUpdate(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(131);
         _loc2_.writeInt(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function labyrinthCleanOut(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(131);
         _loc2_.writeInt(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function labyrinthSpeededUpCleanOut(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(131);
         _loc3_.writeInt(4);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function labyrinthStopCleanOut(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(131);
         _loc2_.writeInt(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function figSpiritUpGrade(param1:GemstnoeSendInfo) : void
      {
         var _loc2_:PackageOut = new PackageOut(209);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1.autoBuyId);
         _loc2_.writeInt(param1.goodsId);
         _loc2_.writeInt(param1.type);
         _loc2_.writeInt(param1.templeteId);
         _loc2_.writeInt(param1.fightSpiritId);
         _loc2_.writeInt(param1.equipPlayce);
         _loc2_.writeInt(param1.place);
         _loc2_.writeInt(param1.count);
         sendPackage(_loc2_);
      }
      
      public function fightSpiritRequest() : void
      {
         var _loc1_:PackageOut = new PackageOut(209);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function labyrinthCleanOutTimerComplete(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(131);
         _loc2_.writeInt(8);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function labyrinthDouble(param1:int, param2:Boolean) : void
      {
         if(param2 == false)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(131);
         _loc3_.writeInt(1);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function labyrinthReset(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(131);
         _loc2_.writeInt(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function labyrinthTryAgain(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(131);
         _loc4_.writeInt(9);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function getspree(param1:Object) : void
      {
         var _loc2_:PackageOut = new PackageOut(157);
         _loc2_.writeInt(5);
         _loc2_.writeInt(param1.rewardId);
         _loc2_.writeInt(param1.type);
         _loc2_.writeInt(param1.regetType);
         _loc2_.writeInt(param1.time);
         sendPackage(_loc2_);
      }
      
      public function sendHonorUp(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(96);
         _loc3_.writeByte(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBuyPetExpItem(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(68);
         _loc2_.writeByte(19);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOpenKingBless(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(142);
         _loc5_.writeByte(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeUTF(param3);
         _loc5_.writeBoolean(param4);
         _loc5_.writeBoolean(PlayerManager.Instance.kingBuffActivity);
         sendPackage(_loc5_);
      }
      
      public function sendUseItemKingBless(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(143);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendTrusteeshipStart(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(140);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTrusteeshipCancel(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(140);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTrusteeshipSpeedUp(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(140);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendTrusteeshipBuySpirit(param1:Boolean = true) : void
      {
         var _loc2_:PackageOut = new PackageOut(140);
         _loc2_.writeByte(4);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function battleGroundUpdata(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(132);
         _loc2_.writeByte(3);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public function battleGroundPlayerUpdata() : void
      {
         var _loc1_:PackageOut = new PackageOut(132);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendTrusteeshipUseSpiritItem(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(140);
         _loc4_.writeByte(5);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendGetGoods(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(155);
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaBossInfo(param1:int, param2:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(129);
         _loc3_.writeInt(30);
         _loc3_.writeByte(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendLatentEnergy(param1:int, param2:int, param3:int, param4:int = -1, param5:int = -1) : void
      {
         var _loc6_:PackageOut = new PackageOut(133);
         _loc6_.writeByte(param1);
         _loc6_.writeInt(param2);
         _loc6_.writeInt(param3);
         if(param1 == 1)
         {
            _loc6_.writeInt(param4);
            _loc6_.writeInt(param5);
         }
         sendPackage(_loc6_);
      }
      
      public function sendWonderfulActivity(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(159);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function requestWonderfulActInit(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(405);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBattleCompanionGive(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(101);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function addPetEquip(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(68);
         _loc4_.writeByte(20);
         _loc4_.writeInt(param3);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         sendPackage(_loc4_);
      }
      
      public function delPetEquip(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(21);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function necklaceStrength(param1:int, param2:int, param3:int = 2) : void
      {
         var _loc4_:PackageOut = new PackageOut(95);
         _loc4_.writeByte(param3);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param1);
         sendPackage(_loc4_);
      }
      
      public function enterBuried() : void
      {
         var _loc1_:PackageOut = new PackageOut(98);
         _loc1_.writeByte(0);
         sendPackage(_loc1_);
      }
      
      public function rollDice(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(98);
         _loc2_.writeByte(1);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function upgradeStartLevel(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(98);
         _loc2_.writeByte(2);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function refreshMap() : void
      {
         var _loc1_:PackageOut = new PackageOut(98);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function takeCard(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(98);
         _loc2_.writeByte(3);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function outCard() : void
      {
         var _loc1_:PackageOut = new PackageOut(98);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendSearchGoodsGainRewards(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(98);
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsBatRequestPlayerInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(153);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendConsBatMove(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(153);
         _loc4_.writeByte(4);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendConsBatChallenge(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(153);
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsBatExit() : void
      {
         var _loc1_:PackageOut = new PackageOut(153);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendConsBatConsume(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(153);
         _loc3_.writeByte(17);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendConsBatUpdateScore(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(153);
         _loc2_.writeByte(16);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public function enterDayActivity() : void
      {
         var _loc1_:PackageOut = new PackageOut(155);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendConsBatConfirmEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(153);
         _loc1_.writeByte(21);
         sendPackage(_loc1_);
      }
      
      public function sendUpdateSysDate() : void
      {
         var _loc1_:PackageOut = new PackageOut(5);
         sendPackage(_loc1_);
      }
      
      public function sendDragonBoatBuildOrDecorate(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(100);
         _loc4_.writeByte(2);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendDragonBoatRefreshBoatStatus() : void
      {
         var _loc1_:PackageOut = new PackageOut(100);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendDragonBoatRefreshRank() : void
      {
         var _loc1_:PackageOut = new PackageOut(100);
         _loc1_.writeByte(16);
         sendPackage(_loc1_);
      }
      
      public function sendDragonBoatExchange(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(100);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function requestUnWeddingPay(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(207);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function requestShopPay(param1:Array, param2:Array, param3:Array, param4:Array, param5:Array, param6:String, param7:String = "") : void
      {
         var _loc10_:int = 0;
         var _loc9_:int = param1.length;
         var _loc8_:PackageOut = new PackageOut(207);
         _loc8_.writeByte(3);
         _loc8_.writeUTF(param6);
         _loc8_.writeUTF(param7);
         _loc8_.writeInt(_loc9_);
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            _loc8_.writeInt(param1[_loc10_]);
            _loc8_.writeInt(param2[_loc10_]);
            _loc8_.writeInt(param3[_loc10_]);
            _loc8_.writeUTF(param4[_loc10_]);
            _loc8_.writeUTF(param5[_loc10_]);
            _loc10_++;
         }
         sendPackage(_loc8_);
      }
      
      public function requestAuctionPay(param1:int, param2:String, param3:String = "") : void
      {
         var _loc4_:PackageOut = new PackageOut(207);
         _loc4_.writeByte(5);
         _loc4_.writeInt(param1);
         _loc4_.writeUTF(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendWantStrongBack(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(147);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function isAcceptPayShop(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(207);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param2);
         _loc3_.writeBoolean(param1);
         sendPackage(_loc3_);
      }
      
      public function isAcceptPayAuc(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(207);
         _loc3_.writeByte(6);
         _loc3_.writeInt(param2);
         _loc3_.writeBoolean(param1);
         sendPackage(_loc3_);
      }
      
      public function sendForAuction(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(207);
         _loc3_.writeByte(7);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function isAcceptPay(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(207);
         _loc3_.writeByte(2);
         _loc3_.writeInt(param2);
         _loc3_.writeBoolean(param1);
         sendPackage(_loc3_);
      }
      
      public function CampbattleEnterFight(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(146);
         _loc2_.writeByte(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function CampbattleRoleMove(param1:int, param2:int, param3:Point) : void
      {
         var _loc4_:PackageOut = new PackageOut(146);
         _loc4_.writeByte(2);
         _loc4_.writeInt(param3.x);
         _loc4_.writeInt(param3.y);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         sendPackage(_loc4_);
      }
      
      public function changeMap() : void
      {
         var _loc1_:PackageOut = new PackageOut(146);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function outCampBatttle() : void
      {
         var _loc1_:PackageOut = new PackageOut(146);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function captureMap(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(146);
         _loc2_.writeByte(17);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function requestPRankList() : void
      {
         var _loc1_:PackageOut = new PackageOut(146);
         _loc1_.writeByte(21);
         sendPackage(_loc1_);
      }
      
      public function requestCRankList() : void
      {
         var _loc1_:PackageOut = new PackageOut(146);
         _loc1_.writeByte(20);
         sendPackage(_loc1_);
      }
      
      public function enterPTPFight(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(146);
         _loc3_.writeByte(16);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function returnToPve() : void
      {
         var _loc1_:PackageOut = new PackageOut(146);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function resurrect(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(146);
         _loc3_.writeByte(18);
         _loc3_.writeBoolean(param2);
         _loc3_.writeBoolean(param1);
         sendPackage(_loc3_);
      }
      
      public function sendGroupPurchaseRefreshData() : void
      {
         var _loc1_:PackageOut = new PackageOut(144);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function sendGroupPurchaseRefreshRankData() : void
      {
         var _loc1_:PackageOut = new PackageOut(144);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendGroupPurchaseBuy(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(144);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendRegressPkg() : void
      {
         var _loc1_:PackageOut = new PackageOut(149);
         _loc1_.writeByte(0);
         sendPackage(_loc1_);
      }
      
      public function sendRegressGetAwardPkg(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(149);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRegressCheckPlayer(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(149);
         _loc2_.writeByte(2);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRegressApplyEnable() : void
      {
         var _loc1_:PackageOut = new PackageOut(149);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function sendRegressApllyPacks() : void
      {
         var _loc1_:PackageOut = new PackageOut(149);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendRegressCall(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(149);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRegressRecvPacks() : void
      {
         var _loc1_:PackageOut = new PackageOut(149);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendRegressTicketInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(149);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function sendRegressTicket() : void
      {
         var _loc1_:PackageOut = new PackageOut(149);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function sendExpBlessedData() : void
      {
         var _loc1_:PackageOut = new PackageOut(155);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function sendGameTrusteeship(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(91);
         _loc2_.writeByte(149);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendInitTreasueHunting() : void
      {
         var _loc1_:PackageOut = new PackageOut(110);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendPayForHunting(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(110);
         _loc3_.writeByte(2);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function getAllTreasure() : void
      {
         var _loc1_:PackageOut = new PackageOut(110);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function updateTreasureBag() : void
      {
         var _loc1_:PackageOut = new PackageOut(110);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function sendHuntingByScore() : void
      {
         var _loc1_:PackageOut = new PackageOut(110);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendConvertScore(param1:Boolean, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(110);
         _loc4_.writeByte(6);
         _loc4_.writeBoolean(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendSevenDoubleCallCar(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(148);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendSevenDoubleStartGame(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(148);
         _loc2_.writeByte(6);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendSevenDoubleCancelGame() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function sendSevenDoubleReady() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function sendSevenDoubleMove() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(17);
         sendPackage(_loc1_);
      }
      
      public function sendSevenDoubleUseSkill(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(148);
         _loc4_.writeByte(21);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendSevenDoubleCanEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(35);
         sendPackage(_loc1_);
      }
      
      public function sendBuyEnergy(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(105);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendSevenDoubleEnterOrLeaveScene(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(148);
         _loc2_.writeByte(38);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendWonderfulActivityGetReward(param1:Vector.<SendGiftInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(373);
         _loc2_.writeInt(param1.length);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_.writeUTF(param1[_loc4_].activityId);
            _loc2_.writeInt(param1[_loc4_].awardCount);
            _loc2_.writeInt(param1[_loc4_].giftIdArr.length);
            _loc3_ = 0;
            while(_loc3_ < param1[_loc4_].giftIdArr.length)
            {
               if(param1[_loc4_].giftIdArr[_loc3_] is GiftChildInfo)
               {
                  _loc2_.writeUTF(param1[_loc4_].giftIdArr[_loc3_].giftId);
                  _loc2_.writeInt(param1[_loc4_].giftIdArr[_loc3_].index);
               }
               else
               {
                  _loc2_.writeUTF(param1[_loc4_].giftIdArr[_loc3_]);
                  _loc2_.writeInt(0);
               }
               _loc3_++;
            }
            _loc4_++;
         }
         sendPackage(_loc2_);
      }
      
      public function sendRingStationGetInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(404);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendBuyBattleCountOrTime(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(404);
         _loc3_.writeByte(2);
         _loc3_.writeBoolean(param2);
         _loc3_.writeBoolean(param1);
         sendPackage(_loc3_);
      }
      
      public function sendRingStationChallenge(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(404);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendRingStationArmory() : void
      {
         var _loc1_:PackageOut = new PackageOut(404);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendGetRingStationReward() : void
      {
         var _loc1_:PackageOut = new PackageOut(404);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function sendRingStationBattleField() : void
      {
         var _loc1_:PackageOut = new PackageOut(404);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function sendRingStationFightFlag() : void
      {
         var _loc1_:PackageOut = new PackageOut(404);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function sendRouletteRun() : void
      {
         var _loc1_:PackageOut = new PackageOut(110);
         _loc1_.writeByte(17);
         sendPackage(_loc1_);
      }
      
      public function getBackLockPwdByPhone(param1:int, param2:String = "") : void
      {
         var _loc3_:PackageOut = new PackageOut(403);
         _loc3_.writeByte(1);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function getBackLockPwdByQuestion(param1:int, param2:String = "", param3:String = "") : void
      {
         var _loc4_:PackageOut = new PackageOut(403);
         _loc4_.writeByte(2);
         _loc4_.writeInt(param1);
         _loc4_.writeUTF(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function deletePwdQuestion(param1:int, param2:String = "") : void
      {
         var _loc3_:PackageOut = new PackageOut(403);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function deletePwdByPhone(param1:int, param2:String = "") : void
      {
         var _loc3_:PackageOut = new PackageOut(403);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function checkPhoneBind() : void
      {
         var _loc1_:PackageOut = new PackageOut(403);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendActivityDungeonNextPoints(param1:int, param2:Boolean, param3:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(91);
         _loc4_.writeByte(79);
         _loc4_.writeByte(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendButChristmasGoods(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(26);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function enterChristmasRoomIsTrue() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(17);
         _loc1_.writeByte(0);
         sendPackage(_loc1_);
      }
      
      public function enterChristmasRoom(param1:Point) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(17);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1.x);
         _loc2_.writeInt(param1.y);
         sendPackage(_loc2_);
      }
      
      public function enterMakingSnowManRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(24);
         sendPackage(_loc1_);
      }
      
      public function getPacksToPlayer(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(27);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public function sendLeaveChristmasRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(17);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendChristmasRoomMove(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(21);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendChristmasUpGrade(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(25);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendStartFightWithMonster(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(22);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBuyPlayingSnowmanVolumes(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(29);
         sendPackage(_loc2_);
      }
      
      public function sendLanternRiddlesQuestion() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(38);
         sendPackage(_loc1_);
      }
      
      public function sendLanternRiddlesAnswer(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(40);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendLanternRiddlesUseSkill(param1:int, param2:int, param3:int, param4:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(145);
         _loc5_.writeByte(41);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function sendLanternRiddlesRankInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(42);
         sendPackage(_loc1_);
      }
      
      public function getRedPacketInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(8);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function getBuyinfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(10);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function buybuybuy(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(84);
         _loc5_.writeInt(10);
         _loc5_.writeInt(3);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function getRedPacketpublish(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(84);
         _loc4_.writeInt(8);
         _loc4_.writeInt(6);
         _loc4_.writeUTF(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function getRedFightKingScore() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(9);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function getRedPacketRecord(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(8);
         _loc2_.writeInt(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getRobRedPacket(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(8);
         _loc2_.writeInt(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendCatchBeastViewInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(33);
         sendPackage(_loc1_);
      }
      
      public function sendCatchBeastChallenge() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(34);
         sendPackage(_loc1_);
      }
      
      public function sendCatchBeastBuyBuff(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(35);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendCatchBeastGetAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(36);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAccumulativeLoginAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(238);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAvatarCollectionActive(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(402);
         _loc5_.writeByte(3);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function sendAvatarCollectionDelayTime(param1:int, param2:int, param3:int) : void
      {
         trace("----------------id:",param1,"count:",param2);
         var _loc4_:PackageOut = new PackageOut(402);
         _loc4_.writeByte(4);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function setCurrentModel(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(237);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function saveDressModel(param1:int, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageOut = new PackageOut(237);
         _loc3_.writeByte(1);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2.length);
         _loc4_ = 0;
         while(_loc4_ <= param2.length - 1)
         {
            _loc3_.writeInt(0);
            _loc3_.writeInt(param2[_loc4_]);
            _loc4_++;
         }
         sendPackage(_loc3_);
      }
      
      public function foldDressItem(param1:Array, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         if(param1.length > 100)
         {
            _loc4_ = param1.splice(0,100);
            foldDressItem(_loc4_,param2,param3);
            foldDressItem(param1,param2,param3);
            return;
         }
         var _loc5_:PackageOut = new PackageOut(param2);
         _loc5_.writeByte(param3);
         _loc5_.writeInt(param1.length);
         _loc6_ = 0;
         while(_loc6_ <= param1.length - 1)
         {
            _loc5_.writeInt(param1[_loc6_].sPlace);
            _loc5_.writeInt(param1[_loc6_].tPlace);
            _loc6_++;
         }
         sendPackage(_loc5_);
      }
      
      public function lockDressBag() : void
      {
         var _loc1_:PackageOut = new PackageOut(237);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function receiveLandersAward() : void
      {
         var _loc1_:PackageOut = new PackageOut(404);
         _loc1_.writeByte(49);
         sendPackage(_loc1_);
      }
      
      public function getFlowerRankInfo(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(257);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendGetFlowerReward(param1:int, param2:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(257);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function getFlowerRewardStatus() : void
      {
         var _loc1_:PackageOut = new PackageOut(257);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function sendFlower(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(257);
         _loc4_.writeByte(1);
         _loc4_.writeUTF(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendFlowerRecord() : void
      {
         var _loc1_:PackageOut = new PackageOut(257);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendUpdateIntegral() : void
      {
         var _loc1_:PackageOut = new PackageOut(149);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function sendBuyRegressIntegralGoods(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(149);
         _loc3_.writeByte(10);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPlayerExit(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(262);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOtherPlayerInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(262);
         _loc1_.writeByte(0);
         sendPackage(_loc1_);
      }
      
      public function sendPlayerPos(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(262);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendAddNewPlayer(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(262);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendModifyNewPlayerDress() : void
      {
         var _loc1_:PackageOut = new PackageOut(262);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendUpdatePets(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(262);
         _loc4_.writeByte(9);
         _loc4_.writeBoolean(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendNewHallPlayerHid(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(262);
         _loc2_.writeByte(7);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendNewHallBattle() : void
      {
         var _loc1_:PackageOut = new PackageOut(262);
         _loc1_.writeByte(99);
         sendPackage(_loc1_);
      }
      
      public function sendLoadOtherPlayer() : void
      {
         var _loc1_:PackageOut = new PackageOut(262);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function sendHorseChangeHorse(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(260);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendActiveHorsePicCherish(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(260);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHorseUpHorse(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(260);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHorseUpSkill(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(260);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendHorseTakeUpDownSkill(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(260);
         _loc3_.writeByte(6);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBallteHorseTakeUpDownSkill(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(260);
         _loc3_.writeByte(10);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBombKingStartBattle() : void
      {
         var _loc1_:PackageOut = new PackageOut(263);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function updateBombKingMainFrame() : void
      {
         var _loc1_:PackageOut = new PackageOut(263);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function updateBombKingRank(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(263);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function updateBombKingBattleLog() : void
      {
         var _loc1_:PackageOut = new PackageOut(263);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function updateBKingItemEquip(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(263);
         _loc4_.writeByte(1);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function getBKingStatueInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(263);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function requestBKingShowTip() : void
      {
         var _loc1_:PackageOut = new PackageOut(263);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function sendCollectionSceneEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(261);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendCollectionSceneMove(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(261);
         _loc4_.writeByte(2);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function sendCollectionComplete(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(261);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendLeaveCollectionScene() : void
      {
         var _loc1_:PackageOut = new PackageOut(261);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function sendPetRisingStar(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(68);
         _loc4_.writeByte(22);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendPetEvolution(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(23);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPetFormInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(68);
         _loc1_.writeByte(24);
         sendPackage(_loc1_);
      }
      
      public function sendPetFollowOrCall(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(25);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPetWake(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(68);
         _loc2_.writeByte(32);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUsePetTemporaryCard(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(68);
         _loc3_.writeByte(35);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendPetBreak(param1:int, param2:Boolean, param3:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:PackageOut = new PackageOut(68);
         _loc4_.writeByte(31);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc5_ = 0;
         while(_loc5_ < param3.length)
         {
            _loc4_.writeInt(param3[_loc5_]);
            _loc5_++;
         }
         sendPackage(_loc4_);
      }
      
      public function sendBreakInfoRequire(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(68);
         _loc2_.writeByte(34);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEscortCallCar(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(148);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendEscortStartGame(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(148);
         _loc2_.writeByte(6);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEscortCancelGame() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function sendEscortReady() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function sendEscortMove() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(17);
         sendPackage(_loc1_);
      }
      
      public function sendEscortUseSkill(param1:int, param2:Boolean, param3:Boolean, param4:int = 0, param5:int = -1) : void
      {
         var _loc6_:PackageOut = new PackageOut(148);
         _loc6_.writeByte(21);
         _loc6_.writeInt(param1);
         _loc6_.writeBoolean(param2);
         _loc6_.writeBoolean(param3);
         _loc6_.writeInt(param4);
         _loc6_.writeInt(param5);
         sendPackage(_loc6_);
      }
      
      public function sendEscortCanEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(35);
         sendPackage(_loc1_);
      }
      
      public function sendEscortEnterOrLeaveScene(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(148);
         _loc2_.writeByte(38);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPeerID(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(272);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function exploreMagicStone(param1:int, param2:Boolean, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(258);
         _loc4_.writeByte(1);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function getMagicStoneScore() : void
      {
         var _loc1_:PackageOut = new PackageOut(258);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function convertMgStoneScore(param1:int, param2:Boolean = true, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(258);
         _loc4_.writeByte(5);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function moveMagicStone(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(258);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function lockMagicStone(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(258);
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function updateMagicStone(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(258);
         _loc3_.writeByte(2);
         _loc3_.writeInt(param1.length);
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeInt(_loc2_);
         }
         sendPackage(_loc3_);
      }
      
      public function sortMgStoneBag(param1:Array, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageOut = new PackageOut(258);
         _loc3_.writeByte(9);
         _loc3_.writeInt(param1.length);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.writeInt(param1[_loc4_].Place);
            _loc3_.writeInt(_loc4_ + param2);
            _loc4_++;
         }
         sendPackage(_loc3_);
      }
      
      public function updateRemainCount() : void
      {
         var _loc1_:PackageOut = new PackageOut(258);
         _loc1_.writeByte(16);
         sendPackage(_loc1_);
      }
      
      public function updateConsumeRank() : void
      {
         var _loc1_:PackageOut = new PackageOut(259);
         sendPackage(_loc1_);
      }
      
      public function updateRechargeRank() : void
      {
         var _loc1_:PackageOut = new PackageOut(352);
         sendPackage(_loc1_);
      }
      
      public function cooking(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(274);
         if(param1 == 1)
         {
            _loc2_.writeByte(FoodActivityEvent.SIMPLE_COOKING);
         }
         else
         {
            _loc2_.writeByte(FoodActivityEvent.PAY_COOKING);
         }
         sendPackage(_loc2_);
      }
      
      public function cookingGetAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(274);
         _loc2_.writeByte(FoodActivityEvent.REWARD);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function updateCookingCountByTime() : void
      {
         var _loc1_:PackageOut = new PackageOut(274);
         _loc1_.writeByte(FoodActivityEvent.UPDATE_COUNT_BYTIME);
         sendPackage(_loc1_);
      }
      
      public function updateDrgnBoatBuildInfo(param1:int = 0) : void
      {
         var _loc2_:PackageOut = new PackageOut(148);
         _loc2_.writeByte(49);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function commitDrgnBoatMaterial(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(148);
         _loc2_.writeByte(50);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function helpToBuildDrgnBoat(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(148);
         _loc2_.writeByte(51);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function broadcastMissileMC() : void
      {
         var _loc1_:PackageOut = new PackageOut(148);
         _loc1_.writeByte(43);
         sendPackage(_loc1_);
      }
      
      public function enterMagpieBridge() : void
      {
         var _loc1_:PackageOut = new PackageOut(276);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function magpieRollDice() : void
      {
         var _loc1_:PackageOut = new PackageOut(276);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function buyMagpieCount(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(276);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function refreshMagpieView() : void
      {
         var _loc1_:PackageOut = new PackageOut(276);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function exitMagpieView() : void
      {
         var _loc1_:PackageOut = new PackageOut(276);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendCryptBossFight(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(275);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendGetShopBuyLimitedCount() : void
      {
         var _loc1_:PackageOut = new PackageOut(288);
         sendPackage(_loc1_);
      }
      
      public function requestRescueItemInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(277);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function requestRescueFrameInfo(param1:int = 0) : void
      {
         var _loc2_:PackageOut = new PackageOut(277);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRescueChallenge(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(277);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRescueCleanCD(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(277);
         _loc3_.writeByte(5);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendRescueBuyBuff(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(277);
         _loc4_.writeByte(4);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function useRescueKingBless() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(94);
         sendPackage(_loc1_);
      }
      
      public function getRescuePrize(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(277);
         _loc3_.writeByte(8);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function enterOrLeaveInsectScene(param1:int, param2:Point = null) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(143);
         _loc3_.writeByte(param1);
         if(param2)
         {
            _loc3_.writeInt(param2.x);
            _loc3_.writeInt(param2.y);
         }
         sendPackage(_loc3_);
      }
      
      public function sendFightWithInsect(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(140);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendInsectSceneMove(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(141);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeUTF(param3);
         sendPackage(_loc4_);
      }
      
      public function updateInsectInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(135);
         sendPackage(_loc1_);
      }
      
      public function updateInsectAreaRank() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(137);
         sendPackage(_loc1_);
      }
      
      public function updateInsectAreaSelfInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(132);
         sendPackage(_loc1_);
      }
      
      public function updateInsectLocalRank() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(136);
         sendPackage(_loc1_);
      }
      
      public function updateInsectLocalSelfInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(138);
         sendPackage(_loc1_);
      }
      
      public function getInsectPrize(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(139);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function requestCakeStatus() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(134);
         sendPackage(_loc1_);
      }
      
      public function requestInsectWhistleUse(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(154);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function requestInsectWhistleBuy(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(155);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function showHideTitleState(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(279);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEnchant(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(280);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function getNationDayInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(288);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function exchangeNationalGoods(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(288);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getHalloweenViewInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(283);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function getHalloweenExchangeViewInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(283);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function getHalloweenExchange(param1:int, param2:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(283);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function getHalloweenSetExchange() : void
      {
         var _loc1_:PackageOut = new PackageOut(283);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function getHalloweenCandyNum() : void
      {
         var _loc1_:PackageOut = new PackageOut(283);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function requestRookieRankInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(286);
         sendPackage(_loc1_);
      }
      
      public function sendBuyLevelFund(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(290);
         _loc3_.writeByte(2);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendGetLevelFundAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(290);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOpenDailyView() : void
      {
         var _loc1_:PackageOut = new PackageOut(293);
         sendPackage(_loc1_);
      }
      
      public function sendForgeSuit(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(295);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getHomeTempleLevel() : void
      {
         var _loc1_:PackageOut = new PackageOut(297);
         _loc1_.writeByte(0);
         sendPackage(_loc1_);
      }
      
      public function setHomeTempleSelectIndex(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(297);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function setHomeTempleImmolation(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(297);
         _loc3_.writeByte(1);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function wishingTreeSendWish(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(299);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function wishingTreeUpdateFrame() : void
      {
         var _loc1_:PackageOut = new PackageOut(299);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function arrange(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(135);
         _loc2_.writeInt(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function enterTreasure() : void
      {
         var _loc1_:PackageOut = new PackageOut(135);
         _loc1_.writeInt(0);
         sendPackage(_loc1_);
      }
      
      public function startTreasure() : void
      {
         var _loc1_:PackageOut = new PackageOut(135);
         _loc1_.writeInt(6);
         sendPackage(_loc1_);
      }
      
      public function endTreasure() : void
      {
         var _loc1_:PackageOut = new PackageOut(135);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function doTreasure(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(135);
         _loc2_.writeInt(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function wishingTreeGetReward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(299);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function wishingTreeGetRecord() : void
      {
         var _loc1_:PackageOut = new PackageOut(299);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function enterPyramid() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function getVipIntegralShopLimit() : void
      {
         var _loc1_:PackageOut = new PackageOut(312);
         sendPackage(_loc1_);
      }
      
      public function buyVipIntegralShopGoods(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(311);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function uploadDraftStyle(param1:String, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(310);
         _loc3_.writeUTF(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function getPlayerSpecialProperty(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(321);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDraftVoteTicket(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(309);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function getToyMachineInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(324);
         sendPackage(_loc1_);
      }
      
      public function sendToyMachineReward(param1:int, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(326);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeBoolean(param3);
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function happyRechargeEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(179);
         sendPackage(_loc1_);
      }
      
      public function happyRechargeStartLottery() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(176);
         sendPackage(_loc1_);
      }
      
      public function happyRechargeExchange(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(177);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function happyRechargeQuestGetItem(param1:int = 2) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(181);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendMemoryGameInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(11);
         sendPackage(_loc1_);
      }
      
      public function sendMemoryGameTurnover(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(12);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendMemoryGameReset(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(13);
         _loc3_.writeBoolean(param2);
         _loc3_.writeBoolean(param1);
         sendPackage(_loc3_);
      }
      
      public function sendMemoryGameBuy(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(14);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendMemoryGameGetReward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(16);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGuardCoreLevelUp() : void
      {
         var _loc1_:PackageOut = new PackageOut(336);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendGuardCoreEquip(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(336);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getVipAndMerryInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(169);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEnterGame() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(CloudBuyLotteryPackageType.Enter_GAME);
         sendPackage(_loc1_);
      }
      
      public function sendYGBuyGoods(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(CloudBuyLotteryPackageType.BUY_GOODS);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendLuckDrawGo() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(CloudBuyLotteryPackageType.GET_REWARD);
         sendPackage(_loc1_);
      }
      
      public function makeNewYearRice(param1:int, param2:int, param3:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(167);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         if(param1 != 0)
         {
            _loc4_.writeInt(param3.length);
            _loc5_ = 0;
            while(_loc5_ < param3.length)
            {
               _loc4_.writeInt(param3[_loc5_].id);
               _loc4_.writeInt(param3[_loc5_].number);
               _loc5_++;
            }
         }
         sendPackage(_loc4_);
      }
      
      public function sendCheckNewYearRiceInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(162);
         sendPackage(_loc1_);
      }
      
      public function sendCheckMakeNewYearFood() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(163);
         sendPackage(_loc1_);
      }
      
      public function sendNewYearRiceOpen(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(165);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendExitYearFoodRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(166);
         sendPackage(_loc1_);
      }
      
      public function sendInviteYearFoodRoom(param1:Boolean, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(164);
         _loc4_.writeBoolean(param1);
         if(!param1)
         {
            _loc4_.writeBoolean(param3);
         }
         _loc4_.writeInt(param2);
         sendPackage(_loc4_);
      }
      
      public function sendQuitNewYearRiceRoom(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(168);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function clickAnotherDimensionEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(7);
         _loc1_.writeInt(3);
         sendPackage(_loc1_);
      }
      
      public function clickAnotherDimenZhanling(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(7);
         _loc2_.writeInt(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function clickAnotherDimenSearch() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(7);
         _loc1_.writeInt(4);
         sendPackage(_loc1_);
      }
      
      public function clickAnotherDimenUpgrade(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(84);
         _loc3_.writeInt(7);
         _loc3_.writeInt(6);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function treasurePuzzle_enter() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(103);
         sendPackage(_loc1_);
      }
      
      public function treasurePuzzle_seeReward() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(104);
         sendPackage(_loc1_);
      }
      
      public function treasurePuzzle_getReward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(105);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function treasurePuzzle_savePlayerInfo(param1:String, param2:String, param3:String, param4:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(145);
         _loc5_.writeByte(107);
         _loc5_.writeUTF(param1);
         _loc5_.writeUTF(param2);
         _loc5_.writeUTF(param3);
         _loc5_.writeInt(param4);
         sendPackage(_loc5_);
      }
      
      public function treasurePuzzle_usePice(param1:int, param2:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(106);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function petIslandInit(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(187);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function redEnvelopeListInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(2184);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendRedEnvelope(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(2184);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getRedEnvelope(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(2184);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function redEnvelopeInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(2184);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function buyLotteryTicket(param1:int, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:PackageOut = new PackageOut(84);
         _loc4_.writeInt(13);
         _loc4_.writeInt(1);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2.length);
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc3_ = param2[_loc5_].ticketArr.join("");
            _loc4_.writeUTF(_loc3_);
            _loc5_++;
         }
         sendPackage(_loc4_);
      }
      
      public function updataLotteryPool() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(13);
         _loc1_.writeInt(3);
         sendPackage(_loc1_);
      }
      
      public function getLotteryPrizeInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(13);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function sendSignMsg(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(404);
         _loc2_.writeByte(7);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function petIslandBuyBlood(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(188);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function petIslandPlay(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(189);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendEntertainment() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(71);
         sendPackage(_loc1_);
      }
      
      public function buyEntertainment(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(72);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function petIslandPrize(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(190);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function eatPetsHandler(param1:int, param2:int, param3:int, param4:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:PackageOut = new PackageOut(68);
         _loc5_.writeByte(33);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(param2);
         if(param2 == 1)
         {
            _loc5_.writeInt(param4.length);
            _loc6_ = 0;
            while(_loc6_ < param4.length)
            {
               _loc5_.writeInt(param4[_loc6_][0]);
               _loc5_.writeInt(param4[_loc6_][1].TemplateID);
               _loc6_++;
            }
         }
         else
         {
            _loc5_.writeInt(param3);
         }
         sendPackage(_loc5_);
      }
      
      public function sendCheckMagicStoneNumber() : void
      {
         var _loc1_:PackageOut = new PackageOut(284);
         sendPackage(_loc1_);
      }
      
      public function sendOpenDeed(param1:int, param2:int, param3:String, param4:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(142);
         _loc5_.writeByte(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeUTF(param3);
         _loc5_.writeBoolean(param4);
         sendPackage(_loc5_);
      }
      
      public function sendUseItemDeed(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(143);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function prayIndianaEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(171);
         sendPackage(_loc1_);
      }
      
      public function prayIndianaLottery() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(173);
         sendPackage(_loc1_);
      }
      
      public function prayIndianaGoodsRefresh() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(172);
         sendPackage(_loc1_);
      }
      
      public function prayIndianaPray(param1:int, param2:Number = 0.0, param3:Number = 0.0, param4:Number = 0.0) : void
      {
         var _loc5_:PackageOut = new PackageOut(145);
         _loc5_.writeByte(174);
         _loc5_.writeInt(param1);
         if(param1 == 2)
         {
            _loc5_.writeInt(param2 * 1000);
            _loc5_.writeInt(param3 * 1000);
            _loc5_.writeInt(param4 * 1000);
         }
         sendPackage(_loc5_);
      }
      
      public function sendGetCSMTimeBox() : void
      {
         var _loc1_:PackageOut = new PackageOut(360);
         sendPackage(_loc1_);
      }
      
      public function sendLuckyStarEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(31);
         sendPackage(_loc1_);
      }
      
      public function sendLuckyStarClose() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(32);
         sendPackage(_loc1_);
      }
      
      public function sendLuckyStarTurnComplete() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(34);
         sendPackage(_loc1_);
      }
      
      public function sendLuckyStarTurn() : void
      {
         var _loc1_:PackageOut = new PackageOut(87);
         _loc1_.writeByte(33);
         sendPackage(_loc1_);
      }
      
      public function enterGodsRoads() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(87);
         sendPackage(_loc1_);
      }
      
      public function getGodsRoadsAwards(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(88);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendChickActivationOpenKey(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(2);
         _loc2_.writeInt(1);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function sendChickActivationGetAward(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(84);
         _loc3_.writeInt(2);
         _loc3_.writeInt(2);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendChickActivationQuery() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(2);
         _loc1_.writeInt(3);
         sendPackage(_loc1_);
      }
      
      public function DDPlayEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(75);
         sendPackage(_loc1_);
      }
      
      public function DDPlayStart() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(76);
         sendPackage(_loc1_);
      }
      
      public function DDPlayExchange(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(77);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUseEveryDayGiftRecord(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(84);
         _loc4_.writeInt(3);
         _loc4_.writeInt(2);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function openMagicLib(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(84);
         _loc3_.writeInt(4);
         _loc3_.writeInt(1);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function magicLibLevelUp(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(84);
         _loc3_.writeInt(4);
         _loc3_.writeInt(2);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function magicLibFreeGet(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(4);
         _loc2_.writeInt(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function magicLibChargeGet(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(4);
         _loc2_.writeInt(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function magicOpenDepot(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(84);
         _loc3_.writeInt(4);
         _loc3_.writeInt(5);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function magicboxExtraction(param1:int, param2:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(84);
         _loc3_.writeInt(4);
         _loc3_.writeInt(6);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function magicboxFusion(param1:int, param2:int = 1, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(84);
         _loc4_.writeInt(4);
         _loc4_.writeInt(7);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function zodiacRolling() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(6);
         _loc1_.writeInt(1);
         sendPackage(_loc1_);
      }
      
      public function zodiacGetAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(6);
         _loc2_.writeInt(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function zodiacGetAwardAll() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(6);
         _loc1_.writeInt(3);
         sendPackage(_loc1_);
      }
      
      public function zodiacAddCounts(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(6);
         _loc2_.writeInt(4);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function enterSuperWinner() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(49);
         sendPackage(_loc1_);
      }
      
      public function rollDiceInSuperWinner() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(50);
         sendPackage(_loc1_);
      }
      
      public function outSuperWinner() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(51);
         sendPackage(_loc1_);
      }
      
      public function witchBlessing_enter(param1:int = 0) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(113);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendWitchBless(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(114);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendWitchGetAwards(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(112);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sevenDayTarget_enter(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(81);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function newPlayerReward_enter() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(97);
         sendPackage(_loc1_);
      }
      
      public function sevenDayTarget_getReward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(82);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function newPlayerReward_getReward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(98);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHorseRaceItemUse(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:int = getTimer();
         var _loc7_:int = _loc6_ - HorseRaceManager.Instance.buffCD;
         if(_loc7_ < 1000)
         {
            return;
         }
         var _loc5_:PackageOut = new PackageOut(282);
         _loc5_.writeInt(param1);
         _loc5_.writeInt(1);
         _loc5_.writeInt(param2);
         _loc5_.writeInt(param3);
         _loc5_.writeInt(param4);
         _loc5_.writeInt(5);
         sendPackage(_loc5_);
         HorseRaceManager.Instance.buffCD = getTimer();
      }
      
      public function sendHorseRaceItemUse2(param1:int, param2:int) : void
      {
         var _loc4_:int = getTimer();
         var _loc5_:int = _loc4_ - HorseRaceManager.Instance.buffCD;
         if(_loc5_ < 1000)
         {
            return;
         }
         var _loc3_:PackageOut = new PackageOut(282);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(2);
         _loc3_.writeInt(param2);
         _loc3_.writeInt(5);
         sendPackage(_loc3_);
         HorseRaceManager.Instance.buffCD = getTimer();
      }
      
      public function sendHorseRaceEnd(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(282);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(3);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function buyHorseRaceCount() : void
      {
         var _loc1_:PackageOut = new PackageOut(282);
         _loc1_.writeInt(0);
         _loc1_.writeInt(4);
         sendPackage(_loc1_);
      }
      
      public function sendBoguAdventureEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(90);
         sendPackage(_loc1_);
      }
      
      public function sendBoguAdventureWalkInfo(param1:int, param2:int = 0, param3:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(145);
         _loc4_.writeByte(91);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param3);
         if(param1 != 3)
         {
            _loc4_.writeInt(param2);
         }
         sendPackage(_loc4_);
      }
      
      public function sendBoguAdventureUpdateGame(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(92);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBoguAdventureAcquireAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(145);
         _loc2_.writeByte(93);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOutBoguAdventure() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(94);
         sendPackage(_loc1_);
      }
      
      public function sendGuildMemberWeekStarEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function sendGuildMemberWeekStarClose() : void
      {
         var _loc1_:PackageOut = new PackageOut(145);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function sendGuildMemberWeekAddRanking(param1:Array) : void
      {
         var _loc4_:* = 0;
         var _loc2_:int = param1.length;
         var _loc3_:PackageOut = new PackageOut(145);
         _loc3_.writeByte(10);
         _loc3_.writeInt(_loc2_);
         _loc4_ = uint(0);
         while(_loc4_ < _loc2_)
         {
            _loc3_.writeInt(param1[_loc4_]);
            _loc4_++;
         }
         sendPackage(_loc3_);
      }
      
      public function sendDaySign(param1:Date) : void
      {
         var _loc2_:PackageOut = new PackageOut(13);
         _loc2_.writeInt(6);
         _loc2_.writeDate(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGetCardSoul() : void
      {
         var _loc1_:PackageOut = new PackageOut(216);
         _loc1_.writeInt(8);
         sendPackage(_loc1_);
      }
      
      public function sendGrowthPackageOpen(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(1);
         _loc2_.writeInt(1);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGrowthPackageGetItems(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(1);
         _loc2_.writeInt(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendFastAuctionBugle(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(327);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function queryDDQiYuanMyInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(39);
         sendPackage(_loc1_);
      }
      
      public function queryDDQiYuanRankRewardConfig() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(33);
         sendPackage(_loc1_);
      }
      
      public function sendDDQiYuanOfferTimes(param1:int, param2:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(329);
         _loc3_.writeByte(38);
         _loc3_.writeInt(param1);
         _loc3_.writeBoolean(param2);
         sendPackage(_loc3_);
      }
      
      public function sendDDQiYuanOpenTreasureBox(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(34);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function queryDDQiYuanAreaRank(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(37);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function queryDDQiYuanTowerTask() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(35);
         sendPackage(_loc1_);
      }
      
      public function getDDQiYuanTowerTaskReward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(36);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getDDQiYuanJoinReward() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(51);
         sendPackage(_loc1_);
      }
      
      public function sendAngelInvestmentUpdate() : void
      {
         var _loc1_:PackageOut = new PackageOut(357);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function loginDeviceSendUaToCheck(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(11);
         _loc2_.writeInt(1);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function loginDeviceGetDownReward() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(11);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function loginDeviceGetDailyReward() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(11);
         _loc1_.writeInt(3);
         sendPackage(_loc1_);
      }
      
      public function sendAngelInvestmentBuyOne(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:PackageOut = new PackageOut(357);
         _loc3_.writeByte(2);
         _loc3_.writeBoolean(param2);
         _loc3_.writeInt(param1);
         sendPackage(_loc3_);
      }
      
      public function sendAngelInvestmentGainOne(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(357);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAngelInvestmentGainAll() : void
      {
         var _loc1_:PackageOut = new PackageOut(357);
         _loc1_.writeByte(5);
         sendPackage(_loc1_);
      }
      
      public function sendAngelInvestmentBuyAll(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(357);
         _loc2_.writeByte(3);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBombTurnTableLottery() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(54);
         sendPackage(_loc1_);
      }
      
      public function requestBombTurnTableData() : void
      {
         var _loc1_:PackageOut = new PackageOut(329);
         _loc1_.writeByte(53);
         sendPackage(_loc1_);
      }
      
      public function sendWasteRecycleStartTurn() : void
      {
         var _loc1_:PackageOut = new PackageOut(346);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendWasteRecycleEnter() : void
      {
         var _loc1_:PackageOut = new PackageOut(346);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendWasteRecycleGoods(param1:int = 1) : void
      {
         var _loc2_:PackageOut = new PackageOut(346);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function queryOnlineRewardInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(353);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function getOnlineReward() : void
      {
         var _loc1_:PackageOut = new PackageOut(353);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function queryOnlineRewardBoxConfig() : void
      {
         var _loc1_:PackageOut = new PackageOut(353);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function queryConsortionCallBackInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(343);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function getConsortionCallBackAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(343);
         _loc2_.writeByte(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function BuyCallFund() : void
      {
         var _loc1_:PackageOut = new PackageOut(343);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function getCallFund() : void
      {
         var _loc1_:PackageOut = new PackageOut(343);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function queryCallFundInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(343);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function buyCallLotteryDrawGood(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(343);
         _loc4_.writeByte(4);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function refreshCallLotteryDrawInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(343);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function queryCallLotteryDrawGoods(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(343);
         _loc2_.writeByte(9);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function inspire(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(368);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function exchangeScore(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(368);
         _loc4_.writeByte(6);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function cityBattleInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(368);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function cityBattleScore() : void
      {
         var _loc1_:PackageOut = new PackageOut(368);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function cityBattleJoin(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(368);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function cityBattleRank() : void
      {
         var _loc1_:PackageOut = new PackageOut(368);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function cityBattleExchange(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(368);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendGainOldPlayerGift() : void
      {
         var _loc1_:PackageOut = new PackageOut(343);
         _loc1_.writeByte(10);
         sendPackage(_loc1_);
      }
      
      public function getSignBuff(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(12);
         _loc2_.writeInt(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function enterDemonChiYouScene() : void
      {
         var _loc1_:PackageOut = new PackageOut(314);
         _loc1_.writeByte(0);
         sendPackage(_loc1_);
      }
      
      public function getDemonChiYouOtherPlayerInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(314);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function leaveDemonChiYouScene() : void
      {
         var _loc1_:PackageOut = new PackageOut(314);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function buyDemonChiYouRoll(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(314);
         _loc2_.writeByte(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function buyDemonChiYouShopItem(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(314);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getDemonChiYouRankInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(314);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function getDemonChiYouBossInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(314);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function getDemonChiYouShopInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(314);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function requestCardAchievement() : void
      {
         var _loc1_:PackageOut = new PackageOut(362);
         sendPackage(_loc1_);
      }
      
      public function sendCardAchievementType(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(361);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDDTKingGradeInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(370);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendDDTKingGradeReset(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(370);
         _loc3_.writeByte(2);
         _loc3_.writeBoolean(param1);
         _loc3_.writeByte(param2);
         sendPackage(_loc3_);
      }
      
      public function sendDDTKingGradeUp(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(370);
         _loc2_.writeByte(1);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPetsAwaken() : void
      {
         var _loc1_:PackageOut = new PackageOut(68);
         _loc1_.writeByte(37);
         sendPackage(_loc1_);
      }
      
      public function getConsortiaDomainOtherPlayerInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function leaveConsortiaDomainScene() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function getConsortiaDomainMonsterInfoInFight() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function getConsortiaDomainBuildInfoInFight() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(10);
         sendPackage(_loc1_);
      }
      
      public function getConsortiaDomainConsortiaInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(12);
         sendPackage(_loc1_);
      }
      
      public function sendConsortiaDomainMove(param1:Array) : void
      {
         var _loc3_:PackageOut = new PackageOut(371);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1.length);
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.writeInt(_loc2_.x);
            _loc3_.writeInt(_loc2_.y);
         }
         sendPackage(_loc3_);
      }
      
      public function sendConsortiaDomainFight(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(371);
         _loc2_.writeByte(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaDomainActive() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function sendConsortiaDomainRepair(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(371);
         _loc2_.writeByte(8);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function getConsortiaDomainKillInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(13);
         sendPackage(_loc1_);
      }
      
      public function getConsortiaDomainActiveState() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(15);
         sendPackage(_loc1_);
      }
      
      public function getSevendayProgressCount() : void
      {
         var _loc1_:PackageOut = new PackageOut(363);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function getConsortiaDomainBuildRepairInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(371);
         _loc1_.writeByte(17);
         sendPackage(_loc1_);
      }
      
      public function sendQuestionAwardAnswer(param1:String) : void
      {
         var _loc2_:PackageOut = new PackageOut(329);
         _loc2_.writeByte(64);
         _loc2_.writeUTF(param1);
         sendPackage(_loc2_);
      }
      
      public function requestAwardItem() : void
      {
         var _loc1_:PackageOut = new PackageOut(618);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendRollDice(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(618);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBombPos(param1:int, param2:int, param3:int, param4:Boolean, param5:Array, param6:Array) : void
      {
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc15_:* = null;
         var _loc13_:* = null;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         var _loc9_:PackageOut = new PackageOut(372);
         _loc9_.writeByte(3);
         _loc9_.writeInt(param1);
         _loc9_.writeInt(param2);
         _loc9_.writeInt(param3);
         _loc9_.writeBoolean(param4);
         var _loc14_:String = "";
         if(param4 && param5 != null)
         {
            _loc12_ = 0;
            while(_loc12_ < 10)
            {
               _loc11_ = 0;
               while(_loc11_ < 10)
               {
                  _loc9_.writeByte(param5[_loc12_][_loc11_]);
                  _loc14_ = _loc14_ + (param5[_loc12_][_loc11_] + " ,");
                  _loc11_++;
               }
               _loc12_++;
            }
         }
         if(param4 && param6 != null)
         {
            _loc10_ = param6.length;
            _loc9_.writeByte(_loc10_);
            _loc13_ = "爆炸的个数：" + _loc10_;
            _loc7_ = "";
            _loc8_ = 0;
            while(_loc8_ < _loc10_)
            {
               _loc15_ = param6[_loc8_];
               _loc9_.writeByte(_loc15_.vx);
               _loc9_.writeByte(_loc15_.vy);
               _loc9_.writeByte(_loc15_.order);
               _loc8_++;
            }
         }
         sendPackage(_loc9_);
      }
      
      public function sendHappyMiniGameActiveData() : void
      {
         var _loc1_:PackageOut = new PackageOut(372);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function sendBombStart(param1:int) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:PackageOut = new PackageOut(372);
         _loc3_.writeByte(2);
         _loc3_.writeInt(param1);
         var _loc2_:String = "";
         if(param1 == 1)
         {
            _loc4_ = HappyLittleGameManager.instance.bombManager.model.BombTrain;
            _loc6_ = 0;
            while(_loc6_ < 10)
            {
               _loc5_ = 0;
               while(_loc5_ < 10)
               {
                  _loc3_.writeInt(_loc4_[_loc6_][_loc5_]);
                  _loc2_ = _loc2_ + (_loc4_[_loc6_][_loc5_] + " ,");
                  _loc5_++;
               }
               _loc6_++;
            }
         }
         sendPackage(_loc3_);
      }
      
      public function sendBombEnterRoom(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(372);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBombGameRank(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(372);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBombGameOver() : void
      {
         var _loc1_:PackageOut = new PackageOut(372);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function sendBombGameNext() : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:PackageOut = new PackageOut(372);
         _loc2_.writeByte(6);
         _loc2_.writeInt(HappyLittleGameManager.instance.currentGameType);
         var _loc1_:String = "";
         if(HappyLittleGameManager.instance.currentGameType == 1)
         {
            _loc3_ = HappyLittleGameManager.instance.bombManager.model.BombTrain;
            _loc5_ = 0;
            while(_loc5_ < 10)
            {
               _loc4_ = 0;
               while(_loc4_ < 10)
               {
                  _loc2_.writeInt(_loc3_[_loc5_][_loc4_]);
                  _loc4_++;
               }
               _loc5_++;
            }
         }
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaGuradOpenGuard(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(316);
         _loc2_.writeByte(0);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaGuradLeaveScene() : void
      {
         var _loc1_:PackageOut = new PackageOut(316);
         _loc1_.writeByte(3);
         sendPackage(_loc1_);
      }
      
      public function sendConsortiaGuradFight(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(316);
         _loc2_.writeByte(5);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaGuradRank() : void
      {
         var _loc1_:PackageOut = new PackageOut(316);
         _loc1_.writeByte(16);
         sendPackage(_loc1_);
      }
      
      public function sendConsortiaGuradPlayerRevive(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(316);
         _loc2_.writeByte(10);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortiaGuradGameState() : void
      {
         var _loc1_:PackageOut = new PackageOut(316);
         _loc1_.writeByte(9);
         sendPackage(_loc1_);
      }
      
      public function sendConsortiaGuradBuyBuff(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(316);
         _loc2_.writeByte(17);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRewardTaskQuestOfferInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(629);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendRewardTaskRefreshQuest(param1:Boolean = true) : void
      {
         var _loc2_:PackageOut = new PackageOut(629);
         _loc2_.writeByte(2);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRewardTaskAddTimes(param1:Boolean = true) : void
      {
         var _loc2_:PackageOut = new PackageOut(629);
         _loc2_.writeByte(3);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRewardTaskRefreshReward(param1:Boolean = true) : void
      {
         var _loc2_:PackageOut = new PackageOut(629);
         _loc2_.writeByte(4);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendRewardTaskAcceptQuest(param1:Boolean = true) : void
      {
         var _loc2_:PackageOut = new PackageOut(629);
         _loc2_.writeByte(5);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendOpenAmuletBox(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(374);
         _loc4_.writeByte(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendAmuletActivate(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(375);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAmuletSmash(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageOut = new PackageOut(375);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1.length);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.writeInt(param1[_loc3_]);
            _loc3_++;
         }
         sendPackage(_loc2_);
      }
      
      public function sendAmuletMove(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(375);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendAmuletLock(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(375);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendAmuletActivateReplace(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(375);
         _loc2_.writeByte(7);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEquipAmuletBuyNum() : void
      {
         var _loc1_:PackageOut = new PackageOut(386);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendEquipAmuletUpgrade(param1:Boolean = false) : void
      {
         var _loc2_:PackageOut = new PackageOut(386);
         _loc2_.writeByte(2);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEquipAmuletActivate(param1:Boolean, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageOut = new PackageOut(386);
         _loc3_.writeByte(3);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2.length);
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc3_.writeInt(int(param2[_loc4_]));
            _loc4_++;
         }
         sendPackage(_loc3_);
      }
      
      public function sendEquipAmuletBuyStive(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(386);
         _loc2_.writeByte(4);
         _loc2_.writeBoolean(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEquipAmuletReplace(param1:Boolean) : void
      {
         var _loc2_:PackageOut = new PackageOut(386);
         _loc2_.writeByte(6);
         _loc2_.writeInt(!!param1?1:0);
         sendPackage(_loc2_);
      }
      
      public function requestManualInitData() : void
      {
         var _loc1_:PackageOut = new PackageOut(377);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function requestManualPageData(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(377);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendManualPageActive(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(377);
         _loc4_.writeByte(3);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendManualUpgrade(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(377);
         _loc4_.writeByte(4);
         _loc4_.writeBoolean(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendIndiana(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(385);
         _loc4_.writeByte(IndianaEPackageType.JOIN_HISTORY);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
      
      public function sendIndianaCode(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(385);
         _loc3_.writeByte(IndianaEPackageType.CHECK_CODE);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendIndianaEnterGame(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(385);
         _loc2_.writeByte(IndianaEPackageType.ENTER_GAME);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendIndianaHistoryData() : void
      {
         var _loc1_:PackageOut = new PackageOut(385);
         _loc1_.writeByte(IndianaEPackageType.HISTORY_INDIANA_INFO);
         sendPackage(_loc1_);
      }
      
      public function sendIndianaCurrentData(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(385);
         _loc2_.writeByte(IndianaEPackageType.CURRENT_INDIANA_INFO);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendHappyMiniGameRankDataList() : void
      {
         var _loc1_:PackageOut = new PackageOut(372);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function rollGameDice() : void
      {
         var _loc1_:PackageOut = new PackageOut(91);
         _loc1_.writeByte(123);
         sendPackage(_loc1_);
      }
      
      public function defendislandInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(22);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function pvePowerBuffRefresh() : void
      {
         var _loc1_:PackageOut = new PackageOut(84);
         _loc1_.writeInt(21);
         _loc1_.writeInt(2);
         sendPackage(_loc1_);
      }
      
      public function pvePowerBuffGetBuff(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(84);
         _loc2_.writeInt(21);
         _loc2_.writeInt(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendEquipGhost() : void
      {
         var _loc1_:PackageOut = new PackageOut(391);
         sendPackage(_loc1_);
      }
      
      public function sendBankUpdate(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(389);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendBanksaveMoney(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(389);
         _loc3_.writeInt(2);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBankGetMoney(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(389);
         _loc3_.writeInt(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBankGetTaskComplete() : void
      {
         var _loc1_:PackageOut = new PackageOut(389);
         _loc1_.writeInt(4);
         sendPackage(_loc1_);
      }
      
      public function addPlayerDressPay() : void
      {
         var _loc1_:PackageOut = new PackageOut(237);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function sendUpdateUserCmd(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(411);
         _loc2_.writeByte(2);
         _loc2_.writeByte(param1);
         sendPackage(_loc2_);
      }
      
      public function sendDealStockOrFund(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(411);
         _loc6_.writeByte(5);
         _loc6_.writeByte(param1);
         _loc6_.writeInt(param3);
         _loc6_.writeInt(param4 + 1);
         _loc6_.writeInt(param2);
         _loc6_.writeInt(param5);
         sendPackage(_loc6_);
      }
      
      public function sendBuyLoan(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(411);
         _loc3_.writeByte(17);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2 + 1);
         sendPackage(_loc3_);
      }
      
      public function sendStockSpecific(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(411);
         _loc4_.writeByte(3);
         _loc4_.writeInt(param1);
         _loc4_.writeByte(param2);
         sendPackage(_loc4_);
      }
      
      public function sendUserStockAccountInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(411);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function sendStockNews() : void
      {
         var _loc1_:PackageOut = new PackageOut(411);
         _loc1_.writeByte(4);
         sendPackage(_loc1_);
      }
      
      public function sendStockAward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(411);
         _loc2_.writeByte(18);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendPersonalLimitShop(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(528);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendConsortionActiveTargetSchedule() : void
      {
         var _loc1_:PackageOut = new PackageOut(412);
         _loc1_.writeByte(1);
         sendPackage(_loc1_);
      }
      
      public function sendConsortionActiveTagertStatus() : void
      {
         var _loc1_:PackageOut = new PackageOut(412);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function sendConsortionActiveTagertReward(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(412);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendMinesArrange() : void
      {
         var _loc1_:PackageOut = new PackageOut(414);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function sendDigHandler(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(414);
         _loc2_.writeByte(1);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUpdataToolHandler(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(414);
         _loc3_.writeByte(3);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendBuyHandler(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(414);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendExchangeHandler(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(414);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendMinesShopHandler() : void
      {
         var _loc1_:PackageOut = new PackageOut(414);
         _loc1_.writeByte(8);
         sendPackage(_loc1_);
      }
      
      public function sendInitHandler() : void
      {
         var _loc1_:PackageOut = new PackageOut(414);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function sendEquipmentLevelUpHandler(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(414);
         _loc4_.writeByte(6);
         _loc4_.writeInt(param1);
         _loc4_.writeInt(param2);
         _loc4_.writeInt(param3);
         sendPackage(_loc4_);
      }
      
      public function sendTeamChatTalk(param1:int, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(160);
         _loc3_.writeByte(52);
         _loc3_.writeInt(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendRoomBordenItemUp(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(23);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUseRoomBorden(param1:Boolean, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(390);
         _loc3_.writeByte(21);
         _loc3_.writeBoolean(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendSellRoomBordan(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(390);
         _loc3_.writeByte(22);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendTeamCreate(param1:String, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(390);
         _loc3_.writeByte(1);
         _loc3_.writeUTF(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendTeamGetInfo(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(2);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTeamInvite(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(3);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTeamInviteRepeal(param1:Number) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(4);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTeamInviteApproval(param1:Number) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(6);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTeamInviteAccept(param1:Number, param2:Number) : void
      {
         var _loc3_:PackageOut = new PackageOut(390);
         _loc3_.writeByte(5);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendTeamCheckInput(param1:Boolean, param2:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(390);
         _loc3_.writeByte(17);
         _loc3_.writeBoolean(param1);
         _loc3_.writeUTF(param2);
         sendPackage(_loc3_);
      }
      
      public function sendTeamGetInviteList(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(15);
         sendPackage(_loc2_);
      }
      
      public function sendTeamExpeleMember(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(8);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTeamGetRecord(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(9);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTeamGetActive(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(10);
         sendPackage(_loc2_);
      }
      
      public function sendTeamGetSelfActive() : void
      {
         var _loc1_:PackageOut = new PackageOut(390);
         _loc1_.writeByte(16);
         sendPackage(_loc1_);
      }
      
      public function sendTeamDonate(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(390);
         _loc2_.writeByte(24);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTeamExit() : void
      {
         var _loc1_:PackageOut = new PackageOut(390);
         _loc1_.writeByte(7);
         sendPackage(_loc1_);
      }
      
      public function sendChangeTeamName(param1:int, param2:int, param3:String, param4:String) : void
      {
         var _loc5_:PackageOut = new PackageOut(390);
         _loc5_.writeByte(32);
         _loc5_.writeByte(param1);
         _loc5_.writeInt(param2);
         _loc5_.writeUTF(param3);
         _loc5_.writeUTF(param4);
         sendPackage(_loc5_);
      }
      
      public function sendConsortiaGuradBossRank(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(316);
         _loc2_.writeByte(19);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendTreasureRoomData() : void
      {
         var _loc1_:PackageOut = new PackageOut(529);
         _loc1_.writeByte(23);
         sendPackage(_loc1_);
      }
      
      public function sendSubmitTransfer(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(529);
         _loc2_.writeByte(8);
         _loc2_.writeInt(param1);
         sendPackage(_loc2_);
      }
      
      public function sendUserAllDebris() : void
      {
         var _loc1_:PackageOut = new PackageOut(529);
         _loc1_.writeByte(2);
         sendPackage(_loc1_);
      }
      
      public function sendOnOrOffChip(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(529);
         _loc3_.writeByte(17);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendSellChips(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:PackageOut = new PackageOut(529);
         _loc3_.writeByte(9);
         var _loc2_:int = param1.length;
         _loc3_.writeInt(_loc2_);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.writeInt(param1[_loc4_]);
            _loc4_++;
         }
         sendPackage(_loc3_);
      }
      
      public function sendHammerChip(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(529);
         _loc3_.writeByte(4);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendCrystalList() : void
      {
         var _loc1_:PackageOut = new PackageOut(529);
         _loc1_.writeByte(6);
         sendPackage(_loc1_);
      }
      
      public function sendTransferChip(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(529);
         _loc3_.writeByte(7);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendOperationStatus(param1:int, param2:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(529);
         _loc3_.writeByte(24);
         _loc3_.writeInt(param1);
         _loc3_.writeInt(param2);
         sendPackage(_loc3_);
      }
      
      public function sendTreasureRoomReward(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(529);
         _loc4_.writeByte(22);
         _loc4_.writeInt(param1);
         _loc4_.writeBoolean(param2);
         _loc4_.writeBoolean(param3);
         sendPackage(_loc4_);
      }
   }
}
