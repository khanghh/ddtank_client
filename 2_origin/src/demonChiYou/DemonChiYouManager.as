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
      
      public function DemonChiYouManager(target:IEventDispatcher = null)
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
      
      private function onBossEnd(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var bossState:int = pkg.readInt();
         model.bossState = bossState;
         if(bossState == 4 || bossState == 3)
         {
            model.leftSelectSec = 30;
            if(bossState == 4)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("demonChiYou.activeOverBossDie"));
               _hasReceiveBossDieData = true;
               SocketManager.Instance.out.getDemonChiYouRankInfo();
            }
            else if(bossState == 3)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("demonChiYou.activeOverBossAlive"));
            }
         }
         else if(bossState == 5)
         {
            if(StateManager.currentStateType != "fighting" && !_hasClickIconOpenResultFrame)
            {
               showFrame(2);
            }
         }
         checkIcon();
         dispatchEvent(new Event("event_boss_end"));
      }
      
      private function onBuyItemBack(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var id:int = pkg.readInt();
         var _loc6_:int = 0;
         var _loc5_:* = model.shopInfoArr;
         for each(var item in model.shopInfoArr)
         {
            if(item["ID"] == id)
            {
               item["HasBuy"] = true;
               break;
            }
         }
         dispatchEvent(new Event("event_buy_item_back"));
      }
      
      private function onUpdateBossStateTimer(evt:TimerEvent) : void
      {
         var bossState:int = model.bossState;
         if(bossState == 1 || bossState == 3 || bossState == 4 || bossState == 5 || bossState == 6)
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
      
      private function onShopInfoBack(evt:PkgEvent) : void
      {
         var i:int = 0;
         var ID:int = 0;
         var inventoryItemInfo:* = null;
         var Cost:int = 0;
         var HasRoll:Boolean = false;
         var NickName:* = null;
         var TopPoint:int = 0;
         var PlayerId:int = 0;
         var HasBuy:Boolean = false;
         var MyPoint:int = 0;
         var MyRollCount:int = 0;
         var pkg:PackageIn = evt.pkg;
         var shopInfoArrLength:int = pkg.readInt();
         model.shopInfoArr = [];
         for(i = 0; i < shopInfoArrLength; )
         {
            ID = pkg.readInt();
            inventoryItemInfo = new InventoryItemInfo();
            inventoryItemInfo.TemplateID = pkg.readInt();
            inventoryItemInfo = ItemManager.fill(inventoryItemInfo);
            inventoryItemInfo.Count = pkg.readInt();
            inventoryItemInfo.IsBinds = true;
            Cost = pkg.readInt();
            HasRoll = pkg.readBoolean();
            NickName = null;
            TopPoint = -1;
            PlayerId = -1;
            if(HasRoll)
            {
               PlayerId = pkg.readInt();
               NickName = pkg.readUTF();
               TopPoint = pkg.readInt();
            }
            HasBuy = pkg.readBoolean();
            MyPoint = pkg.readInt();
            MyRollCount = pkg.readInt();
            model.shopInfoArr.push({
               "ID":ID,
               "InventoryItemInfo":inventoryItemInfo,
               "Cost":Cost,
               "HasRoll":HasRoll,
               "PlayerId":PlayerId,
               "NickName":NickName,
               "TopPoint":TopPoint,
               "HasBuy":HasBuy,
               "MyPoint":MyPoint,
               "MyRollCount":MyRollCount
            });
            i++;
         }
         dispatchEvent(new Event("event_shop_info_back"));
      }
      
      private function onBossInfoBack(evt:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = evt.pkg;
         model.bossMaxBlood = pkg.readInt();
         model.bossBlood = pkg.readInt();
         model.bossState = pkg.readInt();
         model.isOpen = pkg.readBoolean();
         var startDate:Date = pkg.readDate();
         var startTime:Date = pkg.readDate();
         startDate.hours = startTime.hours;
         startDate.minutes = startTime.minutes;
         startDate.seconds = startTime.seconds;
         model.startDate = startDate;
         var endDate:Date = pkg.readDate();
         var endTime:Date = pkg.readDate();
         endDate.hours = endTime.hours;
         endDate.minutes = endTime.minutes;
         endDate.seconds = endTime.seconds;
         model.endDate = endDate;
         var rewardBoxIDArr:Array = [];
         for(i = 0; i < 4; )
         {
            rewardBoxIDArr.push(pkg.readInt());
            i++;
         }
         model.bossDieTime = pkg.readDate();
         model.rewardBoxIDArr = rewardBoxIDArr;
         checkIcon();
         if(!_hasShowOpenMsg && model.bossState == 2)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("demonChiYou.activeOpenMsg"));
            _hasShowOpenMsg = true;
         }
         dispatchEvent(new Event("event_boss_info_back"));
      }
      
      private function onEnterScene(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         dispatchEvent(new CEvent("event_other_player_enter",pkg));
      }
      
      private function onLeaveScene(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var bossSate:int = pkg.readInt();
         var leavePlayerId:int = pkg.readInt();
         if(PlayerManager.Instance.Self.ID == leavePlayerId)
         {
            model.bossState = bossSate;
            if(StateManager.currentStateType == "demon_chi_you")
            {
               StateManager.setState("main");
            }
         }
         else
         {
            dispatchEvent(new CEvent("event_other_player_leave",leavePlayerId));
         }
         checkIcon();
      }
      
      private function onBuyRollBack(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var id:int = pkg.readInt();
         var roll:int = pkg.readInt();
         var MyRollCount:int = 0;
         var _loc8_:* = 0;
         var _loc7_:* = model.shopInfoArr;
         for each(var item in model.shopInfoArr)
         {
            if(item["MyRollCount"] > MyRollCount)
            {
               MyRollCount = item["MyRollCount"];
            }
         }
         var _loc10_:int = 0;
         var _loc9_:* = model.shopInfoArr;
         for each(item in model.shopInfoArr)
         {
            if(item["ID"] == id)
            {
               item["HasRoll"] = true;
               item["PlayerId"] = PlayerManager.Instance.Self.ID;
               item["NickName"] = PlayerManager.Instance.Self.NickName;
               item["MyPoint"] = roll;
               _loc8_ = "MyRollCount";
               _loc7_ = item[_loc8_] + 1;
               item[_loc8_] = _loc7_;
               break;
            }
         }
         dispatchEvent(new CEvent("event_buy_roll_back",{
            "id":id,
            "roll":roll
         }));
      }
      
      public function getRollCost() : int
      {
         var myHasRollNum:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = model.shopInfoArr;
         for each(var item in model.shopInfoArr)
         {
            if(item["MyPoint"] != -1)
            {
               myHasRollNum++;
            }
         }
         if(myHasRollNum == model.shopInfoArr.length)
         {
            return 0;
         }
         return DemonChiYouModel.ROLL_COST_ARR[myHasRollNum];
      }
      
      private function onRankInfo(evt:PkgEvent) : void
      {
         var i:int = 0;
         var Name:* = null;
         var Rank:int = 0;
         var Damage:int = 0;
         var state:int = 0;
         var pkg:PackageIn = evt.pkg;
         var rankInfo:RankInfo = model.rankInfo;
         rankInfo.hasMyConsortiaData = pkg.readBoolean();
         if(rankInfo.hasMyConsortiaData)
         {
            rankInfo.myConsortiaRank = pkg.readInt();
            rankInfo.myConsortiaDamage = pkg.readInt();
         }
         rankInfo.myDamage = pkg.readInt();
         rankInfo.rankArr = [];
         var rankInfoArrLength:int = pkg.readByte();
         for(i = 0; i < rankInfoArrLength; )
         {
            Name = pkg.readUTF();
            Rank = pkg.readInt();
            Damage = pkg.readInt();
            rankInfo.rankArr.push({
               "Name":Name,
               "Rank":Rank,
               "Damage":Damage
            });
            i++;
         }
         if(_isClickIcon)
         {
            state = model.bossState;
            if(state == 2)
            {
               SocketManager.Instance.out.enterDemonChiYouScene();
               StateManager.setState("demon_chi_you");
            }
            else if(state == 4)
            {
               clickIconShowSelectFrame();
            }
            else if(state == 5)
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
         var rankInfo:* = null;
         if(StateManager.currentStateType != "fighting")
         {
            rankInfo = model.rankInfo;
            if(rankInfo.myConsortiaRank > 0 && rankInfo.myConsortiaRank < 4 && rankInfo.myDamage > 0 && model.leftSelectSec > 0)
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
         var rankInfo:RankInfo = model.rankInfo;
         if(StateManager.currentStateType != "fighting" && rankInfo.myConsortiaRank > 0 && rankInfo.myConsortiaRank < 4 && rankInfo.myDamage > 0 && model.leftSelectSec > 0 && !_hasClickIconOpenSelectFrame)
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
            for each(var itemData in model.shopInfoArr)
            {
               if(itemData["PlayerId"] == PlayerManager.Instance.Self.ID && !itemData["HasBuy"])
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function showFrame(frameType:int) : void
      {
         this.frameType = frameType;
         new HelperUIModuleLoad().loadUIModule(["demonchiyou","ddtcorei"],show);
      }
      
      public function askAndCheckIcon() : void
      {
         SocketManager.Instance.out.getDemonChiYouBossInfo();
      }
      
      public function initHall(hall:IHallStateView) : void
      {
         _hall = hall;
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
