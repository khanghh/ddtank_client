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
      
      public function GameSocketOut(socket:ByteSocket)
      {
         super();
         _socket = socket;
      }
      
      public function sendLogin(acc:AccountInfo, isChangeChannel:Boolean) : void
      {
         var i:int = 0;
         _socket.resetKey();
         var date:Date = new Date();
         var temp:ByteArray = new ByteArray();
         var fsm_key:int = randRange(100,10000);
         temp.writeShort(date.fullYearUTC);
         temp.writeByte(date.monthUTC + 1);
         temp.writeByte(date.dateUTC);
         temp.writeByte(date.hoursUTC);
         temp.writeByte(date.minutesUTC);
         temp.writeByte(date.secondsUTC);
         var key:Array = [Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255),Math.ceil(Math.random() * 255)];
         for(i = 0; i < key.length; )
         {
            temp.writeByte(key[i]);
            i++;
         }
         temp.writeUTFBytes(acc.Account + "," + acc.Password);
         temp = CrytoUtils.rsaEncry5(acc.Key,temp);
         temp.position = 0;
         var pkg:PackageOut = new PackageOut(1);
         pkg.writeBoolean(isChangeChannel);
         pkg.writeInt(5498628);
         pkg.writeInt(DesktopManager.Instance.desktopType);
         pkg.writeBytes(temp);
         sendPackage(pkg);
         _socket.setKey(key);
      }
      
      public function sendWeeklyClick() : void
      {
         var pkg:PackageOut = new PackageOut(219);
         sendPackage(pkg);
      }
      
      public function sendLoginDebug() : void
      {
         var pkg:PackageOut = new PackageOut(1);
         sendPackage(pkg);
      }
      
      public function sendRandomSuitUse(place:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(337);
         pkg.writeInt(place);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendGameLogin(hallType:int, isRnd:int, roomId:int = -1, pass:String = "", isInvite:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(1);
         pkg.writeBoolean(isInvite);
         pkg.writeInt(hallType);
         pkg.writeInt(isRnd);
         if(isRnd == -1)
         {
            pkg.writeInt(roomId);
            pkg.writeUTF(pass);
         }
         sendPackage(pkg);
      }
      
      public function sendRefreshServer() : void
      {
         var pkg:PackageOut = new PackageOut(306);
         sendPackage(pkg);
      }
      
      public function sendReconnection() : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(21);
         sendPackage(pkg);
      }
      
      public function sendFastInviteCall() : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(19);
         sendPackage(pkg);
      }
      
      public function sendSceneLogin(hellType:int) : void
      {
         var pkg:PackageOut = new PackageOut(16);
         pkg.writeInt(hellType);
         sendPackage(pkg);
      }
      
      public function sendGameStyle(style:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(12);
         pkg.writeInt(style);
         sendPackage(pkg);
      }
      
      public function sendDailyAward(getWay:int) : void
      {
         var pkg:PackageOut = new PackageOut(13);
         pkg.writeInt(getWay);
         sendPackage(pkg);
      }
      
      public function sendRestroDaily(date:Date) : void
      {
         var pkg:PackageOut = new PackageOut(13);
         pkg.writeInt(6);
         pkg.writeDate(date);
         sendPackage(pkg);
      }
      
      public function sendSignAward(signCount:int) : void
      {
         var pkg:PackageOut = new PackageOut(90);
         pkg.writeInt(signCount);
         sendPackage(pkg);
      }
      
      public function sendBuyGoods(items:Array, types:Array, colors:Array, places:Array, dresses:Array, skin:Array = null, buyFrom:int = 0, goodsTypes:Array = null, arr:Array = null) : void
      {
         var tmpArr:* = null;
         var i:* = 0;
         if(items.length > 50)
         {
            if(arr && arr.length > 50)
            {
               tmpArr = arr.splice(0,50);
            }
            else
            {
               tmpArr = arr;
            }
            if(skin == null)
            {
               sendBuyGoods(items.splice(0,50),types.splice(0,50),colors.splice(0,50),places.splice(0,50),dresses.splice(0,50),null,buyFrom,goodsTypes,tmpArr);
            }
            else
            {
               sendBuyGoods(items.splice(0,50),types.splice(0,50),colors.splice(0,50),places.splice(0,50),dresses.splice(0,50),skin.splice(0,50),buyFrom,goodsTypes,tmpArr);
            }
            sendBuyGoods(items,types,colors,places,dresses,skin,buyFrom,goodsTypes,arr);
            return;
         }
         var pkg:PackageOut = new PackageOut(44);
         var count:int = items.length;
         pkg.writeInt(count);
         for(i = uint(0); i < count; )
         {
            if(!goodsTypes)
            {
               pkg.writeInt(1);
            }
            else
            {
               pkg.writeInt(goodsTypes[i]);
            }
            pkg.writeInt(items[i]);
            pkg.writeInt(types[i]);
            pkg.writeUTF(colors[i]);
            pkg.writeBoolean(dresses[i]);
            if(skin == null)
            {
               pkg.writeUTF("");
            }
            else
            {
               pkg.writeUTF(skin[i]);
            }
            pkg.writeInt(places[i]);
            if(arr)
            {
               pkg.writeBoolean(arr[i]);
            }
            else
            {
               pkg.writeBoolean(false);
            }
            i++;
         }
         pkg.writeInt(buyFrom);
         sendPackage(pkg);
      }
      
      public function sendNewBuyGoods(id:int, type:int, count:int = 1, colors:String = "", place:int = 0, dresse:Boolean = false, skin:String = "", buyFrom:int = 0, goodsType:int = 1, isBind:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(345);
         pkg.writeInt(count);
         pkg.writeInt(goodsType);
         pkg.writeInt(id);
         pkg.writeInt(type);
         pkg.writeUTF(colors);
         pkg.writeBoolean(dresse);
         pkg.writeUTF(skin);
         pkg.writeInt(place);
         pkg.writeBoolean(isBind);
         pkg.writeInt(buyFrom);
         sendPackage(pkg);
      }
      
      public function sendBuyProp(id:int, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(54);
         pkg.writeInt(id);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendSellProp(id:int, GoodsID:int) : void
      {
         var pkg:PackageOut = new PackageOut(55);
         pkg.writeInt(id);
         pkg.writeInt(GoodsID);
         sendPackage(pkg);
      }
      
      public function sendQuickBuyGoldBox(buyNumber:int, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(126);
         pkg.writeInt(buyNumber);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendBuyGiftBag(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(46);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendButTransnationalGoods(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(156);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendPresentGoods(ids:Array, types:Array, colors:Array, goodTypes:Array, msg:String, nick:String, skin:Array = null, bools:Array = null) : void
      {
         var i:* = 0;
         var pkg:PackageOut = new PackageOut(57);
         var count:int = ids.length;
         pkg.writeUTF(msg);
         pkg.writeUTF(nick);
         pkg.writeInt(count);
         for(i = uint(0); i < count; )
         {
            pkg.writeInt(ids[i]);
            pkg.writeInt(types[i]);
            pkg.writeUTF(colors[i]);
            if(skin == null)
            {
               pkg.writeUTF("");
            }
            else
            {
               pkg.writeUTF(skin[i]);
            }
            pkg.writeInt(goodTypes[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendGoodsContinue(data:Array) : void
      {
         var i:* = 0;
         var count:int = data.length;
         var pkg:PackageOut = new PackageOut(62);
         pkg.writeInt(count);
         for(i = uint(0); i < count; )
         {
            pkg.writeByte(data[i][0]);
            pkg.writeInt(data[i][1]);
            pkg.writeInt(data[i][2]);
            pkg.writeByte(data[i][3]);
            pkg.writeBoolean(data[i][4]);
            pkg.writeInt(data[i][5]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendSellGoods(position:int) : void
      {
         var pkg:PackageOut = new PackageOut(48);
         pkg.writeInt(position);
         sendPackage(pkg);
      }
      
      public function sendUpdateGoodsCount() : void
      {
         var pkg:PackageOut = new PackageOut(168);
         sendPackage(pkg);
      }
      
      public function sendEmail(param:Object) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(116);
         pkg.writeUTF(param.NickName);
         pkg.writeUTF(param.Title);
         pkg.writeUTF(param.Content);
         pkg.writeBoolean(param.isPay);
         pkg.writeInt(param.hours);
         pkg.writeInt(param.SendedMoney);
         while(i < 4)
         {
            if(param["Annex" + i])
            {
               pkg.writeByte(param["Annex" + i].split(",")[0]);
               pkg.writeInt(param["Annex" + i].split(",")[1]);
               pkg.writeInt(param.Count);
            }
            else
            {
               pkg.writeByte(0);
               pkg.writeInt(-1);
               pkg.writeInt(0);
            }
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendUpdateMail(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(114);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendDeleteSentMail(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(340);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendDeleteMail(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(112);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function untreadEmail(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(118);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendGetMail(emailId:int, type:int) : void
      {
         var pkg:PackageOut = new PackageOut(113);
         pkg.writeInt(emailId);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function sendPint() : void
      {
         var pkg:PackageOut = new PackageOut(4);
         sendPackage(pkg);
      }
      
      public function sendSuicide(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(17);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendKillSelf(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(21);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendItemCompose(consortiaState:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(58);
         pkg.writeBoolean(consortiaState);
         sendPackage(pkg);
      }
      
      public function sendItemTransfer(transferBefore:Boolean = true, transferAfter:Boolean = true, sBagType:int = 12, sPlace:int = 0, tBagType:int = 12, tPlace:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(61);
         pkg.writeBoolean(transferBefore);
         pkg.writeBoolean(transferAfter);
         pkg.writeInt(sBagType);
         pkg.writeInt(sPlace);
         pkg.writeInt(tBagType);
         pkg.writeInt(tPlace);
         sendPackage(pkg);
      }
      
      public function sendItemStrength(consortiaState:Boolean, isAllInject:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(59);
         pkg.writeBoolean(consortiaState);
         pkg.writeBoolean(isAllInject);
         sendPackage(pkg);
      }
      
      public function sendItemExalt() : void
      {
         var pkg:PackageOut = new PackageOut(138);
         sendPackage(pkg);
      }
      
      public function sendExaltRestore() : void
      {
         var pkg:PackageOut = new PackageOut(354);
         sendPackage(pkg);
      }
      
      public function sendItemLianhua(operation:int, count:int, matieria:Array, equipBagType:int, equipPlace:int, luckyBagType:int, luckyPlace:int) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(210);
         pkg.writeInt(operation);
         pkg.writeInt(count);
         for(i = 0; i < matieria.length; )
         {
            pkg.writeInt(matieria[i]);
            i++;
         }
         pkg.writeInt(equipBagType);
         pkg.writeInt(equipPlace);
         pkg.writeInt(luckyBagType);
         pkg.writeInt(luckyPlace);
         sendPackage(pkg);
      }
      
      public function sendBeadEquip(pBeadPlace:int, pAimPlace:int) : void
      {
         var vPkg:PackageOut = new PackageOut(121);
         vPkg.writeByte(1);
         vPkg.writeInt(pBeadPlace);
         vPkg.writeInt(pAimPlace);
         sendPackage(vPkg);
      }
      
      public function sendBeadUpgrade(pSlots:Array) : void
      {
         var vPkg:PackageOut = new PackageOut(121);
         vPkg.writeByte(2);
         vPkg.writeInt(pSlots.length);
         var _loc5_:int = 0;
         var _loc4_:* = pSlots;
         for each(var o in pSlots)
         {
            vPkg.writeInt(o);
         }
         sendPackage(vPkg);
      }
      
      public function sendOpenBead(pIndex:int, bool:Boolean) : void
      {
         var vPkg:PackageOut = new PackageOut(121);
         vPkg.writeByte(3);
         vPkg.writeInt(pIndex);
         vPkg.writeBoolean(bool);
         sendPackage(vPkg);
      }
      
      public function sendBeadLock(pBeadPlace:int) : void
      {
         var vPkg:PackageOut = new PackageOut(121);
         vPkg.writeByte(4);
         vPkg.writeInt(pBeadPlace);
         sendPackage(vPkg);
      }
      
      public function sendBeadOpenHole(pHoleIndex:int, pDrillID:int, num:int = 1) : void
      {
         var vPkg:PackageOut = new PackageOut(121);
         vPkg.writeByte(5);
         vPkg.writeInt(pHoleIndex);
         vPkg.writeInt(pDrillID);
         vPkg.writeInt(num);
         sendPackage(vPkg);
      }
      
      public function sendBeadAdvanceExchange(itemId:int, mainIdIndex:int, auxiliaryIDindex:int) : void
      {
         var vPkg:PackageOut = new PackageOut(121);
         vPkg.writeByte(7);
         vPkg.writeInt(itemId);
         vPkg.writeInt(mainIdIndex);
         vPkg.writeInt(auxiliaryIDindex);
         sendPackage(vPkg);
      }
      
      public function sendItemEmbedBackout(itemPlace:int, templateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(125);
         pkg.writeInt(itemPlace);
         pkg.writeInt(templateID);
         sendPackage(pkg);
      }
      
      public function sendItemOpenFiveSixHole(itemPlace:int, number:int, drill:int) : void
      {
         var pkg:PackageOut = new PackageOut(217);
         pkg.writeInt(itemPlace);
         pkg.writeInt(number);
         pkg.writeInt(drill);
         sendPackage(pkg);
      }
      
      public function sendItemTrend(itemBagType:int, itemPlace:int, propBagType:int, propPlace:int, trendType:int) : void
      {
         var pkg:PackageOut = new PackageOut(120);
         pkg.writeInt(itemBagType);
         pkg.writeInt(itemPlace);
         pkg.writeInt(propBagType);
         pkg.writeInt(propPlace);
         pkg.writeInt(trendType);
         sendPackage(pkg);
      }
      
      public function sendClearStoreBag() : void
      {
         PlayerManager.Instance.Self.StoreBag.items.clear();
         PlayerManager.Instance.Self.StoreBag.dispatchEvent(new CEvent("clearStoreBag"));
         var pkg:PackageOut = new PackageOut(122);
         sendPackage(pkg);
      }
      
      public function sendCheckCode(code:String) : void
      {
         var pkg:PackageOut = new PackageOut(200);
         pkg.writeUTF(code);
         sendPackage(pkg);
      }
      
      public function sendEquipRetrieve() : void
      {
         var pkg:PackageOut = new PackageOut(222);
         sendPackage(pkg);
      }
      
      public function sendItemFusion(fusionId:int, count:int, withoutComposeAttr:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(78);
         pkg.writeInt(fusionId);
         pkg.writeInt(count);
         pkg.writeBoolean(withoutComposeAttr);
         sendPackage(pkg);
      }
      
      public function sendSBugle(msg:String) : void
      {
         var pkg:PackageOut = new PackageOut(71);
         pkg.writeInt(PlayerManager.Instance.Self.ID);
         pkg.writeUTF(PlayerManager.Instance.Self.NickName);
         pkg.writeUTF(msg);
         sendPackage(pkg);
      }
      
      public function sendBBugle(msg:String, templateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(72);
         pkg.writeInt(templateID);
         pkg.writeInt(PlayerManager.Instance.Self.ID);
         pkg.writeUTF(PlayerManager.Instance.Self.NickName);
         pkg.writeUTF(msg);
         sendPackage(pkg);
      }
      
      public function sendCBugle(msg:String) : void
      {
         var pkg:PackageOut = new PackageOut(73);
         pkg.writeInt(PlayerManager.Instance.Self.ID);
         pkg.writeUTF(PlayerManager.Instance.Self.NickName);
         pkg.writeUTF(msg);
         sendPackage(pkg);
      }
      
      public function sendDefyAffiche(msg:String, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(123);
         pkg.writeBoolean(bool);
         pkg.writeUTF(msg);
         sendPackage(pkg);
      }
      
      public function sendGameMode(style:int) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(12);
         pkg.writeInt(style);
         sendPackage(pkg);
      }
      
      public function sendAddFriend(nick:String, Relation:int, isSendEmail:Boolean = false, isSameCity:Boolean = false) : void
      {
         if(nick == "")
         {
            return;
         }
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(160);
         pkg.writeUTF(nick);
         pkg.writeInt(Relation);
         pkg.writeBoolean(isSendEmail);
         pkg.writeBoolean(isSameCity);
         sendPackage(pkg);
      }
      
      public function sendDelFriend(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(161);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendFriendState(state:int) : void
      {
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(165);
         pkg.writeInt(state);
         sendPackage(pkg);
      }
      
      public function sendBagLocked(pwd:String, type:int, newPwd:String = "", questionOne:String = "", answerOne:String = "", questionTwo:String = "", answerTwo:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(25);
         pkg.writeByte(1);
         BaglockedManager.TEMP_PWD = newPwd != ""?newPwd:pwd;
         pkg.writeUTF(pwd);
         pkg.writeUTF(newPwd);
         pkg.writeInt(type);
         pkg.writeUTF(questionOne);
         pkg.writeUTF(answerOne);
         pkg.writeUTF(questionTwo);
         pkg.writeUTF(answerTwo);
         sendPackage(pkg);
      }
      
      public function sendBagLockedII(psw:String, questionOne:String, answerOne:String, questionTwo:String, answerTwo:String) : void
      {
      }
      
      public function sendConsortiaEquipConstrol(arr:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(24);
         for(i = 0; i < arr.length; )
         {
            pkg.writeInt(arr[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendErrorMsg(msg:String) : void
      {
         var pkg:* = null;
         if(msg.length < 1000)
         {
            pkg = new PackageOut(8);
            pkg.writeUTF(msg);
            sendPackage(pkg);
         }
      }
      
      public function sendItemOverDue(bagtype:int, place:int) : void
      {
         if(bagtype == -1)
         {
            return;
         }
         var pkg:PackageOut = new PackageOut(77);
         pkg.writeByte(bagtype);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendHideLayer(categoryid:int, hide:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(60);
         pkg.writeBoolean(hide);
         pkg.writeInt(categoryid);
         sendPackage(pkg);
      }
      
      public function sendQuestManuGet(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(273);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendQuestAdd(arr:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(176);
         pkg.writeInt(arr.length);
         for(i = 0; i < arr.length; )
         {
            if(arr[i] == 3025)
            {
               trace(arr[i]);
            }
            pkg.writeInt(arr[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendQuestRemove(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(177);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendQuestFinish(id:int, itemId:int, type:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(179);
         pkg.writeInt(id);
         pkg.writeInt(itemId);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendQuestOneToFinish(questId:int) : void
      {
         var pkg:PackageOut = new PackageOut(86);
         pkg.writeInt(questId);
         sendPackage(pkg);
      }
      
      public function sendImproveQuest(questId:int, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(83);
         pkg.writeInt(questId);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendQuestCheck(id:int, conid:int, value:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(181);
         pkg.writeInt(id);
         pkg.writeInt(conid);
         pkg.writeInt(value);
         sendPackage(pkg);
      }
      
      public function sendItemOpenUp(bagtype:int, place:int, count:int = 1, isBand:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(63);
         pkg.writeByte(bagtype);
         pkg.writeInt(place);
         pkg.writeInt(count);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendUseLoveFeelingly(bagtype:int, place:int, count:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(330);
         pkg.writeByte(bagtype);
         pkg.writeInt(place);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendItemEquip(idOrNickName:*, isUseNickName:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(74);
         if(!isUseNickName)
         {
            pkg.writeBoolean(true);
            pkg.writeInt(idOrNickName);
         }
         else if(isUseNickName)
         {
            pkg.writeBoolean(false);
            pkg.writeUTF(idOrNickName);
         }
         sendPackage(pkg);
      }
      
      public function sendMateTime(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(85);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendPlayerGift(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(218);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendActivePullDown(id:int, pass:String) : void
      {
         var pkg:PackageOut = new PackageOut(11);
         pkg.writeInt(id);
         pkg.writeUTF(pass);
         sendPackage(pkg);
      }
      
      public function auctionGood(bagType:int, place:int, payType:int, price:int, mouthful:int, validDate:int, count:int, isAuctionBugle:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(192);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeByte(payType);
         pkg.writeInt(price);
         pkg.writeInt(mouthful);
         pkg.writeInt(validDate);
         pkg.writeInt(count);
         pkg.writeBoolean(isAuctionBugle);
         sendPackage(pkg);
      }
      
      public function auctionCancelSell(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(194);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function auctionBid(id:int, price:int) : void
      {
         var pkg:PackageOut = new PackageOut(193);
         pkg.writeInt(id);
         pkg.writeInt(price);
         sendPackage(pkg);
      }
      
      public function syncStep(id:int, save:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(15);
         pkg.writeByte(1);
         pkg.writeInt(id);
         pkg.writeBoolean(save);
         sendPackage(pkg);
      }
      
      public function syncWeakStep(id:int) : void
      {
         WeakGuildManager.Instance.setStepFinish(id);
         var pkg:PackageOut = new PackageOut(15);
         pkg.writeByte(2);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendCreateConsortia(name:String, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(1);
         pkg.writeUTF(name);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendConsortiaTryIn(consortiaid:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(0);
         pkg.writeInt(consortiaid);
         sendPackage(pkg);
      }
      
      public function sendConsortiaCancelTryIn() : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(0);
         pkg.writeInt(0);
         sendPackage(pkg);
      }
      
      public function sendConsortiaInvate(name:String) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(11);
         pkg.writeUTF(name);
         sendPackage(pkg);
      }
      
      public function sendReleaseConsortiaTask(type:int, bool:Boolean = true, level:int = 1, lastType:int = 0, lockId1:int = 0, lockId2:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(22);
         pkg.writeInt(type);
         if(type == 0)
         {
            pkg.writeInt(level);
         }
         else if(type == 2)
         {
            pkg.writeByte(lastType);
         }
         else
         {
            pkg.writeBoolean(bool);
            if(type == 1)
            {
               pkg.writeInt(lockId1);
               pkg.writeInt(lockId2);
            }
         }
         sendPackage(pkg);
      }
      
      public function addSpeed(type:int, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(155);
         pkg.writeByte(5);
         pkg.writeInt(type);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendConsortiaInvatePass(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(12);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendConsortiaInvateDelete(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(13);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendConsortiaUpdateDescription(description:String) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(14);
         pkg.writeUTF(description);
         sendPackage(pkg);
      }
      
      public function sendConsortiaUpdatePlacard(placard:String) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(15);
         pkg.writeUTF(placard);
         sendPackage(pkg);
      }
      
      public function sendConsortiaUpdateDuty(dutyid:int, dutyname:String, right:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(10);
         pkg.writeInt(dutyid);
         pkg.writeByte(dutyid == -1?1:2);
         pkg.writeUTF(dutyname);
         pkg.writeInt(right);
         sendPackage(pkg);
      }
      
      public function sendConsortiaUpgradeDuty(dutyid:int, updown:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(10);
         pkg.writeInt(dutyid);
         pkg.writeByte(updown);
         sendPackage(pkg);
      }
      
      public function sendConsoritaApplyStatusOut(b:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(7);
         pkg.writeBoolean(b);
         sendPackage(pkg);
      }
      
      public function sendConsortiaOut(playerid:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(3);
         pkg.writeInt(playerid);
         sendPackage(pkg);
      }
      
      public function sendConsortiaMemberGrade(id:int, isUpgrade:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(18);
         pkg.writeInt(id);
         pkg.writeBoolean(isUpgrade);
         sendPackage(pkg);
      }
      
      public function sendConsortiaUserRemarkUpdate(id:int, msg:String) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(17);
         pkg.writeInt(id);
         pkg.writeUTF(msg);
         sendPackage(pkg);
      }
      
      public function sendConsortiaDutyDelete(dutyid:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(9);
         pkg.writeInt(dutyid);
         sendPackage(pkg);
      }
      
      public function sendConsortiaTryinPass(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(4);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendConsortiaTryinDelete(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(5);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendForbidSpeak(id:int, forbid:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(16);
         pkg.writeInt(id);
         pkg.writeBoolean(forbid);
         sendPackage(pkg);
      }
      
      public function sendConsortiaDismiss() : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(2);
         sendPackage(pkg);
      }
      
      public function sendConsortiaChangeChairman(nickName:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(19);
         pkg.writeUTF(nickName);
         sendPackage(pkg);
      }
      
      public function sendConsortiaRichOffer(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(6);
         pkg.writeInt(num);
         pkg.writeBoolean(false);
         sendPackage(pkg);
      }
      
      public function sendDonate(id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(23);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendConsortiaLevelUp(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(21);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function sendAirPlane() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(40);
         sendPackage(pkg);
      }
      
      public function useDeputyWeapon() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(84);
         sendPackage(pkg);
      }
      
      public function sendGamePick(bombId:int) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(49);
         pkg.writeInt(bombId);
         sendPackage(pkg);
      }
      
      public function sendPetSkill(skillID:int, type:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(144);
         pkg.writeInt(skillID);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendPackage(pkg:PackageOut) : void
      {
         _socket.send(pkg);
      }
      
      public function sendMoveGoods(bagtype:int, place:int, tobagType:int, toplace:int, count:int = 1, allMove:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(49);
         pkg.writeByte(bagtype);
         pkg.writeInt(place);
         pkg.writeByte(tobagType);
         pkg.writeInt(toplace);
         pkg.writeInt(count);
         pkg.writeBoolean(allMove);
         sendPackage(pkg);
      }
      
      public function reclaimGoods(bagtype:int, place:int, count:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(127);
         pkg.writeByte(bagtype);
         pkg.writeInt(place);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendMoveGoodsAll(bagType:int, array:Array, startPlace:int, isSegistration:Boolean = false) : void
      {
         var i:int = 0;
         if(array.length <= 0)
         {
            return;
         }
         var len:int = array.length;
         var pkg:PackageOut = new PackageOut(124);
         pkg.writeBoolean(isSegistration);
         pkg.writeInt(len);
         pkg.writeInt(bagType);
         for(i = 0; i < len; )
         {
            pkg.writeInt(array[i].Place);
            pkg.writeInt(i + startPlace);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendForSwitch() : void
      {
         var pkg:PackageOut = new PackageOut(225);
         sendPackage(pkg);
      }
      
      public function sendCIDCheck() : void
      {
         var pkg:PackageOut = new PackageOut(224);
         sendPackage(pkg);
      }
      
      public function sendCIDInfo(name:String, CID:String) : void
      {
         var pkg:PackageOut = new PackageOut(224);
         pkg.writeBoolean(false);
         pkg.writeUTF(name);
         pkg.writeUTF(CID);
         sendPackage(pkg);
      }
      
      public function sendChangeColor(cardBagType:int, cardPlace:int, itemBagType:int, itemPlace:int, color:String, skin:String, templateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(182);
         pkg.writeInt(cardBagType);
         pkg.writeInt(cardPlace);
         pkg.writeInt(itemBagType);
         pkg.writeInt(itemPlace);
         pkg.writeUTF(color);
         pkg.writeUTF(skin);
         pkg.writeInt(templateID);
         sendPackage(pkg);
      }
      
      public function sendUseCard(bagType:int, cardPlace:int, items:Array, type:int, ignoreBagLock:Boolean = false, bool:Boolean = true, count:int = 1) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(183);
         pkg.writeInt(bagType);
         pkg.writeInt(cardPlace);
         pkg.writeInt(items.length);
         var len:int = items.length;
         for(i = 0; i < len; )
         {
            pkg.writeInt(items[i]);
            i++;
         }
         pkg.writeInt(type);
         pkg.writeBoolean(ignoreBagLock);
         pkg.writeBoolean(bool);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendUseProp(bagType:int, cardPlace:int, items:Array, type:int, ignoreBagLock:Boolean = false) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(66);
         pkg.writeInt(bagType);
         pkg.writeInt(cardPlace);
         pkg.writeInt(items.length);
         var len:int = items.length;
         for(i = 0; i < len; )
         {
            pkg.writeInt(items[i]);
            i++;
         }
         pkg.writeInt(type);
         pkg.writeBoolean(ignoreBagLock);
         sendPackage(pkg);
      }
      
      public function sendUseChangeColorShell(bagType:int, cardPlace:int) : void
      {
         var pkg:PackageOut = new PackageOut(205);
         pkg.writeByte(bagType);
         pkg.writeInt(cardPlace);
         sendPackage(pkg);
      }
      
      public function sendChangeColorShellTimeOver(bagtype:int, place:int) : void
      {
         if(bagtype == -1)
         {
            return;
         }
         var pkg:PackageOut = new PackageOut(206);
         pkg.writeByte(bagtype);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendRouletteBox(bagType:int, place:int, boxId:int = -1) : void
      {
         trace("[sendRouletteBox]" + getTimer());
         var pkg:PackageOut = new PackageOut(26);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeInt(boxId);
         sendPackage(pkg);
      }
      
      public function sendStartTurn(type:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(27);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendFinishRoulette() : void
      {
         var pkg:PackageOut = new PackageOut(28);
         sendPackage(pkg);
      }
      
      public function sendSellAll() : void
      {
         var pkg:PackageOut = new PackageOut(232);
         sendPackage(pkg);
      }
      
      public function sendconverted(isConver:Boolean, totalSorce:int = 0, lotteryScore:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(215);
         pkg.writeBoolean(isConver);
         pkg.writeInt(totalSorce);
         pkg.writeInt(lotteryScore);
         sendPackage(pkg);
      }
      
      public function sendExchange() : void
      {
         var pkg:PackageOut = new PackageOut(211);
         sendPackage(pkg);
      }
      
      public function sendOpenAll() : void
      {
      }
      
      public function sendOpenDead(bagType:int, place:int, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(26);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendRequestAwards(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(245);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendQequestBadLuck(isOpen:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(45);
         pkg.writeBoolean(isOpen);
         sendPackage(pkg);
      }
      
      public function sendQequestLuckky(isOpen:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(97);
         pkg.writeBoolean(isOpen);
         sendPackage(pkg);
      }
      
      public function sendUseReworkName(bagType:int, place:int, newName:String) : void
      {
         var pkg:PackageOut = new PackageOut(171);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeUTF(newName);
         sendPackage(pkg);
      }
      
      public function sendUseConsortiaReworkName(consortiaID:int, bagType:int, place:int, newName:String) : void
      {
         var pkg:PackageOut = new PackageOut(188);
         pkg.writeInt(consortiaID);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeUTF(newName);
         sendPackage(pkg);
      }
      
      public function sendValidateMarry(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(246);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendPropose(id:int, text:String, useBugle:Boolean, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(247);
         pkg.writeInt(id);
         pkg.writeUTF(text);
         pkg.writeBoolean(useBugle);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendProposeRespose(result:Boolean, id:int, answerId:int) : void
      {
         var pkg:PackageOut = new PackageOut(250);
         pkg.writeBoolean(result);
         pkg.writeInt(id);
         pkg.writeInt(answerId);
         sendPackage(pkg);
      }
      
      public function sendUnmarry(isPlayMovie:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(248);
         pkg.writeBoolean(isPlayMovie);
         pkg.writeBoolean(PlayerManager.Instance.merryActivity);
         sendPackage(pkg);
      }
      
      public function sendMarryRoomLogin() : void
      {
         var pkg:PackageOut = new PackageOut(240);
         sendPackage(pkg);
      }
      
      public function sendExitMarryRoom() : void
      {
         var pkg:PackageOut = new PackageOut(21);
         sendPackage(pkg);
      }
      
      public function sendCreateRoom(roomName:String, password:String, mapID:int, valideTimes:int, canInvite:Boolean, discription:String, seniorType:int) : void
      {
         var pkg:PackageOut = new PackageOut(241);
         pkg.writeUTF(roomName);
         pkg.writeUTF(password);
         pkg.writeInt(mapID);
         pkg.writeInt(valideTimes);
         pkg.writeInt(100);
         pkg.writeBoolean(canInvite);
         pkg.writeUTF(discription);
         pkg.writeBoolean(PlayerManager.Instance.merryActivity);
         pkg.writeInt(seniorType);
         sendPackage(pkg);
      }
      
      public function sendEnterRoom(id:int, psw:String, sceneIndex:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(242);
         pkg.writeInt(id);
         pkg.writeUTF(psw);
         pkg.writeInt(sceneIndex);
         sendPackage(pkg);
      }
      
      public function sendExitRoom() : void
      {
         var pkg:PackageOut = new PackageOut(244);
         sendPackage(pkg);
      }
      
      public function sendCurrentState(index:uint) : void
      {
         var pkg:PackageOut = new PackageOut(251);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendUpdateRoomList(hallType:int, updateType:int, fbId:int = 10000, hardLv:int = 1013) : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(9);
         pkg.writeInt(hallType);
         pkg.writeInt(updateType);
         if(hallType == 2 && updateType == -2 || hallType == 7)
         {
            pkg.writeInt(fbId);
            pkg.writeInt(hardLv);
         }
         sendPackage(pkg);
      }
      
      public function sendChurchMove(endX:int, endY:int, path:String) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(1);
         pkg.writeInt(endX);
         pkg.writeInt(endY);
         pkg.writeUTF(path);
         sendPackage(pkg);
      }
      
      public function sendStartWedding(isBind:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(2);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendChurchContinuation(hours:int) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(3);
         pkg.writeInt(hours);
         sendPackage(pkg);
      }
      
      public function sendChurchInvite(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(4);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendChurchLargess(num:uint) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(5);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function refund() : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(12);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function requestRefund() : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(12);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendUseFire(playerID:int, fireTemplateID:int, isBind:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(6);
         pkg.writeInt(playerID);
         pkg.writeInt(fireTemplateID);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendChurchKick(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(7);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendChurchMovieOver(ID:int, password:String) : void
      {
         var pkg:PackageOut = new PackageOut(167);
         pkg.writeInt(ID);
         pkg.writeUTF(password);
         sendPackage(pkg);
      }
      
      public function sendChurchForbid(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(8);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendPosition(x:Number, y:Number) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(10);
         pkg.writeInt(x);
         pkg.writeInt(y);
         sendPackage(pkg);
      }
      
      public function sendModifyChurchDiscription(roomName:String, modifyPSW:Boolean, psw:String, discription:String) : void
      {
         var pkg:PackageOut = new PackageOut(253);
         pkg.writeUTF(roomName);
         pkg.writeBoolean(modifyPSW);
         pkg.writeUTF(psw);
         pkg.writeUTF(discription);
         sendPackage(pkg);
      }
      
      public function sendSceneChange(sceneIndex:int) : void
      {
         var pkg:PackageOut = new PackageOut(233);
         pkg.writeInt(sceneIndex);
         sendPackage(pkg);
      }
      
      public function sendGunSalute(userID:int, templeteID:int) : void
      {
         var pkg:PackageOut = new PackageOut(249);
         pkg.writeByte(11);
         pkg.writeInt(userID);
         pkg.writeInt(templeteID);
         sendPackage(pkg);
      }
      
      public function sendRequestSeniorChurch() : void
      {
         var pkg:PackageOut = new PackageOut(338);
         sendPackage(pkg);
      }
      
      public function sendRegisterInfo(UserID:int, IsPublishEquip:Boolean, introduction:String = null) : void
      {
         var pkg:PackageOut = new PackageOut(236);
         pkg.writeBoolean(IsPublishEquip);
         pkg.writeUTF(introduction);
         pkg.writeInt(UserID);
         sendPackage(pkg);
      }
      
      public function sendModifyInfo(IsPublishEquip:Boolean, introduction:String = null) : void
      {
         var pkg:PackageOut = new PackageOut(229);
         pkg.writeBoolean(IsPublishEquip);
         pkg.writeUTF(introduction);
         sendPackage(pkg);
      }
      
      public function sendForMarryInfo(MarryInfoID:int) : void
      {
         var pkg:PackageOut = new PackageOut(235);
         pkg.writeInt(MarryInfoID);
         sendPackage(pkg);
      }
      
      public function sendGetLinkGoodsInfo(type:int, key:String, templeteIDorItemID:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(119);
         pkg.writeInt(type);
         pkg.writeUTF(key);
         pkg.writeUTF(templeteIDorItemID);
         sendPackage(pkg);
      }
      
      public function sendGetTropToBag(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(108);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function createUserGuide(roomType:int = 10) : void
      {
         trace("SocketManager.Instance.out.createUserGuide(14);");
         var randomPass:String = String(Math.random());
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(0);
         pkg.writeByte(roomType);
         pkg.writeByte(3);
         pkg.writeUTF("");
         pkg.writeUTF(randomPass);
         sendPackage(pkg);
      }
      
      public function enterUserGuide(pveId:int, roomType:int = 10) : void
      {
         var randomPass:String = String(Math.random());
         var secType:int = PlayerManager.Instance.Self.Grade < 5?4:3;
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(2);
         pkg.writeInt(pveId);
         pkg.writeByte(roomType);
         pkg.writeBoolean(false);
         pkg.writeUTF(randomPass);
         pkg.writeUTF("");
         pkg.writeByte(secType);
         pkg.writeByte(0);
         pkg.writeInt(0);
         pkg.writeBoolean(false);
         pkg.writeInt(0);
         pkg.writeInt(0);
         pkg.writeBoolean(false);
         sendPackage(pkg);
      }
      
      public function userGuideStart() : void
      {
         var pkg:PackageOut = new PackageOut(94);
         pkg.writeInt(7);
         sendPackage(pkg);
      }
      
      public function sendSaveDB() : void
      {
         var pkg:PackageOut = new PackageOut(172);
         sendPackage(pkg);
      }
      
      public function createMonster() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(23);
         pkg.writeInt(0);
         sendPackage(pkg);
      }
      
      public function deleteMonster() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(23);
         pkg.writeInt(1);
         sendPackage(pkg);
      }
      
      public function sendHotSpringEnter() : void
      {
         var pkg:PackageOut = new PackageOut(187);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomCreate(roomVo:*) : void
      {
         var pkg:PackageOut = new PackageOut(175);
         pkg.writeUTF(roomVo.roomName);
         pkg.writeUTF(roomVo.roomPassword);
         pkg.writeUTF(roomVo.roomIntroduction);
         pkg.writeInt(roomVo.maxCount);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomEdit(roomVo:*) : void
      {
         var pkg:PackageOut = new PackageOut(191);
         pkg.writeByte(6);
         pkg.writeUTF(roomVo.roomName);
         pkg.writeUTF(roomVo.roomPassword);
         pkg.writeUTF(roomVo.roomIntroduction);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomQuickEnter() : void
      {
         var pkg:PackageOut = new PackageOut(190);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomEnterConfirm(roomID:int) : void
      {
         var pkg:PackageOut = new PackageOut(212);
         pkg.writeInt(roomID);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomEnter(roomID:int, roomPassword:String) : void
      {
         var pkg:PackageOut = new PackageOut(202);
         pkg.writeInt(roomID);
         pkg.writeUTF(roomPassword);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomEnterView(state:int) : void
      {
         var pkg:PackageOut = new PackageOut(201);
         pkg.writeInt(state);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomPlayerRemove() : void
      {
         var pkg:PackageOut = new PackageOut(169);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomPlayerTargetPoint(playerVO:*) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(191);
         pkg.writeByte(1);
         var souArr:Array = playerVO.walkPath.concat();
         var arr:Array = [];
         while(i < souArr.length)
         {
            arr.push(int(souArr[i].x),int(souArr[i].y));
            i++;
         }
         var pathStr:String = arr.toString();
         pkg.writeUTF(pathStr);
         pkg.writeInt(playerVO.playerInfo.ID);
         pkg.writeInt(playerVO.currentWalkStartPoint.x);
         pkg.writeInt(playerVO.currentWalkStartPoint.y);
         pkg.writeInt(1);
         pkg.writeInt(playerVO.playerDirection);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomRenewalFee(roomID:int) : void
      {
         var pkg:PackageOut = new PackageOut(191);
         pkg.writeByte(3);
         pkg.writeInt(roomID);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomInvite(playerID:int) : void
      {
         var pkg:PackageOut = new PackageOut(191);
         pkg.writeByte(4);
         pkg.writeInt(playerID);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomAdminRemovePlayer(playerID:int) : void
      {
         var pkg:PackageOut = new PackageOut(191);
         pkg.writeByte(9);
         pkg.writeInt(playerID);
         sendPackage(pkg);
      }
      
      public function sendHotSpringRoomPlayerContinue(isContinue:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(191);
         pkg.writeByte(10);
         pkg.writeBoolean(isContinue);
         sendPackage(pkg);
      }
      
      public function sendGetTimeBox(boxType:int, boxNumber:int, lession:int = -1, level:int = -1) : void
      {
         var pkg:PackageOut = new PackageOut(53);
         pkg.writeInt(boxType);
         pkg.writeInt(boxNumber);
         pkg.writeInt(lession);
         pkg.writeInt(level);
         sendPackage(pkg);
      }
      
      public function sendAchievementFinish(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(230);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendReworkRank(rank:String) : void
      {
         var pkg:PackageOut = new PackageOut(189);
         pkg.writeUTF(rank);
         sendPackage(pkg);
      }
      
      public function sendLookupEffort(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(203);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendBeginFightNpc() : void
      {
         var pkg:PackageOut = new PackageOut(50);
         sendPackage(pkg);
      }
      
      public function sendRequestUpdate() : void
      {
         var pkg:PackageOut = new PackageOut(225);
         sendPackage(pkg);
      }
      
      public function sendQuestionReply(questionReply:int) : void
      {
         var pkg:PackageOut = new PackageOut(89);
         pkg.writeInt(questionReply);
         sendPackage(pkg);
      }
      
      public function sendOpenVip(name:String, days:int, bool:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(92);
         pkg.writeUTF(name);
         pkg.writeInt(days);
         pkg.writeBoolean(bool);
         pkg.writeBoolean(PlayerManager.Instance.vipActivity);
         sendPackage(pkg);
      }
      
      public function sendAcademyRegister(UserID:int, IsPublishEquip:Boolean, introduction:String = null, isAmend:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(141);
         pkg.writeByte(1);
         pkg.writeInt(UserID);
         pkg.writeBoolean(IsPublishEquip);
         pkg.writeUTF(introduction);
         pkg.writeBoolean(isAmend);
         sendPackage(pkg);
      }
      
      public function sendAcademyRemoveRegister() : void
      {
         var pkg:PackageOut = new PackageOut(141);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendAcademyApprentice(id:int, introduction:String) : void
      {
         var pkg:PackageOut = new PackageOut(141);
         pkg.writeByte(4);
         pkg.writeInt(id);
         pkg.writeUTF(introduction);
         sendPackage(pkg);
      }
      
      public function sendAcademyMaster(id:int, introduction:String) : void
      {
         var pkg:PackageOut = new PackageOut(141);
         pkg.writeByte(5);
         pkg.writeInt(id);
         pkg.writeUTF(introduction);
         sendPackage(pkg);
      }
      
      public function sendAcademyMasterConfirm(value:Boolean, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(141);
         if(value)
         {
            pkg.writeByte(6);
         }
         else
         {
            pkg.writeByte(8);
         }
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendAcademyApprenticeConfirm(value:Boolean, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(141);
         if(value)
         {
            pkg.writeByte(7);
         }
         else
         {
            pkg.writeByte(9);
         }
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendAcademyFireMaster(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(141);
         pkg.writeByte(12);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendAcademyFireApprentice(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(141);
         pkg.writeByte(13);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendUseLog(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(213);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendBuyGift(nickName:String, goodsId:int, count:int, type:int) : void
      {
         var pkg:PackageOut = new PackageOut(221);
         pkg.writeUTF(nickName);
         pkg.writeInt(goodsId);
         pkg.writeInt(count);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendReloadGift() : void
      {
         var pkg:PackageOut = new PackageOut(214);
         sendPackage(pkg);
      }
      
      public function sendSnsMsg($typeId:int) : void
      {
         var pkg:PackageOut = new PackageOut(40);
         pkg.writeInt($typeId);
         sendPackage(pkg);
      }
      
      public function getPlayerCardInfo(playerId:int) : void
      {
         var pkg:PackageOut = new PackageOut(18);
         pkg.writeInt(playerId);
         sendPackage(pkg);
      }
      
      public function sendMoveCards(from:int, to:int) : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(0);
         pkg.writeInt(from);
         pkg.writeInt(to);
         sendPackage(pkg);
      }
      
      public function sendOpenViceCard(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(1);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendOpenCardBox(id:int, num:int, bagType:int) : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(1);
         pkg.writeInt(id);
         pkg.writeInt(num);
         pkg.writeInt(bagType);
         sendPackage(pkg);
      }
      
      public function sendOpenRandomBox(id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(4);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendOpenSpecialCardBox(id:int, num:int, bagType:int) : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(9);
         pkg.writeInt(id);
         pkg.writeInt(num);
         pkg.writeInt(bagType);
         sendPackage(pkg);
      }
      
      public function sendOpenNationWord(id:int, place:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(288);
         pkg.writeByte(4);
         pkg.writeByte(id);
         pkg.writeInt(place);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendUpGradeCard(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(2);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendUpdateSLOT(place:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(170);
         pkg.writeInt(0);
         pkg.writeInt(place);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendResetCardSoul(bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(170);
         pkg.writeInt(1);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendCardReset(place:int, level:int, lockStates:Array, isBind:Boolean) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(196);
         pkg.writeInt(0);
         pkg.writeInt(place);
         pkg.writeInt(level);
         for(i = 0; i < lockStates.length; )
         {
            pkg.writeInt(lockStates[i]);
            i++;
         }
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendReplaceCardProp(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(196);
         pkg.writeInt(1);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendSortCards(data:Vector.<int>) : void
      {
         var i:int = 0;
         var old:int = 0;
         var now:int = 0;
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(2);
         var len:int = data.length;
         pkg.writeInt(len);
         for(i = 0; i < len; )
         {
            old = data[i];
            now = i + 5;
            pkg.writeInt(old);
            pkg.writeInt(now);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendFirstGetCards() : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(3);
         sendPackage(pkg);
      }
      
      public function sendFace(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(20);
         pkg.writeInt(id);
         pkg.writeInt(0);
         sendPackage(pkg);
      }
      
      public function sendOpition(value:int) : void
      {
         var pkg:PackageOut = new PackageOut(64);
         pkg.writeInt(value);
         sendPackage(pkg);
      }
      
      public function sendConsortionMail(topic:String, content:String) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(29);
         pkg.writeUTF(topic);
         pkg.writeUTF(content);
         sendPackage(pkg);
      }
      
      public function sendConsortionPoll(candidateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(25);
         pkg.writeInt(candidateID);
         sendPackage(pkg);
      }
      
      public function sendConsortionSkill(isopen:Boolean, id:int, vaildDay:int, type:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(26);
         pkg.writeBoolean(isopen);
         pkg.writeInt(id);
         pkg.writeInt(vaildDay);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendOns() : void
      {
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(45);
         sendPackage(pkg);
      }
      
      public function sendWithBrithday(vec:Vector.<FriendListPlayer>) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(223);
         pkg.writeInt(vec.length);
         for(i = 0; i < vec.length; )
         {
            pkg.writeInt(vec[i].ID);
            pkg.writeUTF(vec[i].NickName);
            pkg.writeDate(vec[i].BirthdayDate);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendChangeDesignation(boo:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(34);
         pkg.writeBoolean(boo);
         sendPackage(pkg);
      }
      
      public function sendDailyRecord() : void
      {
         var pkg:PackageOut = new PackageOut(103);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendCollectInfoValidate(type:int, validate:String, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(32);
         pkg.writeByte(type);
         pkg.writeUTF(validate);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendGoodsExchange(list:Vector.<SendGoodsExchangeInfo>, ActiveID:int, count:int, awardIndex:int) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(31);
         pkg.writeInt(ActiveID);
         pkg.writeInt(count);
         pkg.writeInt(list.length);
         for(i = 0; i < list.length; )
         {
            pkg.writeInt(list[i].id);
            pkg.writeInt(list[i].place);
            pkg.writeInt(list[i].bagType);
            i++;
         }
         pkg.writeInt(awardIndex);
         sendPackage(pkg);
      }
      
      public function sendTexp(type:int, templateID:int, count:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(99);
         pkg.writeInt(type);
         pkg.writeInt(templateID);
         pkg.writeInt(count);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendMark(id:int, markName:String) : void
      {
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(162);
         pkg.writeInt(id);
         pkg.writeUTF(markName);
         sendPackage(pkg);
      }
      
      public function sendCustomFriends(type:int, id:int, name:String) : void
      {
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(208);
         pkg.writeByte(type);
         pkg.writeInt(id);
         pkg.writeUTF(name);
         sendPackage(pkg);
      }
      
      public function sendOneOnOneTalk(id:int, content:String, isAutoReply:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(51);
         pkg.writeInt(id);
         pkg.writeUTF(content);
         pkg.writeBoolean(isAutoReply);
         sendPackage(pkg);
      }
      
      public function sendUserLuckyNum(num:int, hasChoose:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(161);
         pkg.writeBoolean(hasChoose);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendPicc(id:int, price:int) : void
      {
         var pkg:PackageOut = new PackageOut(30);
         pkg.writeInt(id);
         pkg.writeInt(price);
         sendPackage(pkg);
      }
      
      public function sendBuyBadge(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(28);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendGetEliteGameState() : void
      {
         var pkg:PackageOut = new PackageOut(162);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendGetSelfRankSroce() : void
      {
         var pkg:PackageOut = new PackageOut(162);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendGetPaarungDetail(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(162);
         pkg.writeByte(4);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendEliteGameStart() : void
      {
         var pkg:PackageOut = new PackageOut(162);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function sendStartTurn_LeftGun() : void
      {
         var pkg:PackageOut = new PackageOut(128);
         pkg.writeInt(1);
         sendPackage(pkg);
      }
      
      public function sendEndTurn_LeftGun() : void
      {
         var pkg:PackageOut = new PackageOut(130);
         pkg.writeInt(1);
         sendPackage(pkg);
      }
      
      public function sendWishBeadEquip(equipPlace:int, equipBagType:int, equipId:int, beadPlace:int, beadBagType:int, beadId:int) : void
      {
         var pkg:PackageOut = new PackageOut(106);
         pkg.writeInt(equipPlace);
         pkg.writeInt(equipBagType);
         pkg.writeInt(equipId);
         pkg.writeInt(beadPlace);
         pkg.writeInt(beadBagType);
         pkg.writeInt(beadId);
         sendPackage(pkg);
      }
      
      public function sendPetCellUnlock(isBind:Boolean, times:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(10);
         pkg.writeBoolean(isBind);
         pkg.writeInt(times);
         sendPackage(pkg);
      }
      
      public function sendPetMove(fromPlace:int, toPlace:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(3);
         pkg.writeInt(fromPlace);
         pkg.writeInt(toPlace);
         sendPackage(pkg);
      }
      
      public function sendPetFightUnFight(place:int, isFight:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(17);
         pkg.writeInt(place);
         pkg.writeBoolean(isFight);
         sendPackage(pkg);
      }
      
      public function sendPetFeed(foodPlace:int, foodBag:int, petPlace:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(4);
         pkg.writeInt(foodPlace);
         pkg.writeInt(foodBag);
         pkg.writeInt(petPlace);
         sendPackage(pkg);
      }
      
      public function sendEquipPetSkill(petPlace:int, skillID:int, index:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(7);
         pkg.writeInt(petPlace);
         pkg.writeInt(skillID);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendPetRename(place:int, name:String, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(9);
         pkg.writeInt(place);
         pkg.writeUTF(name);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendReleasePet(place:int, isPay:Boolean = false, isBind:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(8);
         pkg.writeInt(place);
         pkg.writeBoolean(isPay);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendAdoptPet(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(6);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendRefreshPet(isPay:Boolean = false, bool:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(5);
         pkg.writeBoolean(isPay);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendUpdatePetInfo(plyaerID:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(1);
         pkg.writeInt(plyaerID);
         sendPackage(pkg);
      }
      
      public function sendPaySkill(placeID:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(16);
         pkg.writeInt(placeID);
         sendPackage(pkg);
      }
      
      public function sendAddPet(placeID:int, bagType:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(2);
         pkg.writeInt(placeID);
         pkg.writeInt(bagType);
         sendPackage(pkg);
      }
      
      public function sendNewTitleCard(placeID:int, bagType:int) : void
      {
         var pkg:PackageOut = new PackageOut(265);
         pkg.writeByte(bagType);
         pkg.writeInt(placeID);
         sendPackage(pkg);
      }
      
      public function enterFarm(useid:int) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(1);
         p.writeInt(useid);
         sendPackage(p);
      }
      
      public function seeding(fieldID:int, seedsId:int) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(2);
         p.writeByte(13);
         p.writeInt(seedsId);
         p.writeInt(fieldID);
         sendPackage(p);
      }
      
      public function sendCompose(foodID:int, count:int = 1) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(5);
         p.writeInt(foodID);
         p.writeInt(count);
         sendPackage(p);
      }
      
      public function doMature(type:int, fieldID:int, manureId:int) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(3);
         p.writeByte(13);
         p.writeInt(type);
         p.writeInt(manureId);
         p.writeInt(fieldID);
         sendPackage(p);
      }
      
      public function toGather(userid:int, fieldid:int) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(4);
         p.writeInt(userid);
         p.writeInt(fieldid);
         sendPackage(p);
      }
      
      public function toSpread(idArr:Array, payDate:int, bool:Boolean) : void
      {
         if(!idArr || idArr.length == 0)
         {
            return;
         }
         var p:PackageOut = new PackageOut(81);
         p.writeByte(6);
         p.writeInt(idArr.length);
         var _loc7_:int = 0;
         var _loc6_:* = idArr;
         for each(var id in idArr)
         {
            p.writeInt(id);
         }
         p.writeInt(payDate);
         p.writeBoolean(bool);
         sendPackage(p);
      }
      
      public function toSpreadByProsperity(id:int) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(246);
         p.writeInt(id);
         sendPackage(p);
      }
      
      public function sendWish() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(148);
         sendPackage(pkg);
      }
      
      public function sendChangeSex(bagType:int, place:int, num:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(252);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendVipCoupons(bagType:int, place:int, count:int, content:String, nickName:String) : void
      {
         var pkg:PackageOut = new PackageOut(369);
         pkg.writeInt(bagType);
         pkg.writeInt(place);
         pkg.writeInt(count);
         pkg.writeUTF(content);
         pkg.writeUTF(nickName);
         sendPackage(pkg);
      }
      
      public function toFarmHelper(temp:Array, isAuto:Boolean) : void
      {
         var i:int = 0;
         var obj:* = null;
         var p:PackageOut = new PackageOut(81);
         p.writeByte(9);
         p.writeInt(temp.length);
         for(i = 0; i < temp.length; )
         {
            obj = temp[i];
            p.writeInt(obj.currentfindIndex);
            p.writeInt(obj.currentSeedText);
            p.writeInt(obj.currentSeedNum);
            p.writeInt(obj.currentFertilizerText);
            p.writeInt(obj.autoFertilizerNum);
            p.writeBoolean(isAuto);
            i++;
         }
         sendPackage(p);
      }
      
      public function sendBeginHelper(array:Array) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(9);
         pkg.writeBoolean(array[0]);
         if(array[0])
         {
            pkg.writeInt(array[1]);
            pkg.writeInt(array[2]);
            pkg.writeInt(array[3]);
            pkg.writeInt(array[4]);
            pkg.writeInt(array[5]);
            pkg.writeInt(array[6]);
            pkg.writeBoolean(array[7]);
         }
         sendPackage(pkg);
      }
      
      public function toKillCrop(fieldId:int) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(7);
         p.writeInt(fieldId);
         sendPackage(p);
      }
      
      public function toHelperRenewMoney(hour:int, bool:Boolean) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(8);
         p.writeInt(hour);
         p.writeBoolean(bool);
         sendPackage(p);
      }
      
      public function exitFarm(playerID:int) : void
      {
         var p:PackageOut = new PackageOut(81);
         p.writeByte(16);
         p.writeInt(playerID);
         sendPackage(p);
      }
      
      public function fastForwardGrop(isBind:Boolean, isAll:Boolean, index:int) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(18);
         pkg.writeBoolean(isBind);
         pkg.writeBoolean(isAll);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function giftPacks(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(20);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function getFarmPoultryLevel(userId:int) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(21);
         pkg.writeInt(userId);
         sendPackage(pkg);
      }
      
      public function initFarmTree() : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(22);
         sendPackage(pkg);
      }
      
      public function callFarmPoultry(treeLevel:int) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(23);
         pkg.writeInt(treeLevel);
         sendPackage(pkg);
      }
      
      public function wakeFarmPoultry(id:uint) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(24);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function inviteWakeFarmPoultry() : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(34);
         sendPackage(pkg);
      }
      
      public function feedFarmPoultry(id:uint) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(33);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function farmCondenser(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(25);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function farmWater(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(81);
         pkg.writeByte(32);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function getPlayerPropertyAddition() : void
      {
         var p:PackageOut = new PackageOut(164);
         sendPackage(p);
      }
      
      public function enterWorldBossRoom() : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(32);
         sendPackage(pkg);
      }
      
      public function openOrCloseWorldBossHelper(data:WorldBossHelperTypeData) : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(39);
         pkg.writeByte(data.requestType);
         if(data.requestType == 2)
         {
            pkg.writeBoolean(data.isOpen);
            pkg.writeInt(data.buffNum);
            pkg.writeInt(data.type);
            pkg.writeInt(data.openType);
         }
         sendPackage(pkg);
      }
      
      public function quitWorldBossHelperView() : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(40);
         pkg.writeBoolean(false);
         sendPackage(pkg);
      }
      
      public function sendAddPlayer(position:Point) : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(34);
         pkg.writeInt(position.x);
         pkg.writeInt(position.y);
         sendPackage(pkg);
      }
      
      public function sendAddAllWorldBossPlayer() : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(14);
         sendPackage(pkg);
      }
      
      public function sendWorldBossRoomMove(endX:int, endY:int, path:String) : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(35);
         pkg.writeInt(endX);
         pkg.writeInt(endY);
         pkg.writeUTF(path);
         sendPackage(pkg);
      }
      
      public function sendWorldBossRoomStauts(status:int) : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(36);
         pkg.writeByte(status);
         sendPackage(pkg);
      }
      
      public function sendLeaveBossRoom() : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(33);
         sendPackage(pkg);
      }
      
      public function sendBuyWorldBossBuff(arr:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(38);
         pkg.writeInt(arr.length);
         for(i = 0; i < arr.length; )
         {
            pkg.writeInt(arr[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendNewBuyWorldBossBuff(type:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(102);
         pkg.writeByte(38);
         pkg.writeInt(1);
         pkg.writeInt(type);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendRevertPet(petPos:int, bool:Boolean) : void
      {
         var p:PackageOut = new PackageOut(68);
         p.writeByte(18);
         p.writeInt(petPos);
         p.writeBoolean(bool);
         sendPackage(p);
      }
      
      public function requestForLuckStone() : void
      {
         var p:PackageOut = new PackageOut(165);
         sendPackage(p);
      }
      
      public function sendOpenOneTotem(isActPro:Boolean, isBind:Boolean) : void
      {
         var p:PackageOut = new PackageOut(136);
         p.writeBoolean(isActPro);
         p.writeBoolean(isBind);
         sendPackage(p);
      }
      
      public function sendNewChickenBox() : void
      {
         var pkg:PackageOut = new PackageOut(87);
         pkg.writeByte(10);
         sendPackage(pkg);
      }
      
      public function sendChickenBoxUseEagleEye(position:int) : void
      {
         var p:PackageOut = new PackageOut(87);
         p.writeByte(11);
         p.writeInt(position);
         sendPackage(p);
      }
      
      public function sendChickenBoxTakeOverCard(position:int) : void
      {
         var p:PackageOut = new PackageOut(87);
         p.writeByte(13);
         p.writeInt(position);
         sendPackage(p);
      }
      
      public function sendOverShowItems() : void
      {
         var p:PackageOut = new PackageOut(87);
         p.writeByte(12);
         sendPackage(p);
      }
      
      public function sendFlushNewChickenBox() : void
      {
         var pkg:PackageOut = new PackageOut(87);
         pkg.writeByte(14);
         sendPackage(pkg);
      }
      
      public function sendClickStartBntNewChickenBox() : void
      {
         var pkg:PackageOut = new PackageOut(87);
         pkg.writeByte(15);
         sendPackage(pkg);
      }
      
      public function labyrinthRequestUpdate(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(2);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function labyrinthCleanOut(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(3);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function labyrinthSpeededUpCleanOut(type:int, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(4);
         pkg.writeInt(type);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function labyrinthStopCleanOut(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(5);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function figSpiritUpGrade(obj:GemstnoeSendInfo) : void
      {
         var pkg:PackageOut = new PackageOut(209);
         pkg.writeByte(3);
         pkg.writeInt(obj.autoBuyId);
         pkg.writeInt(obj.goodsId);
         pkg.writeInt(obj.type);
         pkg.writeInt(obj.templeteId);
         pkg.writeInt(obj.fightSpiritId);
         pkg.writeInt(obj.equipPlayce);
         pkg.writeInt(obj.place);
         pkg.writeInt(obj.count);
         sendPackage(pkg);
      }
      
      public function fightSpiritRequest() : void
      {
         var pkg:PackageOut = new PackageOut(209);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function labyrinthCleanOutTimerComplete(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(8);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function labyrinthDouble(type:int, value:Boolean) : void
      {
         if(value == false)
         {
            return;
         }
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(1);
         pkg.writeInt(type);
         pkg.writeBoolean(value);
         sendPackage(pkg);
      }
      
      public function labyrinthReset(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(6);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function labyrinthTryAgain(type:int, value:Boolean, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(131);
         pkg.writeInt(9);
         pkg.writeInt(type);
         pkg.writeBoolean(value);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function getspree(value:Object) : void
      {
         var pkg:PackageOut = new PackageOut(157);
         pkg.writeInt(5);
         pkg.writeInt(value.rewardId);
         pkg.writeInt(value.type);
         pkg.writeInt(value.regetType);
         pkg.writeInt(value.time);
         sendPackage(pkg);
      }
      
      public function sendHonorUp(type:int, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(96);
         pkg.writeByte(type);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendBuyPetExpItem(bool:Boolean) : void
      {
         var p:PackageOut = new PackageOut(68);
         p.writeByte(19);
         p.writeBoolean(bool);
         sendPackage(p);
      }
      
      public function sendOpenKingBless(type:int, playerId:int, msg:String, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(142);
         pkg.writeByte(type);
         pkg.writeInt(playerId);
         pkg.writeUTF(msg);
         pkg.writeBoolean(bool);
         pkg.writeBoolean(PlayerManager.Instance.kingBuffActivity);
         sendPackage(pkg);
      }
      
      public function sendUseItemKingBless(place:int, bagType:int) : void
      {
         var pkg:PackageOut = new PackageOut(143);
         pkg.writeInt(place);
         pkg.writeInt(bagType);
         sendPackage(pkg);
      }
      
      public function sendTrusteeshipStart(questId:int) : void
      {
         var pkg:PackageOut = new PackageOut(140);
         pkg.writeByte(1);
         pkg.writeInt(questId);
         sendPackage(pkg);
      }
      
      public function sendTrusteeshipCancel(questId:int) : void
      {
         var pkg:PackageOut = new PackageOut(140);
         pkg.writeByte(2);
         pkg.writeInt(questId);
         sendPackage(pkg);
      }
      
      public function sendTrusteeshipSpeedUp(questId:int, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(140);
         pkg.writeByte(3);
         pkg.writeInt(questId);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendTrusteeshipBuySpirit(bool:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(140);
         pkg.writeByte(4);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function battleGroundUpdata(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(132);
         pkg.writeByte(3);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function battleGroundPlayerUpdata() : void
      {
         var pkg:PackageOut = new PackageOut(132);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendTrusteeshipUseSpiritItem(place:int, bagType:int, num:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(140);
         pkg.writeByte(5);
         pkg.writeInt(place);
         pkg.writeInt(bagType);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendGetGoods(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(155);
         pkg.writeByte(6);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendConsortiaBossInfo(type:int, callLevel:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(129);
         pkg.writeInt(30);
         pkg.writeByte(type);
         pkg.writeInt(callLevel);
         sendPackage(pkg);
      }
      
      public function sendLatentEnergy(type:int, equipBagType:int, equipPlace:int, itemBagType:int = -1, itemPlace:int = -1) : void
      {
         var pkg:PackageOut = new PackageOut(133);
         pkg.writeByte(type);
         pkg.writeInt(equipBagType);
         pkg.writeInt(equipPlace);
         if(type == 1)
         {
            pkg.writeInt(itemBagType);
            pkg.writeInt(itemPlace);
         }
         sendPackage(pkg);
      }
      
      public function sendWonderfulActivity(type:int, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(159);
         pkg.writeInt(type);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function requestWonderfulActInit(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(405);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendBattleCompanionGive(id:int, bagType:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(101);
         pkg.writeInt(id);
         pkg.writeInt(bagType);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function addPetEquip(place:int, petIndex:int, bagType:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(20);
         pkg.writeInt(bagType);
         pkg.writeInt(place);
         pkg.writeInt(petIndex);
         sendPackage(pkg);
      }
      
      public function delPetEquip(petIndex:int, type:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(21);
         pkg.writeInt(petIndex);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function necklaceStrength(num:int, place:int, type:int = 2) : void
      {
         var pkg:PackageOut = new PackageOut(95);
         pkg.writeByte(type);
         pkg.writeInt(place);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function enterBuried() : void
      {
         var pkg:PackageOut = new PackageOut(98);
         pkg.writeByte(0);
         sendPackage(pkg);
      }
      
      public function rollDice(bool:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(98);
         pkg.writeByte(1);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function upgradeStartLevel(bool:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(98);
         pkg.writeByte(2);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function refreshMap() : void
      {
         var pkg:PackageOut = new PackageOut(98);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function takeCard(bool:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(98);
         pkg.writeByte(3);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function outCard() : void
      {
         var pkg:PackageOut = new PackageOut(98);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendSearchGoodsGainRewards(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(98);
         pkg.writeByte(6);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendConsBatRequestPlayerInfo() : void
      {
         var pkg:PackageOut = new PackageOut(153);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendConsBatMove(endX:int, endY:int, path:String) : void
      {
         var pkg:PackageOut = new PackageOut(153);
         pkg.writeByte(4);
         pkg.writeInt(endX);
         pkg.writeInt(endY);
         pkg.writeUTF(path);
         sendPackage(pkg);
      }
      
      public function sendConsBatChallenge(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(153);
         pkg.writeByte(6);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendConsBatExit() : void
      {
         var pkg:PackageOut = new PackageOut(153);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendConsBatConsume(type:int, isBind:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(153);
         pkg.writeByte(17);
         pkg.writeInt(type);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendConsBatUpdateScore(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(153);
         pkg.writeByte(16);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function enterDayActivity() : void
      {
         var pkg:PackageOut = new PackageOut(155);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendConsBatConfirmEnter() : void
      {
         var pkg:PackageOut = new PackageOut(153);
         pkg.writeByte(21);
         sendPackage(pkg);
      }
      
      public function sendUpdateSysDate() : void
      {
         var pkg:PackageOut = new PackageOut(5);
         sendPackage(pkg);
      }
      
      public function sendDragonBoatBuildOrDecorate(type:int, count:int, flag:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(100);
         pkg.writeByte(2);
         pkg.writeByte(type);
         pkg.writeInt(count);
         pkg.writeBoolean(flag);
         sendPackage(pkg);
      }
      
      public function sendDragonBoatRefreshBoatStatus() : void
      {
         var pkg:PackageOut = new PackageOut(100);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendDragonBoatRefreshRank() : void
      {
         var pkg:PackageOut = new PackageOut(100);
         pkg.writeByte(16);
         sendPackage(pkg);
      }
      
      public function sendDragonBoatExchange(goodsId:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(100);
         pkg.writeByte(4);
         pkg.writeInt(goodsId);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function requestUnWeddingPay(friendsID:int) : void
      {
         var pkg:PackageOut = new PackageOut(207);
         pkg.writeByte(1);
         pkg.writeInt(friendsID);
         sendPackage(pkg);
      }
      
      public function requestShopPay(goodsIds:Array, types:Array, goodsTypes:Array, colors:Array, skins:Array, name:String, msg:String = "") : void
      {
         var i:int = 0;
         var len:int = goodsIds.length;
         var pkg:PackageOut = new PackageOut(207);
         pkg.writeByte(3);
         pkg.writeUTF(name);
         pkg.writeUTF(msg);
         pkg.writeInt(len);
         for(i = 0; i < len; )
         {
            pkg.writeInt(goodsIds[i]);
            pkg.writeInt(types[i]);
            pkg.writeInt(goodsTypes[i]);
            pkg.writeUTF(colors[i]);
            pkg.writeUTF(skins[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function requestAuctionPay(auctionID:int, name:String, msg:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(207);
         pkg.writeByte(5);
         pkg.writeInt(auctionID);
         pkg.writeUTF(name);
         pkg.writeUTF(msg);
         sendPackage(pkg);
      }
      
      public function sendWantStrongBack(type:int, findBackType:Boolean, isBand:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(147);
         pkg.writeInt(type);
         pkg.writeBoolean(findBackType);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function isAcceptPayShop(isAcceptPay:Boolean, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(207);
         pkg.writeByte(4);
         pkg.writeInt(id);
         pkg.writeBoolean(isAcceptPay);
         sendPackage(pkg);
      }
      
      public function isAcceptPayAuc(isAcceptPay:Boolean, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(207);
         pkg.writeByte(6);
         pkg.writeInt(id);
         pkg.writeBoolean(isAcceptPay);
         sendPackage(pkg);
      }
      
      public function sendForAuction(id:int, name:String) : void
      {
         var pkg:PackageOut = new PackageOut(207);
         pkg.writeByte(7);
         pkg.writeInt(id);
         pkg.writeUTF(name);
         sendPackage(pkg);
      }
      
      public function isAcceptPay(isAcceptPay:Boolean, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(207);
         pkg.writeByte(2);
         pkg.writeInt(id);
         pkg.writeBoolean(isAcceptPay);
         sendPackage(pkg);
      }
      
      public function CampbattleEnterFight(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(5);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function CampbattleRoleMove(zoneID:int, userID:int, p:Point) : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(2);
         pkg.writeInt(p.x);
         pkg.writeInt(p.y);
         pkg.writeInt(zoneID);
         pkg.writeInt(userID);
         sendPackage(pkg);
      }
      
      public function changeMap() : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function outCampBatttle() : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function captureMap(bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(17);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function requestPRankList() : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(21);
         sendPackage(pkg);
      }
      
      public function requestCRankList() : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(20);
         sendPackage(pkg);
      }
      
      public function enterPTPFight(zoneID:int, userID:int) : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(16);
         pkg.writeInt(zoneID);
         pkg.writeInt(userID);
         sendPackage(pkg);
      }
      
      public function returnToPve() : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function resurrect(isBind:Boolean, isCost:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(146);
         pkg.writeByte(18);
         pkg.writeBoolean(isCost);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendGroupPurchaseRefreshData() : void
      {
         var pkg:PackageOut = new PackageOut(144);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function sendGroupPurchaseRefreshRankData() : void
      {
         var pkg:PackageOut = new PackageOut(144);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendGroupPurchaseBuy(num:int, isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(144);
         pkg.writeByte(4);
         pkg.writeInt(num);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendRegressPkg() : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(0);
         sendPackage(pkg);
      }
      
      public function sendRegressGetAwardPkg(awardID:int) : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(1);
         pkg.writeInt(awardID);
         sendPackage(pkg);
      }
      
      public function sendRegressCheckPlayer(playerName:String) : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(2);
         pkg.writeUTF(playerName);
         sendPackage(pkg);
      }
      
      public function sendRegressApplyEnable() : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function sendRegressApllyPacks() : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendRegressCall(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(4);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendRegressRecvPacks() : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendRegressTicketInfo() : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function sendRegressTicket() : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function sendExpBlessedData() : void
      {
         var pkg:PackageOut = new PackageOut(155);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function sendGameTrusteeship(flag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(149);
         pkg.writeBoolean(flag);
         sendPackage(pkg);
      }
      
      public function sendInitTreasueHunting() : void
      {
         var pkg:PackageOut = new PackageOut(110);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendPayForHunting(isBind:Boolean, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(110);
         pkg.writeByte(2);
         pkg.writeBoolean(isBind);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function getAllTreasure() : void
      {
         var pkg:PackageOut = new PackageOut(110);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function updateTreasureBag() : void
      {
         var pkg:PackageOut = new PackageOut(110);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function sendHuntingByScore() : void
      {
         var pkg:PackageOut = new PackageOut(110);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendConvertScore(isConver:Boolean, totalSorce:int = 0, lotteryScore:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(110);
         pkg.writeByte(6);
         pkg.writeBoolean(isConver);
         pkg.writeInt(totalSorce);
         pkg.writeInt(lotteryScore);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleCallCar(carType:int, isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(3);
         pkg.writeInt(carType);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleStartGame(isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(6);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleCancelGame() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleReady() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleMove() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(17);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleUseSkill(type:int, isBand:Boolean, isFree:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(21);
         pkg.writeInt(type);
         pkg.writeBoolean(isBand);
         pkg.writeBoolean(isFree);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleCanEnter() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(35);
         sendPackage(pkg);
      }
      
      public function sendBuyEnergy(isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(105);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendSevenDoubleEnterOrLeaveScene(isEnter:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(38);
         pkg.writeBoolean(isEnter);
         sendPackage(pkg);
      }
      
      public function sendWonderfulActivityGetReward(sendInfoVec:Vector.<SendGiftInfo>) : void
      {
         var i:int = 0;
         var j:int = 0;
         var pkg:PackageOut = new PackageOut(373);
         pkg.writeInt(sendInfoVec.length);
         for(i = 0; i < sendInfoVec.length; )
         {
            pkg.writeUTF(sendInfoVec[i].activityId);
            pkg.writeInt(sendInfoVec[i].awardCount);
            pkg.writeInt(sendInfoVec[i].giftIdArr.length);
            for(j = 0; j < sendInfoVec[i].giftIdArr.length; )
            {
               if(sendInfoVec[i].giftIdArr[j] is GiftChildInfo)
               {
                  pkg.writeUTF(sendInfoVec[i].giftIdArr[j].giftId);
                  pkg.writeInt(sendInfoVec[i].giftIdArr[j].index);
               }
               else
               {
                  pkg.writeUTF(sendInfoVec[i].giftIdArr[j]);
                  pkg.writeInt(0);
               }
               j++;
            }
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendRingStationGetInfo() : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendBuyBattleCountOrTime(isBand:Boolean, timeFlag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(2);
         pkg.writeBoolean(timeFlag);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendRingStationChallenge(userId:int, rank:int) : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(5);
         pkg.writeInt(userId);
         pkg.writeInt(rank);
         sendPackage(pkg);
      }
      
      public function sendRingStationArmory() : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendGetRingStationReward() : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function sendRingStationBattleField() : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function sendRingStationFightFlag() : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function sendRouletteRun() : void
      {
         var pkg:PackageOut = new PackageOut(110);
         pkg.writeByte(17);
         sendPackage(pkg);
      }
      
      public function getBackLockPwdByPhone(step:int, str1:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(403);
         pkg.writeByte(1);
         pkg.writeInt(step);
         pkg.writeUTF(str1);
         sendPackage(pkg);
      }
      
      public function getBackLockPwdByQuestion(step:int, str1:String = "", str2:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(403);
         pkg.writeByte(2);
         pkg.writeInt(step);
         pkg.writeUTF(str1);
         pkg.writeUTF(str2);
         sendPackage(pkg);
      }
      
      public function deletePwdQuestion(step:int, str1:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(403);
         pkg.writeByte(3);
         pkg.writeInt(step);
         pkg.writeUTF(str1);
         sendPackage(pkg);
      }
      
      public function deletePwdByPhone(step:int, str1:String = "") : void
      {
         var pkg:PackageOut = new PackageOut(403);
         pkg.writeByte(4);
         pkg.writeInt(step);
         pkg.writeUTF(str1);
         sendPackage(pkg);
      }
      
      public function checkPhoneBind() : void
      {
         var pkg:PackageOut = new PackageOut(403);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendActivityDungeonNextPoints(type:int, flag:Boolean, playerID:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(79);
         pkg.writeByte(type);
         pkg.writeBoolean(flag);
         pkg.writeInt(playerID);
         sendPackage(pkg);
      }
      
      public function sendButChristmasGoods(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(26);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function enterChristmasRoomIsTrue() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(17);
         pkg.writeByte(0);
         sendPackage(pkg);
      }
      
      public function enterChristmasRoom(point:Point) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(17);
         pkg.writeByte(2);
         pkg.writeInt(point.x);
         pkg.writeInt(point.y);
         sendPackage(pkg);
      }
      
      public function enterMakingSnowManRoom() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(24);
         sendPackage(pkg);
      }
      
      public function getPacksToPlayer(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(27);
         pkg.writeByte(num);
         sendPackage(pkg);
      }
      
      public function sendLeaveChristmasRoom() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(17);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendChristmasRoomMove(endX:int, endY:int, path:String) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(21);
         pkg.writeInt(endX);
         pkg.writeInt(endY);
         pkg.writeUTF(path);
         sendPackage(pkg);
      }
      
      public function sendChristmasUpGrade(num:int, isDouble:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(25);
         pkg.writeInt(num);
         pkg.writeBoolean(isDouble);
         sendPackage(pkg);
      }
      
      public function sendStartFightWithMonster(pMonsterID:int) : void
      {
         var p:PackageOut = new PackageOut(145);
         p.writeByte(22);
         p.writeInt(pMonsterID);
         sendPackage(p);
      }
      
      public function sendBuyPlayingSnowmanVolumes(isBand:Boolean) : void
      {
         var p:PackageOut = new PackageOut(145);
         p.writeByte(29);
         sendPackage(p);
      }
      
      public function sendLanternRiddlesQuestion() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(38);
         sendPackage(pkg);
      }
      
      public function sendLanternRiddlesAnswer(id:int, index:int, option:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(40);
         pkg.writeInt(id);
         pkg.writeInt(index);
         pkg.writeInt(option);
         sendPackage(pkg);
      }
      
      public function sendLanternRiddlesUseSkill(id:int, index:int, type:int, isBand:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(41);
         pkg.writeInt(id);
         pkg.writeInt(index);
         pkg.writeInt(type);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendLanternRiddlesRankInfo() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(42);
         sendPackage(pkg);
      }
      
      public function getRedPacketInfo() : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(8);
         p.writeInt(2);
         sendPackage(p);
      }
      
      public function getBuyinfo() : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(10);
         p.writeInt(2);
         sendPackage(p);
      }
      
      public function buybuybuy(type:int, index:int, country:int, num:int) : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(10);
         p.writeInt(3);
         p.writeInt(type);
         p.writeInt(index);
         p.writeInt(country);
         p.writeInt(num);
         sendPackage(p);
      }
      
      public function getRedPacketpublish(strName:String, totalMoney:int, giftCount:int) : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(8);
         p.writeInt(6);
         p.writeUTF(strName);
         p.writeInt(totalMoney);
         p.writeInt(giftCount);
         sendPackage(p);
      }
      
      public function getRedFightKingScore() : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(9);
         p.writeInt(2);
         sendPackage(p);
      }
      
      public function getRedPacketRecord(id:int) : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(8);
         p.writeInt(4);
         p.writeInt(id);
         sendPackage(p);
      }
      
      public function getRobRedPacket(id:int) : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(8);
         p.writeInt(5);
         p.writeInt(id);
         sendPackage(p);
      }
      
      public function sendCatchBeastViewInfo() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(33);
         sendPackage(pkg);
      }
      
      public function sendCatchBeastChallenge() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(34);
         sendPackage(pkg);
      }
      
      public function sendCatchBeastBuyBuff(isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(35);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendCatchBeastGetAward(boxID:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(36);
         pkg.writeInt(boxID);
         sendPackage(pkg);
      }
      
      public function sendAccumulativeLoginAward(templeteId:int) : void
      {
         var pkg:PackageOut = new PackageOut(238);
         pkg.writeInt(templeteId);
         sendPackage(pkg);
      }
      
      public function sendAvatarCollectionActive(id:int, itemId:int, sex:int, type:int) : void
      {
         var pkg:PackageOut = new PackageOut(402);
         pkg.writeByte(3);
         pkg.writeInt(id);
         pkg.writeInt(itemId);
         pkg.writeInt(sex);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendAvatarCollectionDelayTime(id:int, count:int, type:int) : void
      {
         trace("----------------id:",id,"count:",count);
         var pkg:PackageOut = new PackageOut(402);
         pkg.writeByte(4);
         pkg.writeInt(id);
         pkg.writeInt(count);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function setCurrentModel(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(237);
         pkg.writeByte(2);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function saveDressModel(index:int, arr:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(237);
         pkg.writeByte(1);
         pkg.writeInt(index);
         pkg.writeInt(arr.length);
         for(i = 0; i <= arr.length - 1; )
         {
            pkg.writeInt(0);
            pkg.writeInt(arr[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function foldDressItem(arr:Array, firstPackageType:int, secPackageType:int) : void
      {
         var temArr:* = null;
         var i:int = 0;
         if(arr.length > 100)
         {
            temArr = arr.splice(0,100);
            foldDressItem(temArr,firstPackageType,secPackageType);
            foldDressItem(arr,firstPackageType,secPackageType);
            return;
         }
         var pkg:PackageOut = new PackageOut(firstPackageType);
         pkg.writeByte(secPackageType);
         pkg.writeInt(arr.length);
         for(i = 0; i <= arr.length - 1; )
         {
            pkg.writeInt(arr[i].sPlace);
            pkg.writeInt(arr[i].tPlace);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function lockDressBag() : void
      {
         var pkg:PackageOut = new PackageOut(237);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function receiveLandersAward() : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(49);
         sendPackage(pkg);
      }
      
      public function getFlowerRankInfo(type:int, page:int) : void
      {
         var pkg:PackageOut = new PackageOut(257);
         pkg.writeByte(4);
         pkg.writeInt(type);
         pkg.writeInt(page);
         sendPackage(pkg);
      }
      
      public function sendGetFlowerReward(type:int, index:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(257);
         pkg.writeByte(5);
         pkg.writeInt(type);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function getFlowerRewardStatus() : void
      {
         var pkg:PackageOut = new PackageOut(257);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function sendFlower(playerName:String, num:int, message:String) : void
      {
         var pkg:PackageOut = new PackageOut(257);
         pkg.writeByte(1);
         pkg.writeUTF(playerName);
         pkg.writeInt(num);
         pkg.writeUTF(message);
         sendPackage(pkg);
      }
      
      public function sendFlowerRecord() : void
      {
         var pkg:PackageOut = new PackageOut(257);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendUpdateIntegral() : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function sendBuyRegressIntegralGoods(id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(149);
         pkg.writeByte(10);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendPlayerExit(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(2);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendOtherPlayerInfo() : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(0);
         sendPackage(pkg);
      }
      
      public function sendPlayerPos(x:int, y:int) : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(3);
         pkg.writeInt(x);
         pkg.writeInt(y);
         sendPackage(pkg);
      }
      
      public function sendAddNewPlayer(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(4);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendModifyNewPlayerDress() : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendUpdatePets(flag:Boolean, id:int, petsID:int) : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(9);
         pkg.writeBoolean(flag);
         pkg.writeInt(id);
         pkg.writeInt(petsID);
         sendPackage(pkg);
      }
      
      public function sendNewHallPlayerHid(flag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(7);
         pkg.writeBoolean(flag);
         sendPackage(pkg);
      }
      
      public function sendNewHallBattle() : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(99);
         sendPackage(pkg);
      }
      
      public function sendLoadOtherPlayer() : void
      {
         var pkg:PackageOut = new PackageOut(262);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function sendHorseChangeHorse(tag:int) : void
      {
         var pkg:PackageOut = new PackageOut(260);
         pkg.writeByte(2);
         pkg.writeInt(tag);
         sendPackage(pkg);
      }
      
      public function sendActiveHorsePicCherish(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(260);
         pkg.writeByte(7);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendHorseUpHorse(count:int) : void
      {
         var pkg:PackageOut = new PackageOut(260);
         pkg.writeByte(3);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendHorseUpSkill(skillId:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(260);
         pkg.writeByte(5);
         pkg.writeInt(skillId);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendHorseTakeUpDownSkill(skillId:int, status:int) : void
      {
         var pkg:PackageOut = new PackageOut(260);
         pkg.writeByte(6);
         pkg.writeInt(skillId);
         pkg.writeInt(status);
         sendPackage(pkg);
      }
      
      public function sendBallteHorseTakeUpDownSkill(skillid:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(260);
         pkg.writeByte(10);
         pkg.writeInt(skillid);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendBombKingStartBattle() : void
      {
         var pkg:PackageOut = new PackageOut(263);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function updateBombKingMainFrame() : void
      {
         var pkg:PackageOut = new PackageOut(263);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function updateBombKingRank(type:int, page:int) : void
      {
         var pkg:PackageOut = new PackageOut(263);
         pkg.writeByte(5);
         pkg.writeInt(type);
         pkg.writeInt(page);
         sendPackage(pkg);
      }
      
      public function updateBombKingBattleLog() : void
      {
         var pkg:PackageOut = new PackageOut(263);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function updateBKingItemEquip(useId:int, areaId:int, type:int) : void
      {
         var pkg:PackageOut = new PackageOut(263);
         pkg.writeByte(1);
         pkg.writeInt(useId);
         pkg.writeInt(areaId);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function getBKingStatueInfo() : void
      {
         var pkg:PackageOut = new PackageOut(263);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function requestBKingShowTip() : void
      {
         var pkg:PackageOut = new PackageOut(263);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function sendCollectionSceneEnter() : void
      {
         var pkg:PackageOut = new PackageOut(261);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendCollectionSceneMove(endX:int, endY:int, path:String) : void
      {
         var pkg:PackageOut = new PackageOut(261);
         pkg.writeByte(2);
         pkg.writeInt(endX);
         pkg.writeInt(endY);
         pkg.writeUTF(path);
         sendPackage(pkg);
      }
      
      public function sendCollectionComplete(collectedId:int) : void
      {
         var pkg:PackageOut = new PackageOut(261);
         pkg.writeByte(3);
         pkg.writeInt(collectedId);
         sendPackage(pkg);
      }
      
      public function sendLeaveCollectionScene() : void
      {
         var pkg:PackageOut = new PackageOut(261);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function sendPetRisingStar(templeteId:int, count:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(22);
         pkg.writeInt(templeteId);
         pkg.writeInt(count);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendPetEvolution(templeteId:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(23);
         pkg.writeInt(templeteId);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendPetFormInfo() : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(24);
         sendPackage(pkg);
      }
      
      public function sendPetFollowOrCall(flag:Boolean, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(25);
         pkg.writeBoolean(flag);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendPetWake(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(32);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendUsePetTemporaryCard(bagType:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(35);
         pkg.writeInt(bagType);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendPetBreak(tagPet:int, useProtect:Boolean, eatPetPosList:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(31);
         pkg.writeInt(tagPet);
         pkg.writeBoolean(useProtect);
         for(i = 0; i < eatPetPosList.length; )
         {
            pkg.writeInt(eatPetPosList[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendBreakInfoRequire(targetGrade:int) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(34);
         pkg.writeInt(targetGrade);
         sendPackage(pkg);
      }
      
      public function sendEscortCallCar(carType:int, isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(3);
         pkg.writeInt(carType);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendEscortStartGame(isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(6);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendEscortCancelGame() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function sendEscortReady() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function sendEscortMove() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(17);
         sendPackage(pkg);
      }
      
      public function sendEscortUseSkill(type:int, isBand:Boolean, isFree:Boolean, otherId:int = 0, otherZone:int = -1) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(21);
         pkg.writeInt(type);
         pkg.writeBoolean(isBand);
         pkg.writeBoolean(isFree);
         pkg.writeInt(otherId);
         pkg.writeInt(otherZone);
         sendPackage(pkg);
      }
      
      public function sendEscortCanEnter() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(35);
         sendPackage(pkg);
      }
      
      public function sendEscortEnterOrLeaveScene(isEnter:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(38);
         pkg.writeBoolean(isEnter);
         sendPackage(pkg);
      }
      
      public function sendPeerID(zoneID:int, userID:int, peerID:String) : void
      {
         var pkg:PackageOut = new PackageOut(272);
         pkg.writeInt(zoneID);
         pkg.writeInt(userID);
         pkg.writeUTF(peerID);
         sendPackage(pkg);
      }
      
      public function exploreMagicStone(type:int, isBind:Boolean, count:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(1);
         pkg.writeInt(type);
         pkg.writeBoolean(isBind);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function getMagicStoneScore() : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function convertMgStoneScore(goodsId:int, bind:Boolean = true, count:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(5);
         pkg.writeInt(goodsId);
         pkg.writeBoolean(bind);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function moveMagicStone(sourcePlace:int, targetPlace:int) : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(3);
         pkg.writeInt(sourcePlace);
         pkg.writeInt(targetPlace);
         sendPackage(pkg);
      }
      
      public function lockMagicStone(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(6);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function updateMagicStone(pSlots:Array) : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(2);
         pkg.writeInt(pSlots.length);
         var _loc5_:int = 0;
         var _loc4_:* = pSlots;
         for each(var o in pSlots)
         {
            pkg.writeInt(o);
         }
         sendPackage(pkg);
      }
      
      public function sortMgStoneBag(array:Array, startPlace:int) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(9);
         pkg.writeInt(array.length);
         for(i = 0; i < array.length; )
         {
            pkg.writeInt(array[i].Place);
            pkg.writeInt(i + startPlace);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function updateRemainCount() : void
      {
         var pkg:PackageOut = new PackageOut(258);
         pkg.writeByte(16);
         sendPackage(pkg);
      }
      
      public function updateConsumeRank() : void
      {
         var pkg:PackageOut = new PackageOut(259);
         sendPackage(pkg);
      }
      
      public function updateRechargeRank() : void
      {
         var pkg:PackageOut = new PackageOut(352);
         sendPackage(pkg);
      }
      
      public function cooking(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(274);
         if(type == 1)
         {
            pkg.writeByte(FoodActivityEvent.SIMPLE_COOKING);
         }
         else
         {
            pkg.writeByte(FoodActivityEvent.PAY_COOKING);
         }
         sendPackage(pkg);
      }
      
      public function cookingGetAward(value:int) : void
      {
         var pkg:PackageOut = new PackageOut(274);
         pkg.writeByte(FoodActivityEvent.REWARD);
         pkg.writeInt(value);
         sendPackage(pkg);
      }
      
      public function updateCookingCountByTime() : void
      {
         var pkg:PackageOut = new PackageOut(274);
         pkg.writeByte(FoodActivityEvent.UPDATE_COUNT_BYTIME);
         sendPackage(pkg);
      }
      
      public function updateDrgnBoatBuildInfo(id:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(49);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function commitDrgnBoatMaterial(stage:int) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(50);
         pkg.writeInt(stage);
         sendPackage(pkg);
      }
      
      public function helpToBuildDrgnBoat(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(51);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function broadcastMissileMC() : void
      {
         var pkg:PackageOut = new PackageOut(148);
         pkg.writeByte(43);
         sendPackage(pkg);
      }
      
      public function enterMagpieBridge() : void
      {
         var pkg:PackageOut = new PackageOut(276);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function magpieRollDice() : void
      {
         var pkg:PackageOut = new PackageOut(276);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function buyMagpieCount(num:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(276);
         pkg.writeByte(3);
         pkg.writeInt(num);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function refreshMagpieView() : void
      {
         var pkg:PackageOut = new PackageOut(276);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function exitMagpieView() : void
      {
         var pkg:PackageOut = new PackageOut(276);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendCryptBossFight(id:int, star:int) : void
      {
         var pkg:PackageOut = new PackageOut(275);
         pkg.writeByte(3);
         pkg.writeInt(id);
         pkg.writeInt(star);
         sendPackage(pkg);
      }
      
      public function sendGetShopBuyLimitedCount() : void
      {
         var pkg:PackageOut = new PackageOut(288);
         sendPackage(pkg);
      }
      
      public function requestRescueItemInfo() : void
      {
         var pkg:PackageOut = new PackageOut(277);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function requestRescueFrameInfo(sceneId:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(277);
         pkg.writeByte(7);
         pkg.writeInt(sceneId);
         sendPackage(pkg);
      }
      
      public function sendRescueChallenge(sceneId:int) : void
      {
         var pkg:PackageOut = new PackageOut(277);
         pkg.writeByte(3);
         pkg.writeInt(sceneId);
         sendPackage(pkg);
      }
      
      public function sendRescueCleanCD(isBind:Boolean, sceneId:int) : void
      {
         var pkg:PackageOut = new PackageOut(277);
         pkg.writeByte(5);
         pkg.writeBoolean(isBind);
         pkg.writeInt(sceneId);
         sendPackage(pkg);
      }
      
      public function sendRescueBuyBuff(type:int, count:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(277);
         pkg.writeByte(4);
         pkg.writeInt(type);
         pkg.writeInt(count);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function useRescueKingBless() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(94);
         sendPackage(pkg);
      }
      
      public function getRescuePrize(sceneId:int, index:int) : void
      {
         var pkg:PackageOut = new PackageOut(277);
         pkg.writeByte(8);
         pkg.writeInt(sceneId);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function enterOrLeaveInsectScene(flag:int, point:Point = null) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(143);
         pkg.writeByte(flag);
         if(point)
         {
            pkg.writeInt(point.x);
            pkg.writeInt(point.y);
         }
         sendPackage(pkg);
      }
      
      public function sendFightWithInsect(pMonsterID:int) : void
      {
         var p:PackageOut = new PackageOut(145);
         p.writeByte(140);
         p.writeInt(pMonsterID);
         sendPackage(p);
      }
      
      public function sendInsectSceneMove(endX:int, endY:int, path:String) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(141);
         pkg.writeInt(endX);
         pkg.writeInt(endY);
         pkg.writeUTF(path);
         sendPackage(pkg);
      }
      
      public function updateInsectInfo() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(135);
         sendPackage(pkg);
      }
      
      public function updateInsectAreaRank() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(137);
         sendPackage(pkg);
      }
      
      public function updateInsectAreaSelfInfo() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(132);
         sendPackage(pkg);
      }
      
      public function updateInsectLocalRank() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(136);
         sendPackage(pkg);
      }
      
      public function updateInsectLocalSelfInfo() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(138);
         sendPackage(pkg);
      }
      
      public function getInsectPrize(templateId:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(139);
         pkg.writeInt(templateId);
         sendPackage(pkg);
      }
      
      public function requestCakeStatus() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(134);
         sendPackage(pkg);
      }
      
      public function requestInsectWhistleUse(templateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(154);
         pkg.writeInt(templateID);
         sendPackage(pkg);
      }
      
      public function requestInsectWhistleBuy(goodId:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(155);
         pkg.writeInt(goodId);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function showHideTitleState(flag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(279);
         pkg.writeBoolean(flag);
         sendPackage(pkg);
      }
      
      public function sendEnchant(isUpGrade:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(280);
         pkg.writeBoolean(isUpGrade);
         sendPackage(pkg);
      }
      
      public function getNationDayInfo() : void
      {
         var pkg:PackageOut = new PackageOut(288);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function exchangeNationalGoods(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(288);
         pkg.writeByte(3);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function getHalloweenViewInfo() : void
      {
         var pkg:PackageOut = new PackageOut(283);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function getHalloweenExchangeViewInfo() : void
      {
         var pkg:PackageOut = new PackageOut(283);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function getHalloweenExchange(index:int, count:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(283);
         pkg.writeByte(3);
         pkg.writeInt(index);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function getHalloweenSetExchange() : void
      {
         var pkg:PackageOut = new PackageOut(283);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function getHalloweenCandyNum() : void
      {
         var pkg:PackageOut = new PackageOut(283);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function requestRookieRankInfo() : void
      {
         var pkg:PackageOut = new PackageOut(286);
         sendPackage(pkg);
      }
      
      public function sendBuyLevelFund(isBind:Boolean, buyType:int) : void
      {
         var pkg:PackageOut = new PackageOut(290);
         pkg.writeByte(2);
         pkg.writeBoolean(isBind);
         pkg.writeInt(buyType);
         sendPackage(pkg);
      }
      
      public function sendGetLevelFundAward(level:int) : void
      {
         var pkg:PackageOut = new PackageOut(290);
         pkg.writeByte(3);
         pkg.writeInt(level);
         sendPackage(pkg);
      }
      
      public function sendOpenDailyView() : void
      {
         var pkg:PackageOut = new PackageOut(293);
         sendPackage(pkg);
      }
      
      public function sendForgeSuit(value:int) : void
      {
         var pkg:PackageOut = new PackageOut(295);
         pkg.writeByte(1);
         pkg.writeInt(value);
         sendPackage(pkg);
      }
      
      public function getHomeTempleLevel() : void
      {
         var pkg:PackageOut = new PackageOut(297);
         pkg.writeByte(0);
         sendPackage(pkg);
      }
      
      public function setHomeTempleSelectIndex(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(297);
         pkg.writeByte(2);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function setHomeTempleImmolation(id:int, flag:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(297);
         pkg.writeByte(1);
         pkg.writeInt(id);
         pkg.writeBoolean(flag);
         sendPackage(pkg);
      }
      
      public function wishingTreeSendWish(count:int) : void
      {
         var pkg:PackageOut = new PackageOut(299);
         pkg.writeByte(3);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function wishingTreeUpdateFrame() : void
      {
         var pkg:PackageOut = new PackageOut(299);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function arrange(useID:int) : void
      {
         var p:PackageOut = new PackageOut(135);
         p.writeInt(1);
         p.writeInt(useID);
         sendPackage(p);
      }
      
      public function enterTreasure() : void
      {
         var p:PackageOut = new PackageOut(135);
         p.writeInt(0);
         sendPackage(p);
      }
      
      public function startTreasure() : void
      {
         var p:PackageOut = new PackageOut(135);
         p.writeInt(6);
         sendPackage(p);
      }
      
      public function endTreasure() : void
      {
         var p:PackageOut = new PackageOut(135);
         p.writeInt(2);
         sendPackage(p);
      }
      
      public function doTreasure(pos:int) : void
      {
         var p:PackageOut = new PackageOut(135);
         p.writeInt(3);
         p.writeInt(pos);
         sendPackage(p);
      }
      
      public function wishingTreeGetReward(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(299);
         pkg.writeByte(4);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function wishingTreeGetRecord() : void
      {
         var pkg:PackageOut = new PackageOut(299);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function enterPyramid() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function getVipIntegralShopLimit() : void
      {
         var pkg:PackageOut = new PackageOut(312);
         sendPackage(pkg);
      }
      
      public function buyVipIntegralShopGoods(id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(311);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function uploadDraftStyle(style:String, color:String) : void
      {
         var pkg:PackageOut = new PackageOut(310);
         pkg.writeUTF(style);
         pkg.writeUTF(color);
         sendPackage(pkg);
      }
      
      public function getPlayerSpecialProperty(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(321);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendDraftVoteTicket(num:int, styleId:int) : void
      {
         var pkg:PackageOut = new PackageOut(309);
         pkg.writeInt(num);
         pkg.writeInt(styleId);
         sendPackage(pkg);
      }
      
      public function getToyMachineInfo() : void
      {
         var pkg:PackageOut = new PackageOut(324);
         sendPackage(pkg);
      }
      
      public function sendToyMachineReward(index:int, count:int, isPay:Boolean, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(326);
         pkg.writeInt(index);
         pkg.writeInt(count);
         pkg.writeBoolean(isPay);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function happyRechargeEnter() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(179);
         sendPackage(pkg);
      }
      
      public function happyRechargeStartLottery() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(176);
         sendPackage(pkg);
      }
      
      public function happyRechargeExchange(count:int, itemId:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(177);
         pkg.writeInt(count);
         pkg.writeInt(itemId);
         sendPackage(pkg);
      }
      
      public function happyRechargeQuestGetItem(type:int = 2) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(181);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendMemoryGameInfo() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(11);
         sendPackage(pkg);
      }
      
      public function sendMemoryGameTurnover(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(12);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendMemoryGameReset(isBand:Boolean, isFree:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(13);
         pkg.writeBoolean(isFree);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendMemoryGameBuy(value:int, isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(14);
         pkg.writeInt(value);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendMemoryGameGetReward(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(16);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendGuardCoreLevelUp() : void
      {
         var pkg:PackageOut = new PackageOut(336);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendGuardCoreEquip(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(336);
         pkg.writeByte(2);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function getVipAndMerryInfo(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(169);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendEnterGame() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(CloudBuyLotteryPackageType.Enter_GAME);
         sendPackage(pkg);
      }
      
      public function sendYGBuyGoods(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(CloudBuyLotteryPackageType.BUY_GOODS);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendLuckDrawGo() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(CloudBuyLotteryPackageType.GET_REWARD);
         sendPackage(pkg);
      }
      
      public function makeNewYearRice(type:int, roomTyple:int, arr:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(167);
         pkg.writeInt(type);
         pkg.writeInt(roomTyple);
         if(type != 0)
         {
            pkg.writeInt(arr.length);
            for(i = 0; i < arr.length; )
            {
               pkg.writeInt(arr[i].id);
               pkg.writeInt(arr[i].number);
               i++;
            }
         }
         sendPackage(pkg);
      }
      
      public function sendCheckNewYearRiceInfo() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(162);
         sendPackage(pkg);
      }
      
      public function sendCheckMakeNewYearFood() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(163);
         sendPackage(pkg);
      }
      
      public function sendNewYearRiceOpen(playerNum:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(165);
         pkg.writeInt(playerNum);
         sendPackage(pkg);
      }
      
      public function sendExitYearFoodRoom() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(166);
         sendPackage(pkg);
      }
      
      public function sendInviteYearFoodRoom(isInvite:Boolean, playerID:int, isPublish:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(164);
         pkg.writeBoolean(isInvite);
         if(!isInvite)
         {
            pkg.writeBoolean(isPublish);
         }
         pkg.writeInt(playerID);
         sendPackage(pkg);
      }
      
      public function sendQuitNewYearRiceRoom(playerID:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(168);
         pkg.writeInt(playerID);
         sendPackage(pkg);
      }
      
      public function clickAnotherDimensionEnter() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(7);
         pkg.writeInt(3);
         sendPackage(pkg);
      }
      
      public function clickAnotherDimenZhanling(pos:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(7);
         pkg.writeInt(5);
         pkg.writeInt(pos);
         sendPackage(pkg);
      }
      
      public function clickAnotherDimenSearch() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(7);
         pkg.writeInt(4);
         sendPackage(pkg);
      }
      
      public function clickAnotherDimenUpgrade(type:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(7);
         pkg.writeInt(6);
         pkg.writeInt(type);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function treasurePuzzle_enter() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(103);
         sendPackage(pkg);
      }
      
      public function treasurePuzzle_seeReward() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(104);
         sendPackage(pkg);
      }
      
      public function treasurePuzzle_getReward(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(105);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function treasurePuzzle_savePlayerInfo(name:String, phoneNum:String, address:String, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(107);
         pkg.writeUTF(name);
         pkg.writeUTF(phoneNum);
         pkg.writeUTF(address);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function treasurePuzzle_usePice(place:int, num:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(106);
         pkg.writeInt(place);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function petIslandInit(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(187);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function redEnvelopeListInfo() : void
      {
         var pkg:PackageOut = new PackageOut(2184);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendRedEnvelope(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(2184);
         pkg.writeByte(2);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function getRedEnvelope(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(2184);
         pkg.writeByte(1);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function redEnvelopeInfo(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(2184);
         pkg.writeByte(3);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function buyLotteryTicket(gameIndex:int, arr:Array) : void
      {
         var i:int = 0;
         var str:* = null;
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(13);
         pkg.writeInt(1);
         pkg.writeInt(gameIndex);
         pkg.writeInt(arr.length);
         for(i = 0; i < arr.length; )
         {
            str = arr[i].ticketArr.join("");
            pkg.writeUTF(str);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function updataLotteryPool() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(13);
         pkg.writeInt(3);
         sendPackage(pkg);
      }
      
      public function getLotteryPrizeInfo() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(13);
         pkg.writeInt(2);
         sendPackage(pkg);
      }
      
      public function sendSignMsg(msg:String) : void
      {
         var pkg:PackageOut = new PackageOut(404);
         pkg.writeByte(7);
         pkg.writeUTF(msg);
         sendPackage(pkg);
      }
      
      public function petIslandBuyBlood(useSkillType:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(188);
         pkg.writeInt(useSkillType);
         sendPackage(pkg);
      }
      
      public function petIslandPlay(type:int, socre:int, bol:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(189);
         pkg.writeInt(type);
         pkg.writeInt(socre);
         pkg.writeBoolean(bol);
         sendPackage(pkg);
      }
      
      public function sendEntertainment() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(71);
         sendPackage(pkg);
      }
      
      public function buyEntertainment(bol:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(72);
         pkg.writeBoolean(bol);
         sendPackage(pkg);
      }
      
      public function petIslandPrize(step:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(190);
         pkg.writeInt(step);
         sendPackage(pkg);
      }
      
      public function eatPetsHandler(typeChoose:int, typeUse:int, count:int, petsArr:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(33);
         pkg.writeInt(typeChoose);
         pkg.writeInt(typeUse);
         if(typeUse == 1)
         {
            pkg.writeInt(petsArr.length);
            for(i = 0; i < petsArr.length; )
            {
               pkg.writeInt(petsArr[i][0]);
               pkg.writeInt(petsArr[i][1].TemplateID);
               i++;
            }
         }
         else
         {
            pkg.writeInt(count);
         }
         sendPackage(pkg);
      }
      
      public function sendCheckMagicStoneNumber() : void
      {
         var pkg:PackageOut = new PackageOut(284);
         sendPackage(pkg);
      }
      
      public function sendOpenDeed(type:int, playerId:int, msg:String, bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(142);
         pkg.writeByte(type);
         pkg.writeInt(playerId);
         pkg.writeUTF(msg);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendUseItemDeed(place:int, bagType:int) : void
      {
         var pkg:PackageOut = new PackageOut(143);
         pkg.writeInt(place);
         pkg.writeInt(bagType);
         sendPackage(pkg);
      }
      
      public function prayIndianaEnter() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(171);
         sendPackage(pkg);
      }
      
      public function prayIndianaLottery() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(173);
         sendPackage(pkg);
      }
      
      public function prayIndianaGoodsRefresh() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(172);
         sendPackage(pkg);
      }
      
      public function prayIndianaPray($type:int, $initx:Number = 0.0, $targetx:Number = 0.0, $value:Number = 0.0) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(174);
         pkg.writeInt($type);
         if($type == 2)
         {
            pkg.writeInt($initx * 1000);
            pkg.writeInt($targetx * 1000);
            pkg.writeInt($value * 1000);
         }
         sendPackage(pkg);
      }
      
      public function sendGetCSMTimeBox() : void
      {
         var pkg:PackageOut = new PackageOut(360);
         sendPackage(pkg);
      }
      
      public function sendLuckyStarEnter() : void
      {
         var pkg:PackageOut = new PackageOut(87);
         pkg.writeByte(31);
         sendPackage(pkg);
      }
      
      public function sendLuckyStarClose() : void
      {
         var pkg:PackageOut = new PackageOut(87);
         pkg.writeByte(32);
         sendPackage(pkg);
      }
      
      public function sendLuckyStarTurnComplete() : void
      {
         var pkg:PackageOut = new PackageOut(87);
         pkg.writeByte(34);
         sendPackage(pkg);
      }
      
      public function sendLuckyStarTurn() : void
      {
         var pkg:PackageOut = new PackageOut(87);
         pkg.writeByte(33);
         sendPackage(pkg);
      }
      
      public function enterGodsRoads() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(87);
         sendPackage(pkg);
      }
      
      public function getGodsRoadsAwards(type:int, para:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(88);
         pkg.writeInt(type);
         pkg.writeInt(para);
         sendPackage(pkg);
      }
      
      public function sendChickActivationOpenKey(strKey:String) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(2);
         pkg.writeInt(1);
         pkg.writeUTF(strKey);
         sendPackage(pkg);
      }
      
      public function sendChickActivationGetAward(index:int, levelIndex:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(2);
         pkg.writeInt(2);
         pkg.writeInt(index);
         pkg.writeInt(levelIndex);
         sendPackage(pkg);
      }
      
      public function sendChickActivationQuery() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(2);
         pkg.writeInt(3);
         sendPackage(pkg);
      }
      
      public function DDPlayEnter() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(75);
         sendPackage(pkg);
      }
      
      public function DDPlayStart() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(76);
         sendPackage(pkg);
      }
      
      public function DDPlayExchange(num:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(77);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendUseEveryDayGiftRecord(templateID:int, itemID:int, index:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(3);
         pkg.writeInt(2);
         pkg.writeInt(templateID);
         pkg.writeInt(itemID);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function openMagicLib(type:int, pos:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(4);
         pkg.writeInt(1);
         pkg.writeInt(type);
         pkg.writeInt(pos);
         sendPackage(pkg);
      }
      
      public function magicLibLevelUp(type:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(4);
         pkg.writeInt(2);
         pkg.writeInt(type);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function magicLibFreeGet(count:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(4);
         pkg.writeInt(3);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function magicLibChargeGet(count:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(4);
         pkg.writeInt(4);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function magicOpenDepot(pos:int, bol:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(4);
         pkg.writeInt(5);
         pkg.writeInt(pos);
         pkg.writeBoolean(bol);
         sendPackage(pkg);
      }
      
      public function magicboxExtraction(id:int, counts:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(4);
         pkg.writeInt(6);
         pkg.writeInt(id);
         pkg.writeInt(counts);
         sendPackage(pkg);
      }
      
      public function magicboxFusion(id:int, counts:int = 1, value:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(4);
         pkg.writeInt(7);
         pkg.writeInt(id);
         pkg.writeInt(counts);
         pkg.writeBoolean(value);
         sendPackage(pkg);
      }
      
      public function zodiacRolling() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(6);
         pkg.writeInt(1);
         sendPackage(pkg);
      }
      
      public function zodiacGetAward(questID:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(6);
         pkg.writeInt(2);
         pkg.writeInt(questID);
         sendPackage(pkg);
      }
      
      public function zodiacGetAwardAll() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(6);
         pkg.writeInt(3);
         sendPackage(pkg);
      }
      
      public function zodiacAddCounts(bol:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(6);
         pkg.writeInt(4);
         pkg.writeBoolean(bol);
         sendPackage(pkg);
      }
      
      public function enterSuperWinner() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(49);
         sendPackage(pkg);
      }
      
      public function rollDiceInSuperWinner() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(50);
         sendPackage(pkg);
      }
      
      public function outSuperWinner() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(51);
         sendPackage(pkg);
      }
      
      public function witchBlessing_enter(num:int = 0) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(113);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendWitchBless(num:int, boo:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(114);
         pkg.writeInt(num);
         pkg.writeBoolean(boo);
         sendPackage(pkg);
      }
      
      public function sendWitchGetAwards(num:int, boo:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(112);
         pkg.writeInt(num);
         pkg.writeBoolean(boo);
         sendPackage(pkg);
      }
      
      public function sevenDayTarget_enter(ishall:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(81);
         pkg.writeBoolean(ishall);
         sendPackage(pkg);
      }
      
      public function newPlayerReward_enter() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(97);
         sendPackage(pkg);
      }
      
      public function sevenDayTarget_getReward(qustionID:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(82);
         pkg.writeInt(qustionID);
         sendPackage(pkg);
      }
      
      public function newPlayerReward_getReward(qustionID:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(98);
         pkg.writeInt(qustionID);
         sendPackage(pkg);
      }
      
      public function sendHorseRaceItemUse(gameID:int, bufftype:int, useID:int, targetID:int) : void
      {
         var nowtime:int = getTimer();
         var cd:int = nowtime - HorseRaceManager.Instance.buffCD;
         if(cd < 1000)
         {
            return;
         }
         var pkg:PackageOut = new PackageOut(282);
         pkg.writeInt(gameID);
         pkg.writeInt(1);
         pkg.writeInt(bufftype);
         pkg.writeInt(useID);
         pkg.writeInt(targetID);
         pkg.writeInt(5);
         sendPackage(pkg);
         HorseRaceManager.Instance.buffCD = getTimer();
      }
      
      public function sendHorseRaceItemUse2(gameID:int, useId:int) : void
      {
         var nowtime:int = getTimer();
         var cd:int = nowtime - HorseRaceManager.Instance.buffCD;
         if(cd < 1000)
         {
            return;
         }
         var pkg:PackageOut = new PackageOut(282);
         pkg.writeInt(gameID);
         pkg.writeInt(2);
         pkg.writeInt(useId);
         pkg.writeInt(5);
         sendPackage(pkg);
         HorseRaceManager.Instance.buffCD = getTimer();
      }
      
      public function sendHorseRaceEnd(gameID:int, useId:int) : void
      {
         var pkg:PackageOut = new PackageOut(282);
         pkg.writeInt(gameID);
         pkg.writeInt(3);
         pkg.writeInt(useId);
         sendPackage(pkg);
      }
      
      public function buyHorseRaceCount() : void
      {
         var pkg:PackageOut = new PackageOut(282);
         pkg.writeInt(0);
         pkg.writeInt(4);
         sendPackage(pkg);
      }
      
      public function sendBoguAdventureEnter() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(90);
         sendPackage(pkg);
      }
      
      public function sendBoguAdventureWalkInfo(type:int, index:int = 0, bol:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(91);
         pkg.writeInt(type);
         pkg.writeBoolean(bol);
         if(type != 3)
         {
            pkg.writeInt(index);
         }
         sendPackage(pkg);
      }
      
      public function sendBoguAdventureUpdateGame(type:int, bol:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(92);
         pkg.writeInt(type);
         pkg.writeBoolean(bol);
         sendPackage(pkg);
      }
      
      public function sendBoguAdventureAcquireAward(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(93);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendOutBoguAdventure() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(94);
         sendPackage(pkg);
      }
      
      public function sendGuildMemberWeekStarEnter() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function sendGuildMemberWeekStarClose() : void
      {
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function sendGuildMemberWeekAddRanking(data:Array) : void
      {
         var i:* = 0;
         var count:int = data.length;
         var pkg:PackageOut = new PackageOut(145);
         pkg.writeByte(10);
         pkg.writeInt(count);
         for(i = uint(0); i < count; )
         {
            pkg.writeInt(data[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendDaySign(date:Date) : void
      {
         var pkg:PackageOut = new PackageOut(13);
         pkg.writeInt(6);
         pkg.writeDate(date);
         sendPackage(pkg);
      }
      
      public function sendGetCardSoul() : void
      {
         var pkg:PackageOut = new PackageOut(216);
         pkg.writeInt(8);
         sendPackage(pkg);
      }
      
      public function sendGrowthPackageOpen(bol:Boolean) : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(1);
         p.writeInt(1);
         p.writeBoolean(bol);
         sendPackage(p);
      }
      
      public function sendGrowthPackageGetItems($index:int) : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(1);
         p.writeInt(2);
         p.writeInt($index);
         sendPackage(p);
      }
      
      public function sendFastAuctionBugle(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(327);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function queryDDQiYuanMyInfo() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(39);
         sendPackage(pkg);
      }
      
      public function queryDDQiYuanRankRewardConfig() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(33);
         sendPackage(pkg);
      }
      
      public function sendDDQiYuanOfferTimes(type:int, useBindQuan:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(38);
         pkg.writeInt(type);
         pkg.writeBoolean(useBindQuan);
         sendPackage(pkg);
      }
      
      public function sendDDQiYuanOpenTreasureBox(useBindQuan:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(34);
         pkg.writeBoolean(useBindQuan);
         sendPackage(pkg);
      }
      
      public function queryDDQiYuanAreaRank(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(37);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function queryDDQiYuanTowerTask() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(35);
         sendPackage(pkg);
      }
      
      public function getDDQiYuanTowerTaskReward(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(36);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function getDDQiYuanJoinReward() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(51);
         sendPackage(pkg);
      }
      
      public function sendAngelInvestmentUpdate() : void
      {
         var pkg:PackageOut = new PackageOut(357);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function loginDeviceSendUaToCheck(b:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(11);
         pkg.writeInt(1);
         pkg.writeBoolean(b);
         sendPackage(pkg);
      }
      
      public function loginDeviceGetDownReward() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(11);
         pkg.writeInt(2);
         sendPackage(pkg);
      }
      
      public function loginDeviceGetDailyReward() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(11);
         pkg.writeInt(3);
         sendPackage(pkg);
      }
      
      public function sendAngelInvestmentBuyOne($id:int, $isBind:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(357);
         pkg.writeByte(2);
         pkg.writeBoolean($isBind);
         pkg.writeInt($id);
         sendPackage(pkg);
      }
      
      public function sendAngelInvestmentGainOne($id:int) : void
      {
         var pkg:PackageOut = new PackageOut(357);
         pkg.writeByte(4);
         pkg.writeInt($id);
         sendPackage(pkg);
      }
      
      public function sendAngelInvestmentGainAll() : void
      {
         var pkg:PackageOut = new PackageOut(357);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendAngelInvestmentBuyAll($isBind:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(357);
         pkg.writeByte(3);
         pkg.writeBoolean($isBind);
         sendPackage(pkg);
      }
      
      public function sendBombTurnTableLottery() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(54);
         sendPackage(pkg);
      }
      
      public function requestBombTurnTableData() : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(53);
         sendPackage(pkg);
      }
      
      public function sendWasteRecycleStartTurn() : void
      {
         var pkg:PackageOut = new PackageOut(346);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendWasteRecycleEnter() : void
      {
         var pkg:PackageOut = new PackageOut(346);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendWasteRecycleGoods(count:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(346);
         pkg.writeByte(2);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function queryOnlineRewardInfo() : void
      {
         var pkg:PackageOut = new PackageOut(353);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function getOnlineReward() : void
      {
         var pkg:PackageOut = new PackageOut(353);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function queryOnlineRewardBoxConfig() : void
      {
         var pkg:PackageOut = new PackageOut(353);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function queryConsortionCallBackInfo() : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function getConsortionCallBackAward(awardID:int) : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(5);
         pkg.writeInt(awardID);
         sendPackage(pkg);
      }
      
      public function BuyCallFund() : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function getCallFund() : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function queryCallFundInfo() : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function buyCallLotteryDrawGood(type:int, cardIndex:int, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(4);
         pkg.writeInt(type);
         pkg.writeInt(cardIndex);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function refreshCallLotteryDrawInfo(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(3);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function queryCallLotteryDrawGoods(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(9);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function inspire(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(368);
         pkg.writeByte(7);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function exchangeScore(day:int, id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(368);
         pkg.writeByte(6);
         pkg.writeInt(day);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function cityBattleInfo() : void
      {
         var pkg:PackageOut = new PackageOut(368);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function cityBattleScore() : void
      {
         var pkg:PackageOut = new PackageOut(368);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function cityBattleJoin(side:int) : void
      {
         var pkg:PackageOut = new PackageOut(368);
         pkg.writeByte(2);
         pkg.writeInt(side);
         sendPackage(pkg);
      }
      
      public function cityBattleRank() : void
      {
         var pkg:PackageOut = new PackageOut(368);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function cityBattleExchange(day:int) : void
      {
         var pkg:PackageOut = new PackageOut(368);
         pkg.writeByte(4);
         pkg.writeInt(day);
         sendPackage(pkg);
      }
      
      public function sendGainOldPlayerGift() : void
      {
         var pkg:PackageOut = new PackageOut(343);
         pkg.writeByte(10);
         sendPackage(pkg);
      }
      
      public function getSignBuff(power:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(12);
         pkg.writeInt(1);
         pkg.writeInt(power);
         sendPackage(pkg);
      }
      
      public function enterDemonChiYouScene() : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(0);
         sendPackage(pkg);
      }
      
      public function getDemonChiYouOtherPlayerInfo() : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function leaveDemonChiYouScene() : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function buyDemonChiYouRoll(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(5);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function buyDemonChiYouShopItem(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(7);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function getDemonChiYouRankInfo() : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function getDemonChiYouBossInfo() : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function getDemonChiYouShopInfo() : void
      {
         var pkg:PackageOut = new PackageOut(314);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function requestCardAchievement() : void
      {
         var pkg:PackageOut = new PackageOut(362);
         sendPackage(pkg);
      }
      
      public function sendCardAchievementType(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(361);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendDDTKingGradeInfo() : void
      {
         var pkg:PackageOut = new PackageOut(370);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendDDTKingGradeReset(isAll:Boolean, type:int) : void
      {
         var pkg:PackageOut = new PackageOut(370);
         pkg.writeByte(2);
         pkg.writeBoolean(isAll);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function sendDDTKingGradeUp(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(370);
         pkg.writeByte(1);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function sendPetsAwaken() : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(37);
         sendPackage(pkg);
      }
      
      public function getConsortiaDomainOtherPlayerInfo() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function leaveConsortiaDomainScene() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function getConsortiaDomainMonsterInfoInFight() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function getConsortiaDomainBuildInfoInFight() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(10);
         sendPackage(pkg);
      }
      
      public function getConsortiaDomainConsortiaInfo() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(12);
         sendPackage(pkg);
      }
      
      public function sendConsortiaDomainMove(pathArr:Array) : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(4);
         pkg.writeInt(pathArr.length);
         var _loc5_:int = 0;
         var _loc4_:* = pathArr;
         for each(var point in pathArr)
         {
            pkg.writeInt(point.x);
            pkg.writeInt(point.y);
         }
         sendPackage(pkg);
      }
      
      public function sendConsortiaDomainFight(livingId:int) : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(5);
         pkg.writeInt(livingId);
         sendPackage(pkg);
      }
      
      public function sendConsortiaDomainActive() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function sendConsortiaDomainRepair(buildId:int) : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(8);
         pkg.writeInt(buildId);
         sendPackage(pkg);
      }
      
      public function getConsortiaDomainKillInfo() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(13);
         sendPackage(pkg);
      }
      
      public function getConsortiaDomainActiveState() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(15);
         sendPackage(pkg);
      }
      
      public function getSevendayProgressCount() : void
      {
         var pkg:PackageOut = new PackageOut(363);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function getConsortiaDomainBuildRepairInfo() : void
      {
         var pkg:PackageOut = new PackageOut(371);
         pkg.writeByte(17);
         sendPackage(pkg);
      }
      
      public function sendQuestionAwardAnswer(data:String) : void
      {
         var pkg:PackageOut = new PackageOut(329);
         pkg.writeByte(64);
         pkg.writeUTF(data);
         sendPackage(pkg);
      }
      
      public function requestAwardItem() : void
      {
         var pkg:PackageOut = new PackageOut(618);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendRollDice(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(618);
         pkg.writeByte(2);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendBombPos(gameType:int, vx:int, vy:int, isbomb:Boolean, data:Array, bombinfo:Array) : void
      {
         var i:int = 0;
         var j:int = 0;
         var len:int = 0;
         var obj:* = null;
         var temp:* = null;
         var tempII:* = null;
         var a:int = 0;
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(3);
         pkg.writeInt(gameType);
         pkg.writeInt(vx);
         pkg.writeInt(vy);
         pkg.writeBoolean(isbomb);
         var aa:String = "";
         if(isbomb && data != null)
         {
            for(i = 0; i < 10; )
            {
               for(j = 0; j < 10; )
               {
                  pkg.writeByte(data[i][j]);
                  aa = aa + (data[i][j] + " ,");
                  j++;
               }
               i++;
            }
         }
         if(isbomb && bombinfo != null)
         {
            len = bombinfo.length;
            pkg.writeByte(len);
            temp = "爆炸的个数：" + len;
            tempII = "";
            for(a = 0; a < len; )
            {
               obj = bombinfo[a];
               pkg.writeByte(obj.vx);
               pkg.writeByte(obj.vy);
               pkg.writeByte(obj.order);
               a++;
            }
         }
         sendPackage(pkg);
      }
      
      public function sendHappyMiniGameActiveData() : void
      {
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function sendBombStart(gameType:int) : void
      {
         var mapData:* = null;
         var i:int = 0;
         var j:int = 0;
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(2);
         pkg.writeInt(gameType);
         var temp:String = "";
         if(gameType == 1)
         {
            mapData = HappyLittleGameManager.instance.bombManager.model.BombTrain;
            for(i = 0; i < 10; )
            {
               for(j = 0; j < 10; )
               {
                  pkg.writeInt(mapData[i][j]);
                  temp = temp + (mapData[i][j] + " ,");
                  j++;
               }
               i++;
            }
         }
         sendPackage(pkg);
      }
      
      public function sendBombEnterRoom(gameType:int) : void
      {
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(1);
         pkg.writeInt(gameType);
         sendPackage(pkg);
      }
      
      public function sendBombGameRank(gameType:int, rankType:int) : void
      {
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(5);
         pkg.writeInt(gameType);
         pkg.writeInt(rankType);
         sendPackage(pkg);
      }
      
      public function sendBombGameOver() : void
      {
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function sendBombGameNext() : void
      {
         var mapData:* = null;
         var i:int = 0;
         var j:int = 0;
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(6);
         pkg.writeInt(HappyLittleGameManager.instance.currentGameType);
         var temp:String = "";
         if(HappyLittleGameManager.instance.currentGameType == 1)
         {
            mapData = HappyLittleGameManager.instance.bombManager.model.BombTrain;
            for(i = 0; i < 10; )
            {
               for(j = 0; j < 10; )
               {
                  pkg.writeInt(mapData[i][j]);
                  j++;
               }
               i++;
            }
         }
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradOpenGuard(grade:int) : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(0);
         pkg.writeInt(grade);
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradLeaveScene() : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradFight(bossID:int) : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(5);
         pkg.writeInt(bossID);
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradRank() : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(16);
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradPlayerRevive(spend:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(10);
         pkg.writeBoolean(spend);
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradGameState() : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(9);
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradBuyBuff(level:int) : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(17);
         pkg.writeInt(level);
         sendPackage(pkg);
      }
      
      public function sendRewardTaskQuestOfferInfo() : void
      {
         var pkg:PackageOut = new PackageOut(629);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendRewardTaskRefreshQuest(value:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(629);
         pkg.writeByte(2);
         pkg.writeBoolean(value);
         sendPackage(pkg);
      }
      
      public function sendRewardTaskAddTimes(addTimes:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(629);
         pkg.writeByte(3);
         pkg.writeBoolean(addTimes);
         sendPackage(pkg);
      }
      
      public function sendRewardTaskRefreshReward(multiple:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(629);
         pkg.writeByte(4);
         pkg.writeBoolean(multiple);
         sendPackage(pkg);
      }
      
      public function sendRewardTaskAcceptQuest(acceptQuest:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(629);
         pkg.writeByte(5);
         pkg.writeBoolean(acceptQuest);
         sendPackage(pkg);
      }
      
      public function sendOpenAmuletBox(bagType:int, place:int, count:int = 1) : void
      {
         var pkg:PackageOut = new PackageOut(374);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendAmuletActivate(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(375);
         pkg.writeByte(1);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendAmuletSmash(list:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(375);
         pkg.writeByte(2);
         pkg.writeInt(list.length);
         for(i = 0; i < list.length; )
         {
            pkg.writeInt(list[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendAmuletMove(oldPlace:int, target:int) : void
      {
         var pkg:PackageOut = new PackageOut(375);
         pkg.writeByte(3);
         pkg.writeInt(oldPlace);
         pkg.writeInt(target);
         sendPackage(pkg);
      }
      
      public function sendAmuletLock(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(375);
         pkg.writeByte(4);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendAmuletActivateReplace(value:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(375);
         pkg.writeByte(7);
         pkg.writeBoolean(value);
         sendPackage(pkg);
      }
      
      public function sendEquipAmuletBuyNum() : void
      {
         var pkg:PackageOut = new PackageOut(386);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendEquipAmuletUpgrade(isAll:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(386);
         pkg.writeByte(2);
         pkg.writeBoolean(isAll);
         sendPackage(pkg);
      }
      
      public function sendEquipAmuletActivate(isBool:Boolean, list:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(386);
         pkg.writeByte(3);
         pkg.writeBoolean(isBool);
         pkg.writeInt(list.length);
         for(i = 0; i < list.length; )
         {
            pkg.writeInt(int(list[i]));
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendEquipAmuletBuyStive(bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(386);
         pkg.writeByte(4);
         pkg.writeBoolean(bool);
         sendPackage(pkg);
      }
      
      public function sendEquipAmuletReplace(bool:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(386);
         pkg.writeByte(6);
         pkg.writeInt(!!bool?1:0);
         sendPackage(pkg);
      }
      
      public function requestManualInitData() : void
      {
         var pkg:PackageOut = new PackageOut(377);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function requestManualPageData(chapterID:int) : void
      {
         var pkg:PackageOut = new PackageOut(377);
         pkg.writeByte(2);
         pkg.writeInt(chapterID);
         sendPackage(pkg);
      }
      
      public function sendManualPageActive(activeType:int, pageID:int, isBindMoney:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(377);
         pkg.writeByte(3);
         pkg.writeInt(activeType);
         pkg.writeInt(pageID);
         pkg.writeBoolean(isBindMoney);
         sendPackage(pkg);
      }
      
      public function sendManualUpgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(377);
         pkg.writeByte(4);
         pkg.writeBoolean(autoBuy);
         pkg.writeBoolean(bindMoney);
         pkg.writeBoolean(autoUpgrade);
         sendPackage(pkg);
      }
      
      public function sendIndiana(perId:int, count:int, isBind:Boolean = false) : void
      {
         var pkg:PackageOut = new PackageOut(385);
         pkg.writeByte(IndianaEPackageType.JOIN_HISTORY);
         pkg.writeInt(perId);
         pkg.writeInt(count);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendIndianaCode(perid:int, useid:int) : void
      {
         var pkg:PackageOut = new PackageOut(385);
         pkg.writeByte(IndianaEPackageType.CHECK_CODE);
         pkg.writeInt(perid);
         pkg.writeInt(useid);
         sendPackage(pkg);
      }
      
      public function sendIndianaEnterGame(perid:int) : void
      {
         var pkg:PackageOut = new PackageOut(385);
         pkg.writeByte(IndianaEPackageType.ENTER_GAME);
         pkg.writeInt(perid);
         sendPackage(pkg);
      }
      
      public function sendIndianaHistoryData() : void
      {
         var pkg:PackageOut = new PackageOut(385);
         pkg.writeByte(IndianaEPackageType.HISTORY_INDIANA_INFO);
         sendPackage(pkg);
      }
      
      public function sendIndianaCurrentData(perid:int) : void
      {
         var pkg:PackageOut = new PackageOut(385);
         pkg.writeByte(IndianaEPackageType.CURRENT_INDIANA_INFO);
         pkg.writeInt(perid);
         sendPackage(pkg);
      }
      
      public function sendHappyMiniGameRankDataList() : void
      {
         var pkg:PackageOut = new PackageOut(372);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function rollGameDice() : void
      {
         var pkg:PackageOut = new PackageOut(91);
         pkg.writeByte(123);
         sendPackage(pkg);
      }
      
      public function defendislandInfo(type:int) : void
      {
         var p:PackageOut = new PackageOut(84);
         p.writeInt(22);
         p.writeInt(type);
         sendPackage(p);
      }
      
      public function pvePowerBuffRefresh() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(21);
         pkg.writeInt(2);
         sendPackage(pkg);
      }
      
      public function pvePowerBuffGetBuff(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(21);
         pkg.writeInt(3);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendEquipGhost() : void
      {
         var pkg:PackageOut = new PackageOut(391);
         sendPackage(pkg);
      }
      
      public function sendBankUpdate(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(389);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendBanksaveMoney(tempId:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(389);
         pkg.writeInt(2);
         pkg.writeInt(tempId);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendBankGetMoney(bankId:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(389);
         pkg.writeInt(3);
         pkg.writeInt(bankId);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendBankGetTaskComplete() : void
      {
         var pkg:PackageOut = new PackageOut(389);
         pkg.writeInt(4);
         sendPackage(pkg);
      }
      
      public function addPlayerDressPay() : void
      {
         var pkg:PackageOut = new PackageOut(237);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function sendUpdateUserCmd(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(411);
         pkg.writeByte(2);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function sendDealStockOrFund(type:int, id:int, cnt:int, demandType:int, price:int) : void
      {
         var pkg:PackageOut = new PackageOut(411);
         pkg.writeByte(5);
         pkg.writeByte(type);
         pkg.writeInt(cnt);
         pkg.writeInt(demandType + 1);
         pkg.writeInt(id);
         pkg.writeInt(price);
         sendPackage(pkg);
      }
      
      public function sendBuyLoan(cnt:int, demandType:int) : void
      {
         var pkg:PackageOut = new PackageOut(411);
         pkg.writeByte(17);
         pkg.writeInt(cnt);
         pkg.writeInt(demandType + 1);
         sendPackage(pkg);
      }
      
      public function sendStockSpecific(id:int, type:int, lastTime:int) : void
      {
         var pkg:PackageOut = new PackageOut(411);
         pkg.writeByte(3);
         pkg.writeInt(id);
         pkg.writeByte(type);
         sendPackage(pkg);
      }
      
      public function sendUserStockAccountInfo() : void
      {
         var pkg:PackageOut = new PackageOut(411);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function sendStockNews() : void
      {
         var pkg:PackageOut = new PackageOut(411);
         pkg.writeByte(4);
         sendPackage(pkg);
      }
      
      public function sendStockAward(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(411);
         pkg.writeByte(18);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendPersonalLimitShop(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(528);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendConsortionActiveTargetSchedule() : void
      {
         var pkg:PackageOut = new PackageOut(412);
         pkg.writeByte(1);
         sendPackage(pkg);
      }
      
      public function sendConsortionActiveTagertStatus() : void
      {
         var pkg:PackageOut = new PackageOut(412);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function sendConsortionActiveTagertReward(level:int) : void
      {
         var pkg:PackageOut = new PackageOut(412);
         pkg.writeByte(3);
         pkg.writeInt(level);
         sendPackage(pkg);
      }
      
      public function sendMinesArrange() : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function sendDigHandler(floor:int) : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(1);
         pkg.writeInt(floor);
         sendPackage(pkg);
      }
      
      public function sendUpdataToolHandler(place:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(3);
         pkg.writeInt(place);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendBuyHandler(id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(4);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendExchangeHandler(id:int, num:int) : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(5);
         pkg.writeInt(id);
         pkg.writeInt(num);
         sendPackage(pkg);
      }
      
      public function sendMinesShopHandler() : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(8);
         sendPackage(pkg);
      }
      
      public function sendInitHandler() : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function sendEquipmentLevelUpHandler(type:int, place:int, count:int) : void
      {
         var pkg:PackageOut = new PackageOut(414);
         pkg.writeByte(6);
         pkg.writeInt(type);
         pkg.writeInt(place);
         pkg.writeInt(count);
         sendPackage(pkg);
      }
      
      public function sendTeamChatTalk(id:int, content:String) : void
      {
         var pkg:PackageOut = new PackageOut(160);
         pkg.writeByte(52);
         pkg.writeInt(id);
         pkg.writeUTF(content);
         sendPackage(pkg);
      }
      
      public function sendRoomBordenItemUp(place:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(23);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendUseRoomBorden(type:Boolean, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(21);
         pkg.writeBoolean(type);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendSellRoomBordan(id:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(22);
         pkg.writeInt(id);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendTeamCreate(name:String, tag:String) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(1);
         pkg.writeUTF(name);
         pkg.writeUTF(tag);
         sendPackage(pkg);
      }
      
      public function sendTeamGetInfo(teamID:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(2);
         pkg.writeInt(teamID);
         sendPackage(pkg);
      }
      
      public function sendTeamInvite(userID:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(3);
         pkg.writeInt(userID);
         sendPackage(pkg);
      }
      
      public function sendTeamInviteRepeal(userID:Number) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(4);
         pkg.writeInt(userID);
         sendPackage(pkg);
      }
      
      public function sendTeamInviteApproval(userID:Number) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(6);
         pkg.writeInt(userID);
         sendPackage(pkg);
      }
      
      public function sendTeamInviteAccept(userID:Number, teamID:Number) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(5);
         pkg.writeInt(userID);
         pkg.writeInt(teamID);
         sendPackage(pkg);
      }
      
      public function sendTeamCheckInput(isName:Boolean, value:String) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(17);
         pkg.writeBoolean(isName);
         pkg.writeUTF(value);
         sendPackage(pkg);
      }
      
      public function sendTeamGetInviteList(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(15);
         sendPackage(pkg);
      }
      
      public function sendTeamExpeleMember(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(8);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendTeamGetRecord(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(9);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendTeamGetActive(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(10);
         sendPackage(pkg);
      }
      
      public function sendTeamGetSelfActive() : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(16);
         sendPackage(pkg);
      }
      
      public function sendTeamDonate(value:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(24);
         pkg.writeInt(value);
         sendPackage(pkg);
      }
      
      public function sendTeamExit() : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(7);
         sendPackage(pkg);
      }
      
      public function sendChangeTeamName(bagType:int, place:int, name:String, tag:String) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(32);
         pkg.writeByte(bagType);
         pkg.writeInt(place);
         pkg.writeUTF(name);
         pkg.writeUTF(tag);
         sendPackage(pkg);
      }
      
      public function sendConsortiaGuradBossRank(bossByte:int) : void
      {
         var pkg:PackageOut = new PackageOut(316);
         pkg.writeByte(19);
         pkg.writeInt(bossByte);
         sendPackage(pkg);
      }
      
      public function sendTreasureRoomData() : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(23);
         sendPackage(pkg);
      }
      
      public function sendSubmitTransfer(status:int) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(8);
         pkg.writeInt(status);
         sendPackage(pkg);
      }
      
      public function sendUserAllDebris() : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(2);
         sendPackage(pkg);
      }
      
      public function sendOnOrOffChip(id:int, place:int) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(17);
         pkg.writeInt(id);
         pkg.writeInt(place);
         sendPackage(pkg);
      }
      
      public function sendSellChips(chips:Array) : void
      {
         var i:int = 0;
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(9);
         var cnt:int = chips.length;
         pkg.writeInt(cnt);
         for(i = 0; i < cnt; )
         {
            pkg.writeInt(chips[i]);
            i++;
         }
         sendPackage(pkg);
      }
      
      public function sendHammerChip(id:int, cnt:int) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(4);
         pkg.writeInt(id);
         pkg.writeInt(cnt);
         sendPackage(pkg);
      }
      
      public function sendCrystalList() : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(6);
         sendPackage(pkg);
      }
      
      public function sendTransferChip(id:int, proKey:int) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(7);
         pkg.writeInt(id);
         pkg.writeInt(proKey);
         sendPackage(pkg);
      }
      
      public function sendOperationStatus(type:int, id:int) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(24);
         pkg.writeInt(type);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendSaveEquipScheme(schemeID:int) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(30);
         pkg.writeInt(schemeID);
         sendPackage(pkg);
      }
      
      public function sendSwitchEquipScheme(schemeID:int) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(32);
         pkg.writeInt(schemeID);
         sendPackage(pkg);
      }
      
      public function sendAddEquipScheme() : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(31);
         sendPackage(pkg);
      }
      
      public function sendTreasureRoomReward(count:int, isPay:Boolean, isBind:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(529);
         pkg.writeByte(22);
         pkg.writeInt(count);
         pkg.writeBoolean(isPay);
         pkg.writeBoolean(isBind);
         sendPackage(pkg);
      }
      
      public function sendStopExpStorage(type:int) : void
      {
         var pkg:PackageOut = new PackageOut(658);
         pkg.writeInt(type);
         sendPackage(pkg);
      }
      
      public function sendGetGourdExpStorage() : void
      {
         var pkg:PackageOut = new PackageOut(393);
         sendPackage(pkg);
      }
      
      public function sendDevilGetInfo() : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(10);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnSacrifice(value:Boolean, count:int, isBand:Boolean = true) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(11);
         pkg.writeBoolean(value);
         pkg.writeByte(count);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnScoreConversion(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(18);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnBeadConversion(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(12);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnOpenBox(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(13);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnDiceStart(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(16);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnContinueDice(templateID:int, isBand:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(17);
         pkg.writeInt(templateID);
         pkg.writeBoolean(isBand);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnGetBox(templateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(19);
         pkg.writeInt(templateID);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnBoxExpire(templateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(27);
         pkg.writeInt(templateID);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnBoxAbandon(templateID:int) : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(28);
         pkg.writeInt(templateID);
         sendPackage(pkg);
      }
      
      public function sendDevilTurnUpdateJackpot() : void
      {
         var pkg:PackageOut = new PackageOut(608);
         pkg.writeByte(3);
         sendPackage(pkg);
      }
      
      public function sendTeamCaptainTransfer(id:int) : void
      {
         var pkg:PackageOut = new PackageOut(390);
         pkg.writeByte(34);
         pkg.writeInt(id);
         sendPackage(pkg);
      }
      
      public function requestDreamLandData() : void
      {
         var pkg:PackageOut = new PackageOut(610);
         pkg.writeByte(5);
         sendPackage(pkg);
      }
      
      public function sendBuyDreamLandCount(bol:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(610);
         pkg.writeByte(7);
         pkg.writeBoolean(bol);
         sendPackage(pkg);
      }
      
      public function requestDreamLandRandData(pageNum:int, type:int) : void
      {
         var pkg:PackageOut = new PackageOut(610);
         pkg.writeByte(6);
         pkg.writeByte(type);
         pkg.writeShort(pageNum);
         sendPackage(pkg);
      }
      
      public function sendPetWashBone(place:int, hpLock:Boolean, attackLock:Boolean, defenceLock:Boolean, agilityLock:Boolean, luckLock:Boolean) : void
      {
         var pkg:PackageOut = new PackageOut(68);
         pkg.writeByte(40);
         pkg.writeInt(place);
         pkg.writeBoolean(hpLock);
         pkg.writeBoolean(attackLock);
         pkg.writeBoolean(defenceLock);
         pkg.writeBoolean(agilityLock);
         pkg.writeBoolean(luckLock);
         sendPackage(pkg);
      }
      
      public function getWorldcupInfo() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(32);
         pkg.writeInt(2);
         sendPackage(pkg);
      }
      
      public function chooseWorldcupTeam(team:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(32);
         pkg.writeInt(3);
         pkg.writeInt(team);
         sendPackage(pkg);
      }
      
      public function clearWorldPrizeGuess() : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(32);
         pkg.writeInt(5);
         sendPackage(pkg);
      }
      
      public function getWorldcupPrize(index:int) : void
      {
         var pkg:PackageOut = new PackageOut(84);
         pkg.writeInt(32);
         pkg.writeInt(4);
         pkg.writeInt(index);
         sendPackage(pkg);
      }
      
      public function sendTotemUpGrade(totemPage:int) : void
      {
         var p:PackageOut = new PackageOut(616);
         p.writeInt(totemPage);
         sendPackage(p);
      }
   }
}
