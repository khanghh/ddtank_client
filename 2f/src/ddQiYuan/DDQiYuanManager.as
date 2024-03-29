package ddQiYuan
{
   import bagAndInfo.BagAndInfoManager;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddQiYuan.model.DDQiYuanModel;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class DDQiYuanManager extends EventDispatcher
   {
      
      public static const EVENT_OPEN_FRAME:String = "event_open_frame";
      
      public static const EVENT_OP_START:String = "event_op_start";
      
      public static const EVENT_OP_BACK:String = "event_op_back";
      
      public static const EVENT_OP_FRAMEDISPOSE:String = "event_op_framedispose";
      
      public static const EVENT_QUERY_AREA_RANK_BACK:String = "event_query_area_rank_back";
      
      public static const EVENT_GAIN_JOIN_REWARD_BACK:String = "event_gain_join_reward_back";
      
      public static const EVENT_QUERY_TOWER_TASK_BACK:String = "event_query_tower_task_back";
      
      public static const EVENT_GAIN_BOGU_TASK_REWARD_BACK:String = "event_gain_bogu_task_reward_back";
      
      public static const EVENT_CHANGE_TYPE:String = "event_change_type";
      
      public static const PACK_TYPE_MY_INFO:int = 39;
      
      public static const PACK_TYPE_RANK_REWARD_CONFIG:int = 33;
      
      public static const PACK_TYPE_OFFER:int = 38;
      
      public static const PACK_TYPE_OPEN_BOGU_BOX:int = 34;
      
      public static const PACK_TYPE_AREA_RANK:int = 37;
      
      public static const PACK_TYPE_QUERY_TOWER_TASK:int = 35;
      
      public static const PACK_TYPE_RECEIVE_BOGU_TASK_REWARD:int = 36;
      
      public static const PACK_TYPE_PUSH_OPEN_CLOSE:int = 40;
      
      public static const PACK_TYPE_GAIN_JOIN_REWARD:int = 51;
      
      public static const OPTYPE_OFFER_1:int = 1;
      
      public static const OPTYPE_OFFER_10:int = 2;
      
      public static const OPTYPE_OPEN_TREASURE_BOX:int = 3;
      
      private static var _instance:DDQiYuanManager;
       
      
      private var _model:DDQiYuanModel;
      
      private var _hallView:HallStateView;
      
      private var _lastOpType:int;
      
      private var _isLoadData:Boolean = false;
      
      private var _buyConfirmAlertData:ConfirmAlertData;
      
      public var continueOpen:int = 0;
      
      public var notShowAlertAgain:Boolean;
      
      private var _awardsViewFrame:BaseAlerFrame;
      
      public var useType:int = 0;
      
      public function DDQiYuanManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : DDQiYuanManager{return null;}
      
      public function setup() : void{}
      
      public function show() : void{}
      
      private function onPackTypeMyInfo(param1:PkgEvent) : void{}
      
      private function onPackTypeRankRewardConfig(param1:PkgEvent) : void{}
      
      private function onPackTypeAreaRank(param1:PkgEvent) : void{}
      
      private function onPackTypeQueryTowerTask(param1:PkgEvent) : void{}
      
      private function onPackTypeOffer(param1:PkgEvent) : void{}
      
      private function remindGainBeliefReward() : Boolean{return false;}
      
      private function onPackTypeOpenBoGuBox(param1:PkgEvent) : void{}
      
      private function onPackTypeActiveOpenClose(param1:PkgEvent) : void{}
      
      private function onPackTypeGainJoinReward(param1:PkgEvent) : void{}
      
      private function onPackTypeGainTowerTask(param1:PkgEvent) : void{}
      
      private function checkAndShowIcon() : void{}
      
      private function __awardframeDispose(param1:CEvent = null) : void{}
      
      private function showPreviewFrame(param1:String, param2:PackageIn, param3:String) : void{}
      
      public function sendOfferTimes(param1:int) : void{}
      
      public function sendDDQiYuanOpenTreasureBox() : void{}
      
      public function getInventoryItemInfo(param1:Object) : InventoryItemInfo{return null;}
      
      public function get lastOpType() : int{return 0;}
      
      public function get model() : DDQiYuanModel{return null;}
   }
}
