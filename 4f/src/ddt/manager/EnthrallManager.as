package ddt.manager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.view.enthrall.EnthrallView;
   import ddt.view.enthrall.Validate17173;
   import ddt.view.enthrall.ValidateFrame;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class EnthrallManager
   {
      
      private static var _instance:EnthrallManager;
      
      public static var STATE_1:int = 60;
      
      public static var STATE_2:int = 120;
      
      public static var STATE_3:int = 180;
      
      public static var STATE_4:int = 210;
      
      public static var STATE_5:int = 240;
      
      public static var STATE_6:int = 270;
      
      public static var STATE_7:int = 300;
       
      
      private var _view:EnthrallView;
      
      private var _timer:TimerJuggler;
      
      private var _timer1:TimerJuggler;
      
      private var _loadedTime:int = 0;
      
      private var _showEnthrallLight:Boolean = false;
      
      private var _popCIDChecker:Boolean = false;
      
      private var _enthrallSwicth:Boolean;
      
      private var _hasApproved:Boolean;
      
      private var _isMinor:Boolean;
      
      private var _interfaceID:int;
      
      private var validateFrame:ValidateFrame;
      
      public var lastState:int;
      
      private var inited:Boolean;
      
      public function EnthrallManager(param1:SingletonEnfocer){super();}
      
      public static function getInstance() : EnthrallManager{return null;}
      
      private function init() : void{}
      
      private function __timerHandler(param1:Event) : void{}
      
      private function checkState() : void{}
      
      private function remind(param1:String) : void{}
      
      protected function __alertFreeBack(param1:FrameEvent) : void{}
      
      public function updateLight() : void{}
      
      private function __timer1Handler(param1:Event) : void{}
      
      public function setup() : void{}
      
      private function changeCIDChecker(param1:PkgEvent) : void{}
      
      private function readStates(param1:PkgEvent) : void{}
      
      public function updateEnthrallView() : void{}
      
      private function closeCIDCheckerFrame() : void{}
      
      public function showCIDCheckerFrame() : void{}
      
      public function showEnthrallLight() : void{}
      
      public function hideEnthrallLight() : void{}
      
      public function gameState(param1:Number) : void{}
      
      public function outGame() : void{}
      
      public function get enthrallSwicth() : Boolean{return false;}
      
      public function get isEnthrall() : Boolean{return false;}
      
      public function get interfaceID() : int{return 0;}
   }
}

class SingletonEnfocer
{
    
   
   function SingletonEnfocer(){super();}
}
