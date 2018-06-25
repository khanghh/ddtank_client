package ddt.view.chat
{
   import AvatarCollection.AvatarCollectionManager;
   import DDPlay.DDPlayManaer;
   import bagAndInfo.BagAndInfoManager;
   import beadSystem.beadSystemManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.GrooveInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import ddt.bagStore.BagStore;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.data.quest.QuestItemReward;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.ChatManager;
   import ddt.manager.EffortManager;
   import ddt.manager.IMManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.CardBoxTipPanel;
   import ddt.view.tips.CardsTipPanel;
   import ddt.view.tips.EquipmentCardsTips;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   import ddtmatch.manager.DDTMatchManager;
   import farm.FarmModelController;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import growthPackage.GrowthPackageManager;
   import hall.event.NewHallEvent;
   import hall.tasktrack.HallTaskTrackManager;
   import horseRace.controller.HorseRaceManager;
   import lanternriddles.LanternRiddlesManager;
   import magicStone.MagicStoneManager;
   import quest.TaskManager;
   import quest.cmd.CmdThreeAndPowerPickUpAndEnable;
   import redEnvelope.RedEnvelopeManager;
   import redPackage.RedPackageManager;
   import room.RoomManager;
   import tryonSystem.TryonSystemController;
   import witchBlessing.WitchBlessingManager;
   import wonderfulActivity.WonderfulActivityManager;
   import worldBossHelper.WorldBossHelperManager;
   
   use namespace chat_system;
   
   public class ChatOutputField extends Sprite
   {
      
      public static const GAME_STYLE:String = "GAME_STYLE";
      
      public static const GAME_WIDTH:int = 288;
      
      public static const GAME_HEIGHT:int = 106;
      
      public static const NORMAL_WIDTH:int = 440;
      
      public static const NORMAL_HEIGHT:int = 118;
      
      public static const NORMAL_STYLE:String = "NORMAL_STYLE";
      
      private static var _style:String = "";
       
      
      private var _contentField:TextField;
      
      private var _nameTip:ChatNamePanel;
      
      private var _transregionalNameTip:ChatTransregionalNamePanel;
      
      private var _goodTip:GoodTip;
      
      private var _cardboxTip:CardBoxTipPanel;
      
      private var _cardTip:EquipmentCardsTips;
      
      private var _grooveTip:CardsTipPanel;
      
      private var _cardInfotTips:EquipmentCardsTips;
      
      private var _goodTipPos:Sprite;
      
      private var _srcollRect:Rectangle;
      
      private var _tipStageClickCount:int = 0;
      
      private var isStyleChange:Boolean = false;
      
      private var t_text:String;
      
      private var _functionEnabled:Boolean;
      
      private var _clickNum:Number = 0;
      
      private var curQuestId:int = 0;
      
      private var _lastClickTime:Number;
      
      private var _data:Object;
      
      public function ChatOutputField()
      {
         _goodTipPos = new Sprite();
         super();
         style = "NORMAL_STYLE";
      }
      
      public function set functionEnabled(value:Boolean) : void
      {
         _functionEnabled = value;
      }
      
      public function set contentWidth(value:Number) : void
      {
         _contentField.width = value;
         updateScrollRect(value,118);
      }
      
      public function set contentHeight(value:Number) : void
      {
         _contentField.height = value;
         updateScrollRect(440,value);
      }
      
      public function isBottom() : Boolean
      {
         return _contentField.scrollV == _contentField.maxScrollV;
      }
      
      public function get scrollOffset() : int
      {
         return _contentField.maxScrollV - _contentField.scrollV;
      }
      
      public function set scrollOffset(offset:int) : void
      {
         _contentField.scrollV = _contentField.maxScrollV - offset;
         onScrollChanged();
      }
      
      public function setChats(chatData:Array) : void
      {
         var i:int = 0;
         var resultHtmlText:String = "";
         for(i = 0; i < chatData.length; )
         {
            resultHtmlText = resultHtmlText + chatData[i].htmlMessage;
            i++;
         }
         _contentField.htmlText = resultHtmlText;
      }
      
      public function toBottom() : void
      {
         Helpers.delayCall(__delayCall);
         _contentField.scrollV = 2147483647;
         onScrollChanged();
      }
      
      chat_system function get goodTipPos() : Point
      {
         return new Point(_goodTipPos.x,_goodTipPos.y);
      }
      
      chat_system function showLinkGoodsInfo(item:ItemTemplateInfo, tipStageClickCount:uint = 0) : void
      {
         var tipData:* = null;
         var vItemInfo:* = null;
         if(item.CategoryID == 18)
         {
            if(_cardboxTip == null)
            {
               _cardboxTip = new CardBoxTipPanel();
            }
            _cardboxTip.tipData = item;
            setTipPos(_cardboxTip);
            StageReferance.stage.addChild(_cardboxTip);
         }
         else
         {
            if(_goodTip == null)
            {
               _goodTip = new GoodTip();
            }
            tipData = new GoodTipInfo();
            vItemInfo = item as InventoryItemInfo;
            if(item.Property1 == "31")
            {
               if(vItemInfo && vItemInfo.Hole2 > 0)
               {
                  tipData.exp = vItemInfo.Hole2;
                  tipData.upExp = ServerConfigManager.instance.getBeadUpgradeExp()[vItemInfo.Hole1 + 1];
                  tipData.beadName = vItemInfo.Name + "-" + beadSystemManager.Instance.getBeadName(vItemInfo);
               }
               else
               {
                  tipData.beadName = item.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(item.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(item.TemplateID).BaseLevel;
                  tipData.exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(item.TemplateID).BaseLevel];
                  tipData.upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(item.TemplateID).BaseLevel + 1];
               }
            }
            else if(item.Property1 == "81")
            {
               if(vItemInfo && vItemInfo.StrengthenExp > 0)
               {
                  tipData.exp = vItemInfo.StrengthenExp - MagicStoneManager.instance.getNeedExp(item.TemplateID,vItemInfo.StrengthenLevel);
               }
               else
               {
                  tipData.exp = 0;
               }
               tipData.upExp = MagicStoneManager.instance.getNeedExpPerLevel(item.TemplateID,item.Level + 1);
               tipData.beadName = item.Name + "Lv" + item.Level;
            }
            tipData.itemInfo = item;
            _goodTip.tipData = tipData;
            _goodTip.showTip(item);
            setTipPos(_goodTip);
            StageReferance.stage.addChild(_goodTip);
         }
         if(_nameTip && _nameTip.parent)
         {
            _nameTip.parent.removeChild(_nameTip);
         }
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         _tipStageClickCount = tipStageClickCount;
      }
      
      chat_system function showBeadTip(pItem:ItemTemplateInfo, pBeadLv:int, pBeadExp:int) : void
      {
         if(_goodTip == null)
         {
            _goodTip = new GoodTip();
         }
         var vGoodTipData:GoodTipInfo = new GoodTipInfo();
         vGoodTipData.beadName = pItem.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(pItem.TemplateID).Name + "Lv" + pBeadLv;
         vGoodTipData.upExp = ServerConfigManager.instance.getBeadUpgradeExp()[pBeadLv + 1];
         vGoodTipData.exp = pBeadExp;
         vGoodTipData.itemInfo = pItem;
         _goodTip.tipData = vGoodTipData;
         _goodTip.showTip(pItem);
         setTipPos(_goodTip);
         StageReferance.stage.addChild(_goodTip);
      }
      
      chat_system function showCardGrooveLinkGoodsInfo(item:GrooveInfo, tipStageClickCount:uint = 0) : void
      {
         _grooveTip = new CardsTipPanel();
         _grooveTip.tipData = item.Place;
         _grooveTip.tipDirctions = "7,0";
         setTipPos2(_grooveTip);
         StageReferance.stage.addChild(_grooveTip);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         _tipStageClickCount = tipStageClickCount;
      }
      
      chat_system function showCardInfoLinkGoodsInfo(item:CardInfo, tipStageClickCount:uint = 0) : void
      {
         _cardInfotTips = new EquipmentCardsTips();
         _cardInfotTips.tipData = item;
         _cardInfotTips.tipDirctions = "7,0";
         setTipPos2(_cardInfotTips);
         StageReferance.stage.addChild(_cardInfotTips);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         _tipStageClickCount = tipStageClickCount;
      }
      
      private function setTipPos(tip:Object) : void
      {
         tip.x = _goodTipPos.x;
         tip.y = _goodTipPos.y - tip.height - 10;
         if(tip.y < 0)
         {
            tip.y = 10;
         }
      }
      
      private function setTipPos2(tip:Object) : void
      {
         tip.tipGapH = 218;
         tip.tipGapV = 245;
         tip.x = 218;
         tip.y = 245;
      }
      
      chat_system function set style(value:String) : void
      {
         if(_style != value)
         {
            _style = value;
            disposeView();
            initView();
            initEvent();
            var _loc2_:* = value;
            if("NORMAL_STYLE" !== _loc2_)
            {
               if("GAME_STYLE" === _loc2_)
               {
                  _contentField.styleSheet = ChatFormats.gameStyleSheet;
                  _contentField.width = 288;
                  _contentField.height = 106;
               }
            }
            else
            {
               _contentField.styleSheet = ChatFormats.styleSheet;
               _contentField.width = 440;
               _contentField.height = 118;
            }
            _contentField.htmlText = t_text || "";
         }
      }
      
      private function __delayCall() : void
      {
         _contentField.scrollV = _contentField.maxScrollV;
         onScrollChanged();
         removeEventListener("enterFrame",__delayCall);
      }
      
      private function __onScrollChanged(event:Event) : void
      {
         onScrollChanged();
      }
      
      private function __onTextClicked(event:TextEvent) : void
      {
         var tipPos:* = null;
         var i:int = 0;
         var props:* = null;
         var selfZone:int = 0;
         var other:int = 0;
         var input:* = null;
         var specialIdx:int = 0;
         var pattern:* = null;
         var str:* = null;
         var result:* = null;
         var rect:* = null;
         var startIdx:int = 0;
         var endIdx:int = 0;
         var pos:* = null;
         var legalIdx:int = 0;
         var nameTipPos:* = null;
         var itemInfo:* = null;
         var info:* = null;
         var self:* = null;
         var chatArr:* = null;
         var msg:* = null;
         SoundManager.instance.play("008");
         __stageClickHandler();
         var nowTime:Number = new Date().time;
         if(nowTime - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickNum = nowTime;
         var data:Object = {};
         var allProperties:Array = event.text.split("|");
         for(i = 0; i < allProperties.length; )
         {
            if(allProperties[i].indexOf(":"))
            {
               props = allProperties[i].split(":");
               data[props[0]] = props[1];
            }
            i++;
         }
         if(data.jumptype)
         {
            switch(int(int(data.jumptype)) - 1)
            {
               case 0:
                  if(StateManager.currentStateType != "main")
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.getRewardTip"));
                     return;
                  }
                  GrowthPackageManager.instance.loadUIModule(GrowthPackageManager.instance.showFrame);
                  break;
               case 1:
                  if(DDPlayManaer.Instance.isOpen)
                  {
                     DDPlayManaer.Instance.show();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.ddPlay.end"));
                  }
                  break;
               case 2:
                  if(WitchBlessingManager.Instance.isOpen())
                  {
                     WitchBlessingManager.Instance.onClickIcon();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.ActiveState.StartNot"));
                  }
                  break;
               default:
                  if(WitchBlessingManager.Instance.isOpen())
                  {
                     WitchBlessingManager.Instance.onClickIcon();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.ActiveState.StartNot"));
                  }
                  break;
               default:
                  if(WitchBlessingManager.Instance.isOpen())
                  {
                     WitchBlessingManager.Instance.onClickIcon();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.ActiveState.StartNot"));
                  }
                  break;
               default:
                  if(WitchBlessingManager.Instance.isOpen())
                  {
                     WitchBlessingManager.Instance.onClickIcon();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.ActiveState.StartNot"));
                  }
                  break;
               default:
                  if(WitchBlessingManager.Instance.isOpen())
                  {
                     WitchBlessingManager.Instance.onClickIcon();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.ActiveState.StartNot"));
                  }
                  break;
               default:
                  if(WitchBlessingManager.Instance.isOpen())
                  {
                     WitchBlessingManager.Instance.onClickIcon();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.ActiveState.StartNot"));
                  }
                  break;
               default:
                  if(WitchBlessingManager.Instance.isOpen())
                  {
                     WitchBlessingManager.Instance.onClickIcon();
                  }
                  else
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.ActiveState.StartNot"));
                  }
                  break;
               case 9:
                  if(StateManager.currentStateType == "main" && DDTMatchManager.instance.redPacketIsBegin)
                  {
                     DDTMatchManager.outsideRedPacket = true;
                     DDTMatchManager.instance.show();
                  }
                  else if(!DDTMatchManager.instance.redPacketIsBegin)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.over"));
                  }
            }
         }
         else if(int(data.clicktype) == 0)
         {
            ChatManager.Instance.inputChannel = int(data.channel);
            ChatManager.Instance.output.functionEnabled = true;
         }
         else if(int(data.clicktype) == 1)
         {
            selfZone = PlayerManager.Instance.Self.ZoneID;
            other = data.zoneID;
            if(other > 0 && other != selfZone)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("core.crossZone.PrivateChatToUnable"));
               return;
            }
            if(IMManager.IS_SHOW_SUB)
            {
               dispatchEvent(new ChatEvent("nicknameClickToOutside",data.tagname));
            }
            if(_nameTip == null)
            {
               _nameTip = ComponentFactory.Instance.creatCustomObject("chat.NamePanel");
            }
            input = String(data.tagname);
            specialIdx = input.indexOf("$");
            if(specialIdx > -1)
            {
               input = input.substr(0,specialIdx);
            }
            pattern = new RegExp(input,"g");
            str = _contentField.text;
            result = pattern.exec(str);
            while(result != null)
            {
               startIdx = result.index;
               endIdx = startIdx + String(data.tagname).length;
               pos = _contentField.globalToLocal(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
               legalIdx = _contentField.getCharIndexAtPoint(pos.x,pos.y);
               if(legalIdx >= startIdx && legalIdx <= endIdx)
               {
                  _contentField.setSelection(startIdx,endIdx);
                  rect = _contentField.getCharBoundaries(endIdx);
                  nameTipPos = _contentField.localToGlobal(new Point(rect.x,rect.y));
                  _nameTip.x = nameTipPos.x + rect.width;
                  _nameTip.y = nameTipPos.y - _nameTip.getHeight - (_contentField.scrollV - 1) * 18;
                  break;
               }
               result = pattern.exec(str);
            }
            _nameTip.playerName = String(data.tagname);
            if(data.channel)
            {
               _nameTip.channel = ChatFormats.Channel_Set[int(data.channel)];
            }
            else
            {
               _nameTip.channel = null;
            }
            _nameTip.message = String(data.message);
            if(_goodTip && _goodTip.parent)
            {
               _goodTip.parent.removeChild(_goodTip);
            }
            if(data.senderID == -1)
            {
               _nameTip.setVisible = false;
            }
            else
            {
               _nameTip.setVisible = true;
               ChatManager.Instance.privateChatTo(data.tagname);
            }
         }
         else if(int(data.clicktype) == 2)
         {
            tipPos = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
            _goodTipPos.x = tipPos.x;
            _goodTipPos.y = tipPos.y;
            itemInfo = ItemManager.Instance.getTemplateById(data.templeteIDorItemID);
            itemInfo.BindType = data.isBind == "true"?0:1;
            0;
            showLinkGoodsInfo(itemInfo);
         }
         else if(int(data.clicktype) == 3)
         {
            selfZone = PlayerManager.Instance.Self.ZoneID;
            other = data.zoneID;
            if(other > 0 && other != selfZone)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.ViewGoodInfoUnable"));
               return;
            }
            tipPos = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
            _goodTipPos.x = tipPos.x;
            _goodTipPos.y = tipPos.y;
            if(data.key != "null")
            {
               info = ChatManager.Instance.model.getLink(data.key);
            }
            else
            {
               info = ChatManager.Instance.model.getLink(data.templeteIDorItemID);
            }
            if(info)
            {
               showLinkGoodsInfo(info);
            }
            else if(data.key != "null")
            {
               SocketManager.Instance.out.sendGetLinkGoodsInfo(3,String(data.key),String(data.templeteIDorItemID));
            }
            else
            {
               SocketManager.Instance.out.sendGetLinkGoodsInfo(2,String(data.templeteIDorItemID));
            }
         }
         else if(int(data.clicktype) == 888)
         {
            if(StateManager.currentStateType == "main")
            {
               SocketManager.Instance.out.sendInviteYearFoodRoom(true,int(data.senderId));
            }
         }
         else if(int(data.clicktype) == 111)
         {
            RedPackageManager.getInstance().showView("red_pkg_consortia_gain");
         }
         else if(int(data.clicktype) == 999)
         {
            if(StateManager.currentStateType != "fighting")
            {
               if(RedEnvelopeManager.instance.model.isOpen && RedEnvelopeManager.instance.openFlag)
               {
                  RedEnvelopeManager.instance.openFlag = false;
                  SocketManager.Instance.out.redEnvelopeListInfo();
               }
            }
         }
         else if(int(data.clicktype) == 890)
         {
            navigateToURL(new URLRequest(data.source),"_blank");
         }
         else if(int(data.clicktype) == 889)
         {
            if(StateManager.currentStateType == "main")
            {
               SoundManager.instance.play("008");
               self = PlayerManager.Instance.Self;
               if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
                  return;
               }
               if(self.IsMounts)
               {
                  HorseRaceManager.Instance.enterView();
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horseRace.noMount"));
               }
            }
         }
         else if(int(data.clicktype) == 4)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("chat.differZone.cannotChat"));
         }
         else if(int(data.clicktype) == 100)
         {
            if(!EffortManager.Instance.getMainFrameVisible())
            {
               EffortManager.Instance.isSelf = true;
               EffortManager.Instance.switchVisible();
            }
         }
         else if(int(data.clicktype) == 5)
         {
            selfZone = PlayerManager.Instance.Self.ZoneID;
            other = data.zoneID;
            if(other > 0 && other != selfZone)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.ViewGoodInfoUnable"));
               return;
            }
            SocketManager.Instance.out.sendGetLinkGoodsInfo(4,String(data.key));
         }
         else if(int(data.clicktype) == 6)
         {
            selfZone = PlayerManager.Instance.Self.ZoneID;
            other = data.zoneID;
            if(other > 0 && other != selfZone)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.ViewGoodInfoUnable"));
               return;
            }
            SocketManager.Instance.out.sendGetLinkGoodsInfo(5,String(data.key));
         }
         else if(int(data.clicktype) == 101)
         {
            if(StateManager.currentStateType == "fighting" || WorldBossHelperManager.Instance.isInWorldBossHelperFrame)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.FastInvite.cannotInvite"));
               return;
            }
            if(StateManager.currentStateType != "roomlist" && StateManager.currentStateType != "dungeon" && StateManager.currentStateType != "main")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.FastInvite.cannotInvite2"));
               return;
            }
            _data = data;
            AssetModuleLoader.startCodeLoader(__joinRoom);
         }
         else if(int(data.clicktype) > ChatFormats.CLICK_ACT_TIP)
         {
            if(getTimer() - _lastClickTime < 2000)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.npc.clickTip"));
               return;
            }
            _lastClickTime = getTimer();
            if(StateManager.currentStateType != "main")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.getRewardTip"));
               return;
            }
            WonderfulActivityManager.Instance.clickWonderfulActView = true;
            WonderfulActivityManager.Instance.isSkipFromHall = true;
            WonderfulActivityManager.Instance.skipType = data.rewardType;
            SocketManager.Instance.out.requestRookieRankInfo();
            SocketManager.Instance.out.requestWonderfulActInit(1);
         }
         else if(int(data.clicktype) == 103)
         {
            SocketManager.Instance.out.sendConsortiaInvate(data.tagname);
         }
         else if(int(data.clicktype) == 104)
         {
            if(StateManager.currentStateType == "main")
            {
               LanternRiddlesManager.instance.show();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("lanternRiddles.view.openTips"));
            }
         }
         else if(int(data.clicktype) == 105)
         {
            if(StateManager.currentStateType == "main" || StateManager.currentStateType == "roomlist")
            {
               BagAndInfoManager.Instance.showBagAndInfo();
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("wonderfulActivity.getRewardTip"));
            }
         }
         else if(int(data.clicktype) == 106)
         {
            chatArr = ChatManager.Instance.model.currentChats;
            var _loc28_:int = 0;
            var _loc27_:* = chatArr;
            for each(var chat in chatArr)
            {
               if(chat.type == 106)
               {
                  ChatManager.Instance.notAgainData.add(chat.msg,true);
                  chat.htmlMessage = chat.htmlMessage.replace("<FONT  COLOR=\'#8dff1e\'>" + LanguageMgr.GetTranslation("notAlertAgain") + "</FONT>","<FONT  COLOR=\'#989898\'>" + LanguageMgr.GetTranslation("notAlertAgain") + "</FONT>");
               }
            }
            ChatManager.Instance.view.output.updateCurrnetChannel();
         }
         else if(int(data.clicktype) == 108)
         {
            if(StateManager.currentStateType != "main")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.pay.tipTxt"));
               return;
            }
            AvatarCollectionManager.instance.isSkipFromHall = true;
            BagAndInfoManager.Instance.showBagAndInfo(7);
         }
         else if(int(data.clicktype) == 32)
         {
            if(dailyRecordGoTurnCheck())
            {
               BagStore.instance.openStore("forge_store",1);
            }
         }
         else if(int(data.clicktype) == 33)
         {
            if(dailyRecordGoTurnCheck())
            {
               BagStore.instance.openStore("forge_store",0);
            }
         }
         else if(int(data.clicktype) == 112)
         {
            ConsortionModelManager.Instance.enterConsortiaState();
         }
         else if(int(data.clicktype) == 109)
         {
            if(StateManager.currentStateType == "main" || StateManager.currentStateType == "tofflist" || StateManager.currentStateType == "consortia" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "farm")
            {
               if(RoomManager.Instance.isPrepare)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.poultry.isPrepareTxt"));
               }
               else if(RoomManager.Instance.isMatch)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.poultry.isMatchTxt"));
               }
               else
               {
                  FarmModelController.instance.startTimer();
                  FarmModelController.instance.goFarm(PlayerManager.Instance.Self.SpouseID,PlayerManager.Instance.Self.SpouseName);
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.pay.tipTxt"));
            }
         }
         else if(int(data.clicktype) == 110)
         {
            if(StateManager.currentStateType == "main" || StateManager.currentStateType == "tofflist" || StateManager.currentStateType == "consortia" || StateManager.currentStateType == "dungeonRoom" || StateManager.currentStateType == "matchRoom" || StateManager.currentStateType == "farm")
            {
               if(RoomManager.Instance.isPrepare)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.poultry.isPrepareTxt"));
               }
               else if(RoomManager.Instance.isMatch)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.poultry.isMatchTxt"));
               }
               else
               {
                  FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.pay.tipTxt"));
            }
         }
         else if(int(data.clicktype) == 113)
         {
            if(ConsortiaDomainManager.instance.activeState == 1 && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "consortia_domain")
            {
               ConsortiaDomainManager.instance.enterScene(true);
            }
         }
         else if(int(data.clicktype) == 114)
         {
            if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d")
            {
               msg = LanguageMgr.GetTranslation("chat.task.NotBattle");
               MessageTipManager.getInstance().show(msg,0,true,1);
               return;
            }
            if(StateManager.currentStateType == "consortia_domain")
            {
               msg = LanguageMgr.GetTranslation("chat.task.Notconsortia");
               MessageTipManager.getInstance().show(msg,0,true,1);
               return;
            }
            if(TaskManager.instance.getQuestByID(data.questId) && (TaskManager.instance.getQuestByID(data.questId).isCompleted && !TaskManager.instance.getQuestByID(data.questId).isAchieved))
            {
               finishQuest(int(data.questId));
            }
            else
            {
               msg = LanguageMgr.GetTranslation("ringStation.view.getReward.failed");
               MessageTipManager.getInstance().show(msg,0,true,1);
            }
         }
      }
      
      private function dailyRecordGoTurnCheck() : Boolean
      {
         if(StateManager.currentStateType != "main" && (RoomManager.Instance.isPrepare || RoomManager.Instance.isMatch || StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.dailyRecord.goTurnFailMsg"));
            return false;
         }
         return true;
      }
      
      private function finishQuest(questId:int) : void
      {
         var info:* = null;
         curQuestId = questId;
         var _questInfo:QuestInfo = TaskManager.instance.getQuestByID(questId);
         var items:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _questInfo.itemRewards;
         for each(var temp in _questInfo.itemRewards)
         {
            info = new InventoryItemInfo();
            info.TemplateID = temp.itemID;
            ItemManager.fill(info);
            info.ValidDate = temp.ValidateTime;
            info.TemplateID = temp.itemID;
            info.IsJudge = true;
            info.IsBinds = temp.isBind;
            info.AttackCompose = temp.AttackCompose;
            info.DefendCompose = temp.DefendCompose;
            info.AgilityCompose = temp.AgilityCompose;
            info.LuckCompose = temp.LuckCompose;
            info.StrengthenLevel = temp.StrengthenLevel;
            info.Count = temp.count[_questInfo.QuestLevel - 1];
            if(!(0 != info.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != info.NeedSex))
            {
               if(temp.isOptional == 1)
               {
                  items.push(info);
               }
            }
         }
         if(items.length > 0)
         {
            HallTaskTrackManager.instance.moduleLoad(showSelectedAwardFrame,[items]);
         }
         else
         {
            TaskManager.instance.sendQuestFinish(_questInfo.QuestID);
            if(TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(318)) && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(319)))
            {
               SocketManager.Instance.out.syncWeakStep(49);
            }
            new CmdThreeAndPowerPickUpAndEnable().excute(questId);
         }
      }
      
      private function getSexByInt(Sex:Boolean) : int
      {
         if(Sex)
         {
            return 1;
         }
         return 2;
      }
      
      private function showSelectedAwardFrame(items:Array) : void
      {
         TryonSystemController.Instance.show(items,chooseReward,null);
      }
      
      private function chooseReward(item:ItemTemplateInfo) : void
      {
         new CmdThreeAndPowerPickUpAndEnable().excute(curQuestId);
         SocketManager.Instance.out.sendQuestFinish(curQuestId,item.TemplateID);
      }
      
      private function getPos(data:Object, namePanel:ChatTransregionalNamePanel) : Point
      {
         var rect:* = null;
         var startIdx:int = 0;
         var endIdx:int = 0;
         var pos:* = null;
         var legalIdx:int = 0;
         var nameTipPos:* = null;
         var point:* = null;
         var input:String = String(data.tagname);
         var specialIdx:int = input.indexOf("$");
         if(specialIdx > -1)
         {
            input = input.substr(0,specialIdx);
         }
         var pattern:RegExp = new RegExp(input,"g");
         var str:String = _contentField.text;
         var result:Object = pattern.exec(str);
         while(result != null)
         {
            startIdx = result.index;
            endIdx = startIdx + String(data.tagname).length;
            pos = _contentField.globalToLocal(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
            legalIdx = _contentField.getCharIndexAtPoint(pos.x,pos.y);
            if(legalIdx >= startIdx && legalIdx <= endIdx)
            {
               _contentField.setSelection(startIdx,endIdx);
               rect = _contentField.getCharBoundaries(endIdx);
               nameTipPos = _contentField.localToGlobal(new Point(rect.x,rect.y));
               point = new Point();
               point.x = nameTipPos.x + rect.width;
               point.y = nameTipPos.y - namePanel.getHight() - (_contentField.scrollV - 1) * 18;
               break;
            }
            result = pattern.exec(str);
         }
         return point;
      }
      
      private function __stageClickHandler(event:MouseEvent = null) : void
      {
         if(event)
         {
            event.stopImmediatePropagation();
            event.stopPropagation();
         }
         if(_tipStageClickCount > 0)
         {
            if(_goodTip && _goodTip.parent)
            {
               _goodTip.parent.removeChild(_goodTip);
            }
            if(_cardboxTip && _cardboxTip.parent)
            {
               _cardboxTip.parent.removeChild(_cardboxTip);
            }
            if(_cardTip && _cardTip.parent)
            {
               _cardTip.parent.removeChild(_cardTip);
            }
            if(_grooveTip && _grooveTip.parent)
            {
               _grooveTip.parent.removeChild(_grooveTip);
            }
            if(_cardInfotTips && _cardInfotTips.parent)
            {
               _cardInfotTips.parent.removeChild(_cardInfotTips);
            }
            if(StageReferance.stage)
            {
               StageReferance.stage.removeEventListener("click",__stageClickHandler);
            }
         }
         else
         {
            _tipStageClickCount = Number(_tipStageClickCount) + 1;
         }
      }
      
      private function disposeView() : void
      {
         removeEventListener("click",__onMouseClick);
         if(_contentField)
         {
            t_text = _contentField.htmlText;
            removeChild(_contentField);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__onMouseClick);
         _contentField.addEventListener("scroll",__onScrollChanged);
         _contentField.addEventListener("link",__onTextClicked);
         _contentField.addEventListener("mouseOver",__onFieldOver);
         _contentField.addEventListener("mouseOut",__onFieldOut);
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("setselfplayerpos",[event]));
      }
      
      protected function __onFieldOut(event:MouseEvent) : void
      {
         Mouse.cursor = "auto";
      }
      
      protected function __onFieldOver(event:MouseEvent) : void
      {
         Mouse.cursor = "arrow";
      }
      
      private function initView() : void
      {
         _contentField = new TextField();
         PositionUtils.setPos(_contentField,"chat.outputfieldPos");
         _contentField.multiline = true;
         _contentField.wordWrap = true;
         _contentField.filters = [new GlowFilter(0,1,4,4,8)];
         _contentField.mouseWheelEnabled = false;
         Helpers.setTextfieldFormat(_contentField,{"size":12});
         updateScrollRect(440,118);
         addChild(_contentField);
      }
      
      private function onScrollChanged() : void
      {
         dispatchEvent(new ChatEvent("scrollChanged"));
      }
      
      private function updateScrollRect($width:Number, $height:Number) : void
      {
         _srcollRect = new Rectangle(0,0,$width,$height);
         _contentField.scrollRect = _srcollRect;
      }
      
      private function __joinRoom() : void
      {
         if(StateManager.currentStateType == "roomlist")
         {
            SocketManager.Instance.out.sendGameLogin(1,-1,_data.roomId,_data.password,true);
         }
         else if(StateManager.currentStateType == "dungeon")
         {
            SocketManager.Instance.out.sendGameLogin(2,-1,_data.roomId,_data.password,true);
         }
         else
         {
            SocketManager.Instance.out.sendGameLogin(4,-1,_data.roomId,_data.password,true);
         }
      }
   }
}
