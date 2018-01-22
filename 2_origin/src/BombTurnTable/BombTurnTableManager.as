package BombTurnTable
{
   import BombTurnTable.event.TurnTableEvent;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class BombTurnTableManager extends CoreManager
   {
      
      public static const TURNTABLE_OPENVIEW:String = "TurnTableOpenView";
      
      public static const TURNTABLE_END:String = "TurnTableEnd";
      
      private static var _instance:BombTurnTableManager = null;
       
      
      private var _showFlag:Boolean = false;
      
      private var _iconBtn:BaseButton = null;
      
      private var _hall:HallStateView = null;
      
      private var _endDate:Date;
      
      private var _clickNum:Number = 0;
      
      public function BombTurnTableManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : BombTurnTableManager
      {
         if(_instance == null)
         {
            _instance = new BombTurnTableManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(329,52),_isOpen);
      }
      
      protected function _isOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _showFlag = _loc2_.readBoolean();
         _endDate = _loc2_.readDate();
         checkIcon();
      }
      
      private function checkIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("bombTurnTable",_showFlag);
         if(_showFlag == false)
         {
            this.dispatchEvent(new TurnTableEvent("TurnTableEnd",null));
         }
      }
      
      public function openView_Handler() : void
      {
         SoundManager.instance.playButtonSound();
         var _loc1_:Number = new Date().time;
         if(_loc1_ - _clickNum < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickNum = _loc1_;
         show();
      }
      
      public function get isValid() : Boolean
      {
         var _loc1_:Number = _endDate.getTime() - 2000;
         var _loc2_:Number = TimeManager.Instance.Now().getTime();
         if(_loc1_ < _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function sendStartLottery() : void
      {
         SocketManager.Instance.out.sendBombTurnTableLottery();
      }
      
      public function requestViewData() : void
      {
         SocketManager.Instance.out.requestBombTurnTableData();
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["bombTurnTable"],function():void
         {
            dispatchEvent(new CEvent("TurnTableOpenView"));
         });
      }
   }
}
