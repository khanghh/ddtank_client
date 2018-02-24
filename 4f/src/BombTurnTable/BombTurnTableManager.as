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
      
      public function BombTurnTableManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : BombTurnTableManager{return null;}
      
      public function setup() : void{}
      
      protected function _isOpen(param1:PkgEvent) : void{}
      
      private function checkIcon() : void{}
      
      public function openView_Handler() : void{}
      
      public function get isValid() : Boolean{return false;}
      
      public function sendStartLottery() : void{}
      
      public function requestViewData() : void{}
      
      override protected function start() : void{}
   }
}
