package oldPlayerComeBack
{
   import BombTurnTable.event.TurnTableEvent;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import oldPlayerComeBack.data.AwardItemInfo;
   import oldPlayerComeBack.data.ComeBackAwardItemsInfo;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   
   public class OldPlayerComeBackManager extends CoreManager
   {
      
      public static const OEPN_VIEW:String = "oldPlayerOpenView";
      
      public static const UPDATE_VIEW:String = "UpdateTurntableView";
      
      public static const ROLL_DICE_RESULT:String = "rollDiceResult";
      
      private static const AWARD_COUNT:int = 35;
      
      private static var _instance:OldPlayerComeBackManager;
       
      
      private var _curAwardInfo:ComeBackAwardItemsInfo;
      
      private var _showFlag:Boolean = false;
      
      private var _endDate:Date;
      
      private var _startDate:Date;
      
      private var _hall:HallStateView = null;
      
      private var _iconBtn:BaseButton = null;
      
      public function OldPlayerComeBackManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : OldPlayerComeBackManager
      {
         if(!_instance)
         {
            _instance = new OldPlayerComeBackManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(618,0),_isOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(618,1),__questionInfoHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(618,2),__rollDiceResultHandler);
      }
      
      protected function _isOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _showFlag = _loc2_.readBoolean();
         _startDate = _loc2_.readDate();
         _endDate = _loc2_.readDate();
         checkIcon();
      }
      
      public function checkIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("oldPlayerComeBack",_showFlag);
         if(_showFlag == false)
         {
            this.dispatchEvent(new TurnTableEvent("TurnTableEnd",null));
         }
      }
      
      public function get activityTimeRange() : String
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_startDate && _endDate)
         {
            _loc2_ = DateUtils.dateFormatString(DateUtils.dateFormat2(_startDate),false);
            _loc1_ = DateUtils.dateFormatString(DateUtils.dateFormat2(_endDate),false);
            return _loc2_ + " - " + _loc1_;
         }
         return "error!";
      }
      
      private function __questionInfoHandler(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         _curAwardInfo = new ComeBackAwardItemsInfo();
         _curAwardInfo.curPlace = _loc5_.readInt();
         _loc4_ = 0;
         while(_loc4_ < 35)
         {
            _loc7_ = new AwardItemInfo();
            _loc7_.place = _loc5_.readInt();
            _loc7_.templateID = _loc5_.readUTF();
            _loc7_.count = _loc5_.readInt();
            _curAwardInfo.addInfo(_loc7_);
            _loc4_++;
         }
         this.dispatchEvent(new Event("UpdateTurntableView"));
      }
      
      private function __rollDiceResultHandler(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         this.dispatchEvent(new CEvent("rollDiceResult",_loc2_));
      }
      
      public function sendRollDice(param1:int) : void
      {
         SocketManager.Instance.out.sendRollDice(param1);
      }
      
      public function requestAwardItem() : void
      {
         SocketManager.Instance.out.requestAwardItem();
      }
      
      override protected function start() : void
      {
         this.dispatchEvent(new Event("oldPlayerOpenView"));
      }
      
      public function get curAwardInfo() : ComeBackAwardItemsInfo
      {
         return _curAwardInfo;
      }
      
      public function set curAwardInfo(param1:ComeBackAwardItemsInfo) : void
      {
         _curAwardInfo = param1;
      }
   }
}
