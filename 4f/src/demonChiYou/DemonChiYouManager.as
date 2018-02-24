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
      
      public function DemonChiYouManager(param1:IEventDispatcher = null){super();}
      
      public static function get instance() : DemonChiYouManager{return null;}
      
      public function setup() : void{}
      
      public function initEvent() : void{}
      
      public function removeEvent() : void{}
      
      private function onBossEnd(param1:PkgEvent) : void{}
      
      private function onBuyItemBack(param1:PkgEvent) : void{}
      
      private function onUpdateBossStateTimer(param1:TimerEvent) : void{}
      
      public function onClickIcon() : void{}
      
      private function onShopInfoBack(param1:PkgEvent) : void{}
      
      private function onBossInfoBack(param1:PkgEvent) : void{}
      
      private function onEnterScene(param1:PkgEvent) : void{}
      
      private function onLeaveScene(param1:PkgEvent) : void{}
      
      private function onBuyRollBack(param1:PkgEvent) : void{}
      
      public function getRollCost() : int{return 0;}
      
      private function onRankInfo(param1:PkgEvent) : void{}
      
      private function clickIconShowSelectFrame() : void{}
      
      private function autoShowSelectFrame() : void{}
      
      public function canBuyItem() : Boolean{return false;}
      
      public function showFrame(param1:int) : void{}
      
      public function askAndCheckIcon() : void{}
      
      public function initHall(param1:IHallStateView) : void{}
      
      public function checkIcon() : void{}
      
      public function deleteIcon() : void{}
   }
}
