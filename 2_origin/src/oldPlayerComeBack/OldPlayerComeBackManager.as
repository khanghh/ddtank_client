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
      
      public function OldPlayerComeBackManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      protected function _isOpen(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         _showFlag = pkg.readBoolean();
         _startDate = pkg.readDate();
         _endDate = pkg.readDate();
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
         var startStr:* = null;
         var endStr:* = null;
         if(_startDate && _endDate)
         {
            startStr = DateUtils.dateFormatString(DateUtils.dateFormat2(_startDate),false);
            endStr = DateUtils.dateFormatString(DateUtils.dateFormat2(_endDate),false);
            return startStr + " - " + endStr;
         }
         return "error!";
      }
      
      private function __questionInfoHandler(evt:PkgEvent) : void
      {
         var place:int = 0;
         var templateID:int = 0;
         var count:int = 0;
         var info:* = null;
         var item:int = 0;
         var pkg:PackageIn = evt.pkg;
         _curAwardInfo = new ComeBackAwardItemsInfo();
         _curAwardInfo.curPlace = pkg.readInt();
         for(item = 0; item < 35; )
         {
            info = new AwardItemInfo();
            info.place = pkg.readInt();
            info.templateID = pkg.readUTF();
            info.count = pkg.readInt();
            _curAwardInfo.addInfo(info);
            item++;
         }
         this.dispatchEvent(new Event("UpdateTurntableView"));
      }
      
      private function __rollDiceResultHandler(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var result:int = pkg.readInt();
         this.dispatchEvent(new CEvent("rollDiceResult",result));
      }
      
      public function sendRollDice(place:int) : void
      {
         SocketManager.Instance.out.sendRollDice(place);
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
      
      public function set curAwardInfo(value:ComeBackAwardItemsInfo) : void
      {
         _curAwardInfo = value;
      }
   }
}
