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
      
      public function ChatOutputField()
      {
         _goodTipPos = new Sprite();
         super();
         style = "NORMAL_STYLE";
      }
      
      public function set functionEnabled(param1:Boolean) : void
      {
         _functionEnabled = param1;
      }
      
      public function set contentWidth(param1:Number) : void
      {
         _contentField.width = param1;
         updateScrollRect(param1,118);
      }
      
      public function set contentHeight(param1:Number) : void
      {
         _contentField.height = param1;
         updateScrollRect(440,param1);
      }
      
      public function isBottom() : Boolean
      {
         return _contentField.scrollV == _contentField.maxScrollV;
      }
      
      public function get scrollOffset() : int
      {
         return _contentField.maxScrollV - _contentField.scrollV;
      }
      
      public function set scrollOffset(param1:int) : void
      {
         _contentField.scrollV = _contentField.maxScrollV - param1;
         onScrollChanged();
      }
      
      public function setChats(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + param1[_loc3_].htmlMessage;
            _loc3_++;
         }
         _contentField.htmlText = _loc2_;
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
      
      chat_system function showLinkGoodsInfo(param1:ItemTemplateInfo, param2:uint = 0) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1.CategoryID == 18)
         {
            if(_cardboxTip == null)
            {
               _cardboxTip = new CardBoxTipPanel();
            }
            _cardboxTip.tipData = param1;
            setTipPos(_cardboxTip);
            StageReferance.stage.addChild(_cardboxTip);
         }
         else
         {
            if(_goodTip == null)
            {
               _goodTip = new GoodTip();
            }
            _loc4_ = new GoodTipInfo();
            _loc3_ = param1 as InventoryItemInfo;
            if(param1.Property1 == "31")
            {
               if(_loc3_ && _loc3_.Hole2 > 0)
               {
                  _loc4_.exp = _loc3_.Hole2;
                  _loc4_.upExp = ServerConfigManager.instance.getBeadUpgradeExp()[_loc3_.Hole1 + 1];
                  _loc4_.beadName = _loc3_.Name + "-" + beadSystemManager.Instance.getBeadName(_loc3_);
               }
               else
               {
                  _loc4_.beadName = param1.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).BaseLevel;
                  _loc4_.exp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).BaseLevel];
                  _loc4_.upExp = ServerConfigManager.instance.getBeadUpgradeExp()[BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).BaseLevel + 1];
               }
            }
            else if(param1.Property1 == "81")
            {
               if(_loc3_ && _loc3_.StrengthenExp > 0)
               {
                  _loc4_.exp = _loc3_.StrengthenExp - MagicStoneManager.instance.getNeedExp(param1.TemplateID,_loc3_.StrengthenLevel);
               }
               else
               {
                  _loc4_.exp = 0;
               }
               _loc4_.upExp = MagicStoneManager.instance.getNeedExpPerLevel(param1.TemplateID,param1.Level + 1);
               _loc4_.beadName = param1.Name + "Lv" + param1.Level;
            }
            _loc4_.itemInfo = param1;
            _goodTip.tipData = _loc4_;
            _goodTip.showTip(param1);
            setTipPos(_goodTip);
            StageReferance.stage.addChild(_goodTip);
         }
         if(_nameTip && _nameTip.parent)
         {
            _nameTip.parent.removeChild(_nameTip);
         }
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         _tipStageClickCount = param2;
      }
      
      chat_system function showBeadTip(param1:ItemTemplateInfo, param2:int, param3:int) : void
      {
         if(_goodTip == null)
         {
            _goodTip = new GoodTip();
         }
         var _loc4_:GoodTipInfo = new GoodTipInfo();
         _loc4_.beadName = param1.Name + "-" + BeadTemplateManager.Instance.GetBeadInfobyID(param1.TemplateID).Name + "Lv" + param2;
         _loc4_.upExp = ServerConfigManager.instance.getBeadUpgradeExp()[param2 + 1];
         _loc4_.exp = param3;
         _loc4_.itemInfo = param1;
         _goodTip.tipData = _loc4_;
         _goodTip.showTip(param1);
         setTipPos(_goodTip);
         StageReferance.stage.addChild(_goodTip);
      }
      
      chat_system function showCardGrooveLinkGoodsInfo(param1:GrooveInfo, param2:uint = 0) : void
      {
         _grooveTip = new CardsTipPanel();
         _grooveTip.tipData = param1.Place;
         _grooveTip.tipDirctions = "7,0";
         setTipPos2(_grooveTip);
         StageReferance.stage.addChild(_grooveTip);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         _tipStageClickCount = param2;
      }
      
      chat_system function showCardInfoLinkGoodsInfo(param1:CardInfo, param2:uint = 0) : void
      {
         _cardInfotTips = new EquipmentCardsTips();
         _cardInfotTips.tipData = param1;
         _cardInfotTips.tipDirctions = "7,0";
         setTipPos2(_cardInfotTips);
         StageReferance.stage.addChild(_cardInfotTips);
         StageReferance.stage.addEventListener("click",__stageClickHandler);
         _tipStageClickCount = param2;
      }
      
      private function setTipPos(param1:Object) : void
      {
         param1.x = _goodTipPos.x;
         param1.y = _goodTipPos.y - param1.height - 10;
         if(param1.y < 0)
         {
            param1.y = 10;
         }
      }
      
      private function setTipPos2(param1:Object) : void
      {
         param1.tipGapH = 218;
         param1.tipGapV = 245;
         param1.x = 218;
         param1.y = 245;
      }
      
      chat_system function set style(param1:String) : void
      {
         if(_style != param1)
         {
            _style = param1;
            disposeView();
            initView();
            initEvent();
            var _loc2_:* = param1;
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
      
      private function __onScrollChanged(param1:Event) : void
      {
         onScrollChanged();
      }
      
      private function __onTextClicked(param1:TextEvent) : void
      {
         var _loc26_:* = null;
         var _loc19_:int = 0;
         var _loc25_:* = null;
         var _loc13_:int = 0;
         var _loc4_:int = 0;
         var _loc21_:* = null;
         var _loc14_:int = 0;
         var _loc23_:* = null;
         var _loc22_:* = null;
         var _loc2_:* = null;
         var _loc15_:* = null;
         var _loc9_:int = 0;
         var _loc20_:int = 0;
         var _loc10_:* = null;
         var _loc18_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc24_:* = null;
         var _loc16_:* = null;
         SoundManager.instance.play("008");
         __stageClickHandler();
         var _loc17_:Number = new Date().time;
         if(_loc17_ - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickNum = _loc17_;
         var _loc5_:Object = {};
         var _loc12_:Array = param1.text.split("|");
         _loc19_ = 0;
         while(_loc19_ < _loc12_.length)
         {
            if(_loc12_[_loc19_].indexOf(":"))
            {
               _loc25_ = _loc12_[_loc19_].split(":");
               _loc5_[_loc25_[0]] = _loc25_[1];
            }
            _loc19_++;
         }
         if(_loc5_.jumptype)
         {
            switch(int(_loc5_.jumptype) - 1)
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
                     break;
                  }
                  if(!DDTMatchManager.instance.redPacketIsBegin)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.over"));
                     break;
                  }
                  break;
            }
         }
         else if(int(_loc5_.clicktype) == 0)
         {
            ChatManager.Instance.inputChannel = int(_loc5_.channel);
            ChatManager.Instance.output.functionEnabled = true;
         }
         else if(int(_loc5_.clicktype) == 1)
         {
            _loc13_ = PlayerManager.Instance.Self.ZoneID;
            _loc4_ = _loc5_.zoneID;
            if(_loc4_ > 0 && _loc4_ != _loc13_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("core.crossZone.PrivateChatToUnable"));
               return;
            }
            if(IMManager.IS_SHOW_SUB)
            {
               dispatchEvent(new ChatEvent("nicknameClickToOutside",_loc5_.tagname));
            }
            if(_nameTip == null)
            {
               _nameTip = ComponentFactory.Instance.creatCustomObject("chat.NamePanel");
            }
            _loc21_ = String(_loc5_.tagname);
            _loc14_ = _loc21_.indexOf("$");
            if(_loc14_ > -1)
            {
               _loc21_ = _loc21_.substr(0,_loc14_);
            }
            _loc23_ = new RegExp(_loc21_,"g");
            _loc22_ = _contentField.text;
            _loc2_ = _loc23_.exec(_loc22_);
            while(_loc2_ != null)
            {
               _loc9_ = _loc2_.index;
               _loc20_ = _loc9_ + String(_loc5_.tagname).length;
               _loc10_ = _contentField.globalToLocal(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
               _loc18_ = _contentField.getCharIndexAtPoint(_loc10_.x,_loc10_.y);
               if(_loc18_ >= _loc9_ && _loc18_ <= _loc20_)
               {
                  _contentField.setSelection(_loc9_,_loc20_);
                  _loc15_ = _contentField.getCharBoundaries(_loc20_);
                  _loc3_ = _contentField.localToGlobal(new Point(_loc15_.x,_loc15_.y));
                  _nameTip.x = _loc3_.x + _loc15_.width;
                  _nameTip.y = _loc3_.y - _nameTip.getHeight - (_contentField.scrollV - 1) * 18;
                  break;
               }
               _loc2_ = _loc23_.exec(_loc22_);
            }
            _nameTip.playerName = String(_loc5_.tagname);
            if(_loc5_.channel)
            {
               _nameTip.channel = ChatFormats.Channel_Set[int(_loc5_.channel)];
            }
            else
            {
               _nameTip.channel = null;
            }
            _nameTip.message = String(_loc5_.message);
            if(_goodTip && _goodTip.parent)
            {
               _goodTip.parent.removeChild(_goodTip);
            }
            if(_loc5_.senderID == -1)
            {
               _nameTip.setVisible = false;
            }
            else
            {
               _nameTip.setVisible = true;
               ChatManager.Instance.privateChatTo(_loc5_.tagname);
            }
         }
         else if(int(_loc5_.clicktype) == 2)
         {
            _loc26_ = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
            _goodTipPos.x = _loc26_.x;
            _goodTipPos.y = _loc26_.y;
            _loc6_ = ItemManager.Instance.getTemplateById(_loc5_.templeteIDorItemID);
            _loc6_.BindType = _loc5_.isBind == "true"?0:1;
            0;
            showLinkGoodsInfo(_loc6_);
         }
         else if(int(_loc5_.clicktype) == 3)
         {
            _loc13_ = PlayerManager.Instance.Self.ZoneID;
            _loc4_ = _loc5_.zoneID;
            if(_loc4_ > 0 && _loc4_ != _loc13_)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.ViewGoodInfoUnable"));
               return;
            }
            _loc26_ = _contentField.localToGlobal(new Point(_contentField.mouseX,_contentField.mouseY));
            _goodTipPos.x = _loc26_.x;
            _goodTipPos.y = _loc26_.y;
            if(_loc5_.key != "null")
            {
               _loc11_ = ChatManager.Instance.model.getLink(_loc5_.key);
            }
            else
            {
               _loc11_ = ChatManager.Instance.model.getLink(_loc5_.templeteIDorItemID);
            }
            if(_loc11_)
            {
               showLinkGoodsInfo(_loc11_);
            }
            else if(_loc5_.key != "null")
            {
               SocketManager.Instance.out.sendGetLinkGoodsInfo(3,String(_loc5_.key),String(_loc5_.templeteIDorItemID));
            }
            else
            {
               SocketManager.Instance.out.sendGetLinkGoodsInfo(2,String(_loc5_.templeteIDorItemID));
            }
         }
         else if(int(_loc5_.clicktype) == 888)
         {
            if(StateManager.currentStateType == "main")
            {
               SocketManager.Instance.out.sendInviteYearFoodRoom(true,int(_loc5_.senderId));
            }
         }
         else if(int(_loc5_.clicktype) == 111)
         {
            RedPackageManager.getInstance().showView("red_pkg_consortia_gain");
         }
         else if(int(_loc5_.clicktype) == 999)
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
         else if(int(_loc5_.clicktype) == 890)
         {
            navigateToURL(new URLRequest(_loc5_.source),"_blank");
         }
         else if(int(_loc5_.clicktype) == 889)
         {
            if(StateManager.currentStateType == "main")
            {
               SoundManager.instance.play("008");
               _loc7_ = PlayerManager.Instance.Self;
               if(PlayerManager.Instance.Self.Bag.getItemAt(6) == null)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.room.RoomIIController.weapon"));
                  return;
               }
               if(_loc7_.IsMounts)
               {
                  HorseRaceManager.Instance.enterView();
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horseRace.noMount"));
               }
            }
         }
         else if(int(_loc5_.clicktype) == 4)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("chat.differZone.cannotChat"));
         }
         else if(int(_loc5_.clicktype) == 100)
         {
            if(!EffortManager.Instance.getMainFrameVisible())
            {
               EffortManager.Instance.isSelf = true;
               EffortManager.Instance.switchVisible();
            }
         }
         else if(int(_loc5_.clicktype) == 5)
         {
            _loc13_ = PlayerManager.Instance.Self.ZoneID;
            _loc4_ = _loc5_.zoneID;
            if(_loc4_ > 0 && _loc4_ != _loc13_)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.ViewGoodInfoUnable"));
               return;
            }
            SocketManager.Instance.out.sendGetLinkGoodsInfo(4,String(_loc5_.key));
         }
         else if(int(_loc5_.clicktype) == 6)
         {
            _loc13_ = PlayerManager.Instance.Self.ZoneID;
            _loc4_ = _loc5_.zoneID;
            if(_loc4_ > 0 && _loc4_ != _loc13_)
            {
               ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("core.crossZone.ViewGoodInfoUnable"));
               return;
            }
            SocketManager.Instance.out.sendGetLinkGoodsInfo(5,String(_loc5_.key));
         }
         else if(int(_loc5_.clicktype) == 101)
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
            if(StateManager.currentStateType == "roomlist")
            {
               SocketManager.Instance.out.sendGameLogin(1,-1,_loc5_.roomId,_loc5_.password,true);
            }
            else if(StateManager.currentStateType == "dungeon")
            {
               SocketManager.Instance.out.sendGameLogin(2,-1,_loc5_.roomId,_loc5_.password,true);
            }
            else
            {
               SocketManager.Instance.out.sendGameLogin(4,-1,_loc5_.roomId,_loc5_.password,true);
            }
         }
         else if(int(_loc5_.clicktype) > ChatFormats.CLICK_ACT_TIP)
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
            WonderfulActivityManager.Instance.skipType = _loc5_.rewardType;
            SocketManager.Instance.out.requestRookieRankInfo();
            SocketManager.Instance.out.requestWonderfulActInit(1);
         }
         else if(int(_loc5_.clicktype) == 103)
         {
            SocketManager.Instance.out.sendConsortiaInvate(_loc5_.tagname);
         }
         else if(int(_loc5_.clicktype) == 104)
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
         else if(int(_loc5_.clicktype) == 105)
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
         else if(int(_loc5_.clicktype) == 106)
         {
            _loc24_ = ChatManager.Instance.model.currentChats;
            var _loc28_:int = 0;
            var _loc27_:* = _loc24_;
            for each(var _loc8_ in _loc24_)
            {
               if(_loc8_.type == 106)
               {
                  ChatManager.Instance.notAgainData.add(_loc8_.msg,true);
                  _loc8_.htmlMessage = _loc8_.htmlMessage.replace("<FONT  COLOR=\'#8dff1e\'>" + LanguageMgr.GetTranslation("notAlertAgain") + "</FONT>","<FONT  COLOR=\'#989898\'>" + LanguageMgr.GetTranslation("notAlertAgain") + "</FONT>");
               }
            }
            ChatManager.Instance.view.output.updateCurrnetChannel();
         }
         else if(int(_loc5_.clicktype) == 108)
         {
            if(StateManager.currentStateType != "main")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("avatarCollection.pay.tipTxt"));
               return;
            }
            AvatarCollectionManager.instance.isSkipFromHall = true;
            BagAndInfoManager.Instance.showBagAndInfo(7);
         }
         else if(int(_loc5_.clicktype) == 112)
         {
            ConsortionModelManager.Instance.enterConsortiaState();
         }
         else if(int(_loc5_.clicktype) == 109)
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
         else if(int(_loc5_.clicktype) == 110)
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
         else if(int(_loc5_.clicktype) == 113)
         {
            if(ConsortiaDomainManager.instance.activeState == 1 && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "consortia_domain")
            {
               ConsortiaDomainManager.instance.enterScene(true);
            }
         }
         else if(int(_loc5_.clicktype) == 114)
         {
            if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "fighting3d")
            {
               _loc16_ = LanguageMgr.GetTranslation("chat.task.NotBattle");
               MessageTipManager.getInstance().show(_loc16_,0,true,1);
               return;
            }
            if(StateManager.currentStateType == "consortia_domain")
            {
               _loc16_ = LanguageMgr.GetTranslation("chat.task.Notconsortia");
               MessageTipManager.getInstance().show(_loc16_,0,true,1);
               return;
            }
            if(TaskManager.instance.getQuestByID(_loc5_.questId) && (TaskManager.instance.getQuestByID(_loc5_.questId).isCompleted && !TaskManager.instance.getQuestByID(_loc5_.questId).isAchieved))
            {
               finishQuest(int(_loc5_.questId));
            }
            else
            {
               _loc16_ = LanguageMgr.GetTranslation("ringStation.view.getReward.failed");
               MessageTipManager.getInstance().show(_loc16_,0,true,1);
            }
         }
      }
      
      private function finishQuest(param1:int) : void
      {
         var _loc5_:* = null;
         curQuestId = param1;
         var _loc2_:QuestInfo = TaskManager.instance.getQuestByID(param1);
         var _loc3_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_.itemRewards;
         for each(var _loc4_ in _loc2_.itemRewards)
         {
            _loc5_ = new InventoryItemInfo();
            _loc5_.TemplateID = _loc4_.itemID;
            ItemManager.fill(_loc5_);
            _loc5_.ValidDate = _loc4_.ValidateTime;
            _loc5_.TemplateID = _loc4_.itemID;
            _loc5_.IsJudge = true;
            _loc5_.IsBinds = _loc4_.isBind;
            _loc5_.AttackCompose = _loc4_.AttackCompose;
            _loc5_.DefendCompose = _loc4_.DefendCompose;
            _loc5_.AgilityCompose = _loc4_.AgilityCompose;
            _loc5_.LuckCompose = _loc4_.LuckCompose;
            _loc5_.StrengthenLevel = _loc4_.StrengthenLevel;
            _loc5_.Count = _loc4_.count[_loc2_.QuestLevel - 1];
            if(!(0 != _loc5_.NeedSex && getSexByInt(PlayerManager.Instance.Self.Sex) != _loc5_.NeedSex))
            {
               if(_loc4_.isOptional == 1)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         if(_loc3_.length > 0)
         {
            HallTaskTrackManager.instance.moduleLoad(showSelectedAwardFrame,[_loc3_]);
         }
         else
         {
            TaskManager.instance.sendQuestFinish(_loc2_.QuestID);
            if(TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(318)) && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(319)))
            {
               SocketManager.Instance.out.syncWeakStep(49);
            }
            new CmdThreeAndPowerPickUpAndEnable().excute(param1);
         }
      }
      
      private function getSexByInt(param1:Boolean) : int
      {
         if(param1)
         {
            return 1;
         }
         return 2;
      }
      
      private function showSelectedAwardFrame(param1:Array) : void
      {
         TryonSystemController.Instance.show(param1,chooseReward,null);
      }
      
      private function chooseReward(param1:ItemTemplateInfo) : void
      {
         new CmdThreeAndPowerPickUpAndEnable().excute(curQuestId);
         SocketManager.Instance.out.sendQuestFinish(curQuestId,param1.TemplateID);
      }
      
      private function getPos(param1:Object, param2:ChatTransregionalNamePanel) : Point
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc11_:* = null;
         var _loc12_:String = String(param1.tagname);
         var _loc5_:int = _loc12_.indexOf("$");
         if(_loc5_ > -1)
         {
            _loc12_ = _loc12_.substr(0,_loc5_);
         }
         var _loc13_:RegExp = new RegExp(_loc12_,"g");
         var _loc14_:String = _contentField.text;
         var _loc3_:Object = _loc13_.exec(_loc14_);
         while(_loc3_ != null)
         {
            _loc7_ = _loc3_.index;
            _loc10_ = _loc7_ + String(param1.tagname).length;
            _loc9_ = _contentField.globalToLocal(new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
            _loc8_ = _contentField.getCharIndexAtPoint(_loc9_.x,_loc9_.y);
            if(_loc8_ >= _loc7_ && _loc8_ <= _loc10_)
            {
               _contentField.setSelection(_loc7_,_loc10_);
               _loc6_ = _contentField.getCharBoundaries(_loc10_);
               _loc4_ = _contentField.localToGlobal(new Point(_loc6_.x,_loc6_.y));
               _loc11_ = new Point();
               _loc11_.x = _loc4_.x + _loc6_.width;
               _loc11_.y = _loc4_.y - param2.getHight() - (_contentField.scrollV - 1) * 18;
               break;
            }
            _loc3_ = _loc13_.exec(_loc14_);
         }
         return _loc11_;
      }
      
      private function __stageClickHandler(param1:MouseEvent = null) : void
      {
         if(param1)
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
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
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("setselfplayerpos",[param1]));
      }
      
      protected function __onFieldOut(param1:MouseEvent) : void
      {
         Mouse.cursor = "auto";
      }
      
      protected function __onFieldOver(param1:MouseEvent) : void
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
      
      private function updateScrollRect(param1:Number, param2:Number) : void
      {
         _srcollRect = new Rectangle(0,0,param1,param2);
         _contentField.scrollRect = _srcollRect;
      }
   }
}
