package demonChiYou
{
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.DemonChiYouIcon;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import hall.IHallStateView;
   import road7th.comm.PackageIn;
   
   public class DemonChiYouManager extends CoreManager
   {
      
      public static const EVENT_BUY_ROLL_BACK:String = "event_buy_roll_back";
      
      public static const EVENT_GET_RANKINFO_BACK:String = "event_get_rankinfo_back";
      
      public static const EVENT_BUY_CARD_REMOVE_ITEM:String = "event_buy_card_remove_item";
      
      public static const EVENT_BOSS_INFO_BACK:String = "event_boss_info_back";
      
      public static const EVENT_SHOP_INFO_BACK:String = "event_shop_info_back";
      
      public static const EVENT_BUY_ITEM_BACK:String = "event_buy_item_back";
      
      public static const EVENT_OTHER_PLAYER_ENTER:String = "event_other_player_enter";
      
      public static const EVENT_OTHER_PLAYER_LEAVE:String = "event_other_player_leave";
      
      public static const EVENT_BOSS_END:String = "event_boss_end";
      
      public static const FRAME_TYPE_REWARD_SELECT:int = 1;
      
      public static const FRAME_TYPE_REWARD_RESULT:int = 2;
      
      public static const FRAME_TYPE_REWARD_BUY_CARD:int = 3;
      
      private static var _instance:DemonChiYouManager;
       
      
      public var frameType:int;
      
      public var model:DemonChiYouModel;
      
      public var rollConfirmAlertData:ConfirmAlertData;
      
      private var _hall:IHallStateView;
      
      private var _icon:DemonChiYouIcon;
      
      private var _updateBossStateTimer:Timer;
      
      private var _isClickIcon:Boolean = false;
      
      public var hasShowPromptMC:Boolean = false;
      
      private var _hasShowOpenMsg:Boolean = false;
      
      private var _hasReceiveBossDieData:Boolean = false;
      
      private var _hasClickIconOpenSelectFrame:Boolean = false;
      
      private var _hasClickIconOpenResultFrame:Boolean = false;
      
      public function DemonChiYouManager(param1:IEventDispatcher = null)
      {
         super();
         _instance = this;
         model = new DemonChiYouModel();
         rollConfirmAlertData = new ConfirmAlertData();
         rollConfirmAlertData.isBind = false;
         rollConfirmAlertData.notShowAlertAgain = false;
      }
      
      public static function get instance() : DemonChiYouManager
      {
         if(_instance == null)
         {
            _instance = new DemonChiYouManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(314,8),onBossInfoBack);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,9),onShopInfoBack);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,6),onBuyRollBack);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,3),onRankInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,7),onBuyItemBack);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,11),onBossEnd);
      }
      
      public function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(314,2),onLeaveScene);
         SocketManager.Instance.addEventListener(PkgEvent.format(314,0),onEnterScene);
         _updateBossStateTimer = new Timer(5000,2147483647);
         _updateBossStateTimer.addEventListener("timer",onUpdateBossStateTimer);
         _updateBossStateTimer.start();
      }
      
      public function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(314,2),onLeaveScene);
         SocketManager.Instance.removeEventListener(PkgEvent.format(314,0),onEnterScene);
         _updateBossStateTimer.removeEventListener("timer",onUpdateBossStateTimer);
         _updateBossStateTimer.stop();
      }
      
      private function onBossEnd(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         model.bossState = _loc3_;
         if(_loc3_ == 4 || _loc3_ == 3)
         {
            model.leftSelectSec = 30;
            if(_loc3_ == 4)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("demonChiYou.activeOverBossDie"));
               _hasReceiveBossDieData = true;
               SocketManager.Instance.out.getDemonChiYouRankInfo();
            }
            else if(_loc3_ == 3)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("demonChiYou.activeOverBossAlive"));
            }
         }
         else if(_loc3_ == 5)
         {
            if(StateManager.currentStateType != "fighting" && !_hasClickIconOpenResultFrame)
            {
               showFrame(2);
            }
         }
         checkIcon();
         dispatchEvent(new Event("event_boss_end"));
      }
      
      private function onBuyItemBack(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc6_:int = 0;
         var _loc5_:* = model.shopInfoArr;
         for each(var _loc3_ in model.shopInfoArr)
         {
            if(_loc3_["ID"] == _loc2_)
            {
               _loc3_["HasBuy"] = true;
               break;
            }
         }
         dispatchEvent(new Event("event_buy_item_back"));
      }
      
      private function onUpdateBossStateTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = model.bossState;
         if(_loc2_ == 1 || _loc2_ == 3 || _loc2_ == 4 || _loc2_ == 5 || _loc2_ == 6)
         {
            _updateBossStateTimer.removeEventListener("timer",onUpdateBossStateTimer);
            _updateBossStateTimer.stop();
         }
         else
         {
            SocketManager.Instance.out.getDemonChiYouBossInfo();
         }
      }
      
      public function onClickIcon() : void
      {
         _isClickIcon = true;
         SocketManager.Instance.out.getDemonChiYouBossInfo();
         SocketManager.Instance.out.getDemonChiYouRankInfo();
      }
      
      private function onShopInfoBack(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:* = null;
         var _loc7_:int = 0;
         var _loc12_:Boolean = false;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc14_:int = 0;
         var _loc10_:Boolean = false;
         var _loc4_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         model.shopInfoArr = [];
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc11_ = _loc5_.readInt();
            _loc9_ = new InventoryItemInfo();
            _loc9_.TemplateID = _loc5_.readInt();
            _loc9_ = ItemManager.fill(_loc9_);
            _loc9_.Count = _loc5_.readInt();
            _loc9_.IsBinds = true;
            _loc7_ = _loc5_.readInt();
            _loc12_ = _loc5_.readBoolean();
            _loc3_ = null;
            _loc8_ = -1;
            _loc14_ = -1;
            if(_loc12_)
            {
               _loc14_ = _loc5_.readInt();
               _loc3_ = _loc5_.readUTF();
               _loc8_ = _loc5_.readInt();
            }
            _loc10_ = _loc5_.readBoolean();
            _loc4_ = _loc5_.readInt();
            _loc13_ = _loc5_.readInt();
            model.shopInfoArr.push({
               "ID":_loc11_,
               "InventoryItemInfo":_loc9_,
               "Cost":_loc7_,
               "HasRoll":_loc12_,
               "PlayerId":_loc14_,
               "NickName":_loc3_,
               "TopPoint":_loc8_,
               "HasBuy":_loc10_,
               "MyPoint":_loc4_,
               "MyRollCount":_loc13_
            });
            _loc6_++;
         }
         dispatchEvent(new Event("event_shop_info_back"));
      }
      
      private function onBossInfoBack(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         model.bossMaxBlood = _loc5_.readInt();
         model.bossBlood = _loc5_.readInt();
         model.bossState = _loc5_.readInt();
         model.isOpen = _loc5_.readBoolean();
         var _loc3_:Date = _loc5_.readDate();
         var _loc2_:Date = _loc5_.readDate();
         _loc3_.hours = _loc2_.hours;
         _loc3_.minutes = _loc2_.minutes;
         _loc3_.seconds = _loc2_.seconds;
         model.startDate = _loc3_;
         var _loc6_:Date = _loc5_.readDate();
         var _loc7_:Date = _loc5_.readDate();
         _loc6_.hours = _loc7_.hours;
         _loc6_.minutes = _loc7_.minutes;
         _loc6_.seconds = _loc7_.seconds;
         model.endDate = _loc6_;
         var _loc4_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < 4)
         {
            _loc4_.push(_loc5_.readInt());
            _loc8_++;
         }
         model.bossDieTime = _loc5_.readDate();
         model.rewardBoxIDArr = _loc4_;
         checkIcon();
         if(!_hasShowOpenMsg && model.bossState == 2)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("demonChiYou.activeOpenMsg"));
            _hasShowOpenMsg = true;
         }
         dispatchEvent(new Event("event_boss_info_back"));
      }
      
      private function onEnterScene(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         dispatchEvent(new CEvent("event_other_player_enter",_loc2_));
      }
      
      private function onLeaveScene(param1:PkgEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:int = _loc4_.readInt();
         if(PlayerManager.Instance.Self.ID == _loc3_)
         {
            model.bossState = _loc2_;
            if(StateManager.currentStateType == "demon_chi_you")
            {
               StateManager.setState("main");
            }
         }
         else
         {
            dispatchEvent(new CEvent("event_other_player_leave",_loc3_));
         }
         checkIcon();
      }
      
      private function onBuyRollBack(param1:PkgEvent) : void
      {
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         var _loc3_:int = _loc5_.readInt();
         var _loc6_:int = 0;
         var _loc8_:* = 0;
         var _loc7_:* = model.shopInfoArr;
         for each(var _loc4_ in model.shopInfoArr)
         {
            if(_loc4_["MyRollCount"] > _loc6_)
            {
               _loc6_ = _loc4_["MyRollCount"];
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = model.shopInfoArr;
         for each(_loc4_ in model.shopInfoArr)
         {
            if(_loc4_["ID"] == _loc2_)
            {
               _loc4_["HasRoll"] = true;
               _loc4_["PlayerId"] = PlayerManager.Instance.Self.ID;
               _loc4_["NickName"] = PlayerManager.Instance.Self.NickName;
               _loc4_["MyPoint"] = _loc3_;
               _loc8_ = "MyRollCount";
               _loc7_ = _loc4_[_loc8_] + 1;
               _loc4_[_loc8_] = _loc7_;
               break;
            }
         }
         dispatchEvent(new CEvent("event_buy_roll_back",{
            "id":_loc2_,
            "roll":_loc3_
         }));
      }
      
      public function getRollCost() : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = model.shopInfoArr;
         for each(var _loc1_ in model.shopInfoArr)
         {
            if(_loc1_["MyPoint"] != -1)
            {
               _loc2_++;
            }
         }
         if(_loc2_ == model.shopInfoArr.length)
         {
            return 0;
         }
         return DemonChiYouModel.ROLL_COST_ARR[_loc2_];
      }
      
      private function onRankInfo(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:PackageIn = param1.pkg;
         var _loc8_:RankInfo = model.rankInfo;
         _loc8_.hasMyConsortiaData = _loc7_.readBoolean();
         if(_loc8_.hasMyConsortiaData)
         {
            _loc8_.myConsortiaRank = _loc7_.readInt();
            _loc8_.myConsortiaDamage = _loc7_.readInt();
         }
         _loc8_.myDamage = _loc7_.readInt();
         _loc8_.rankArr = [];
         var _loc5_:int = _loc7_.readByte();
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc2_ = _loc7_.readUTF();
            _loc4_ = _loc7_.readInt();
            _loc3_ = _loc7_.readInt();
            _loc8_.rankArr.push({
               "Name":_loc2_,
               "Rank":_loc4_,
               "Damage":_loc3_
            });
            _loc9_++;
         }
         if(_isClickIcon)
         {
            _loc6_ = model.bossState;
            if(_loc6_ == 2)
            {
               SocketManager.Instance.out.enterDemonChiYouScene();
               StateManager.setState("demon_chi_you");
            }
            else if(_loc6_ == 4)
            {
               clickIconShowSelectFrame();
            }
            else if(_loc6_ == 5)
            {
               _hasClickIconOpenResultFrame = true;
               DemonChiYouManager.instance.showFrame(2);
            }
            _isClickIcon = false;
         }
         if(_hasReceiveBossDieData)
         {
            autoShowSelectFrame();
            _hasReceiveBossDieData = false;
         }
         dispatchEvent(new Event("event_get_rankinfo_back"));
      }
      
      private function clickIconShowSelectFrame() : void
      {
         var _loc1_:* = null;
         if(StateManager.currentStateType != "fighting")
         {
            _loc1_ = model.rankInfo;
            if(_loc1_.myConsortiaRank > 0 && _loc1_.myConsortiaRank < 4 && _loc1_.myDamage > 0 && model.leftSelectSec > 0)
            {
               _hasClickIconOpenSelectFrame = true;
               DemonChiYouManager.instance.showFrame(1);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("demonChiYou.waiting"));
            }
         }
      }
      
      private function autoShowSelectFrame() : void
      {
         var _loc1_:RankInfo = model.rankInfo;
         if(StateManager.currentStateType != "fighting" && _loc1_.myConsortiaRank > 0 && _loc1_.myConsortiaRank < 4 && _loc1_.myDamage > 0 && model.leftSelectSec > 0 && !_hasClickIconOpenSelectFrame)
         {
            DemonChiYouManager.instance.showFrame(1);
         }
      }
      
      public function canBuyItem() : Boolean
      {
         if(model.bossState == 5)
         {
            var _loc3_:int = 0;
            var _loc2_:* = model.shopInfoArr;
            for each(var _loc1_ in model.shopInfoArr)
            {
               if(_loc1_["PlayerId"] == PlayerManager.Instance.Self.ID && !_loc1_["HasBuy"])
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function showFrame(param1:int) : void
      {
         this.frameType = param1;
         new HelperUIModuleLoad().loadUIModule(["demonchiyou","ddtcorei"],show);
      }
      
      public function askAndCheckIcon() : void
      {
         SocketManager.Instance.out.getDemonChiYouBossInfo();
      }
      
      public function initHall(param1:IHallStateView) : void
      {
         _hall = param1;
         checkIcon();
      }
      
      public function checkIcon() : void
      {
      }
      
      public function deleteIcon() : void
      {
      }
   }
}
