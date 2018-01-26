package welfareCenter.callBackLotteryDraw
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.LuckeyLotteryDrawIcon;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import welfareCenter.WelfareCenterManager;
   
   public class CallBackLotteryDrawManager extends CoreManager
   {
      
      public static const TYPE_CALLBACK:int = 0;
      
      public static const TYPE_LUCKEY:int = 1;
      
      public static const EACH_PHASE_CARD_NUM:int = 5;
      
      public static const EVENT_OPEN_FRAME:String = "event_open_frame";
      
      public static const EVENT_ZERO_FRESH:String = "event_zero_fresh";
      
      public static const EVENT_INFO_CHANGE:String = "event_info_change";
      
      public static const EVENT_OP_BACK_BUY:String = "event_op_back_buy";
      
      public static const CLICK_CARD_OPEN_ITEM:String = "click_card_open_item";
      
      public static const CLICK_CARD_OPEN_PLAY_OVER:String = "click_card_open_play_over";
      
      public static var _firstEnterCdSec:int;
      
      private static var _instance:CallBackLotteryDrawManager;
       
      
      public var callBackLotteryDrawModel:LotteryDrawModel;
      
      public var luckeyLotteryDrawModel:LotteryDrawModel;
      
      public var type:int;
      
      private var _callBackTimer:Timer;
      
      private var _luckeyTimer:Timer;
      
      private var _timer:Timer;
      
      private var _luckeyLotteryDrawIcon:LuckeyLotteryDrawIcon;
      
      public function CallBackLotteryDrawManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : CallBackLotteryDrawManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      public function queryLotteryGoods(param1:int) : void{}
      
      private function onPackTypeInfo(param1:PkgEvent) : void{}
      
      public function checkLuckIconAndShowIcon() : void{}
      
      private function onTimerTick(param1:TimerEvent) : void{}
      
      private function updateLeftTimeTf() : void{}
      
      private function onCheckOpenCallBackTimer(param1:TimerEvent) : void{}
      
      private function onCheckOpenLuckeyTimer(param1:TimerEvent) : void{}
      
      public function checkCallBackActiveOpen() : void{}
      
      public function checkLuckeyActiveOpen() : void{}
      
      private function initModel(param1:LotteryDrawModel, param2:PackageIn) : void{}
      
      private function onPackTypeGoods(param1:PkgEvent) : void{}
      
      public function getCallBackLeftSec() : int{return 0;}
      
      public function getLuckeyLeftSec() : int{return 0;}
      
      public function onPackTypeBuy(param1:PkgEvent) : void{}
   }
}
