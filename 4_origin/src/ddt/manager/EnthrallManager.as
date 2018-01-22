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
      
      public function EnthrallManager(param1:SingletonEnfocer)
      {
         super();
         inited = false;
         _timer = TimerManager.getInstance().addTimerJuggler(60000);
         _timer1 = TimerManager.getInstance().addTimerJuggler(1000);
      }
      
      public static function getInstance() : EnthrallManager
      {
         if(_instance == null)
         {
            _instance = new EnthrallManager(new SingletonEnfocer());
         }
         return _instance;
      }
      
      private function init() : void
      {
         inited = true;
         _view = ComponentFactory.Instance.creat("EnthrallViewSprite");
         _view.manager = this;
         if(TimeManager.Instance.totalGameTime >= 300)
         {
            lastState = TimeManager.Instance.totalGameTime + 15;
         }
         _timer.addEventListener("timer",__timerHandler);
         _timer1.addEventListener("timer",__timer1Handler);
         _timer.start();
      }
      
      private function __timerHandler(param1:Event) : void
      {
         _loadedTime = Number(_loadedTime) + 1;
         TimeManager.Instance.totalGameTime = TimeManager.Instance.totalGameTime + 1;
         checkState();
      }
      
      private function checkState() : void
      {
         if(_enthrallSwicth == false)
         {
            return;
         }
         if(TimeManager.Instance.totalGameTime == STATE_1)
         {
            if(_view.parent)
            {
               remind(LanguageMgr.GetTranslation("tank.manager.enthrallRemind1"));
            }
         }
         if(TimeManager.Instance.totalGameTime == STATE_2)
         {
            remind(LanguageMgr.GetTranslation("tank.manager.enthrallRemind2"));
         }
         if(TimeManager.Instance.totalGameTime == STATE_3)
         {
            if(_view.parent)
            {
               remind(LanguageMgr.GetTranslation("tank.manager.enthrallRemind3"));
            }
         }
         if(TimeManager.Instance.totalGameTime == STATE_4 || TimeManager.Instance.totalGameTime == STATE_5 || TimeManager.Instance.totalGameTime == STATE_6)
         {
            if(_view.parent)
            {
               remind(LanguageMgr.GetTranslation("tank.manager.enthrallRemind4"));
            }
         }
         if(TimeManager.Instance.totalGameTime == STATE_7)
         {
            lastState = STATE_7 + 15;
            if(_view.parent)
            {
               remind(LanguageMgr.GetTranslation("tank.manager.enthrallRemind5"));
            }
         }
         if(TimeManager.Instance.totalGameTime > STATE_7 && TimeManager.Instance.totalGameTime == lastState)
         {
            if(_view.parent)
            {
               remind(LanguageMgr.GetTranslation("tank.manager.enthrallRemind5"));
               lastState = lastState + 15;
            }
         }
      }
      
      private function remind(param1:String) : void
      {
         if(StateManager.currentStateType != "main")
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),param1,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
         _loc2_.addEventListener("response",__alertFreeBack);
      }
      
      protected function __alertFreeBack(param1:FrameEvent) : void
      {
         param1.currentTarget.removeEventListener("response",__alertFreeBack);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      public function updateLight() : void
      {
         _view.update();
      }
      
      private function __timer1Handler(param1:Event) : void
      {
         if(!_popCIDChecker)
         {
            return;
         }
         if(StateManager.currentStateType == "main")
         {
            showCIDCheckerFrame();
            _timer1.stop();
         }
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(224),changeCIDChecker);
         SocketManager.Instance.addEventListener(PkgEvent.format(227),readStates);
      }
      
      private function changeCIDChecker(param1:PkgEvent) : void
      {
         if(!inited)
         {
            init();
         }
         var _loc2_:PackageIn = param1.pkg;
         _popCIDChecker = _loc2_.readBoolean();
         if(_popCIDChecker)
         {
            _timer1.start();
         }
         else
         {
            closeCIDCheckerFrame();
         }
      }
      
      private function readStates(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _enthrallSwicth = _loc2_.readBoolean();
         _interfaceID = _loc2_.readInt();
         _hasApproved = _loc2_.readBoolean();
         _isMinor = _loc2_.readBoolean();
         updateEnthrallView();
      }
      
      public function updateEnthrallView() : void
      {
         if(!_enthrallSwicth)
         {
            hideEnthrallLight();
            return;
         }
         if(_hasApproved && !_isMinor)
         {
            hideEnthrallLight();
            return;
         }
         if(!inited)
         {
            init();
         }
         if(_enthrallSwicth)
         {
            if(_hasApproved && !_isMinor)
            {
               hideEnthrallLight();
            }
            else
            {
               showEnthrallLight();
            }
         }
         else
         {
            hideEnthrallLight();
         }
         _view.changeBtn(false);
         _view.changeToGameState(false);
         _view.changeBtn(false);
         var _loc1_:* = StateManager.currentStateType;
         if("main" !== _loc1_)
         {
            if("trainer1" !== _loc1_)
            {
               if("trainer2" !== _loc1_)
               {
                  return;
               }
            }
            _view.changeToGameState(true);
            return;
         }
         _view.changeBtn(!_hasApproved);
      }
      
      private function closeCIDCheckerFrame() : void
      {
         validateFrame.hide();
      }
      
      public function showCIDCheckerFrame() : void
      {
         if(interfaceID != 0)
         {
            LayerManager.Instance.addToLayer(ComponentFactory.Instance.creat("EnthrallValidateFrame17173") as Validate17173,3,true,0,false);
            return;
         }
         if(!validateFrame || !validateFrame.parent)
         {
            validateFrame = ComponentFactory.Instance.creat("EnthrallValidateFrame");
         }
         LayerManager.Instance.addToLayer(validateFrame,3,true,0,false);
      }
      
      public function showEnthrallLight() : void
      {
         LayerManager.Instance.addToLayer(_view,2,false,0,false);
         updateLight();
      }
      
      public function hideEnthrallLight() : void
      {
         if(_view && _view.parent)
         {
            _view.parent.removeChild(_view);
         }
      }
      
      public function gameState(param1:Number) : void
      {
         _view.x = param1 - 100;
         _view.y = 15;
      }
      
      public function outGame() : void
      {
         _view.x = 110;
         _view.y = 5;
      }
      
      public function get enthrallSwicth() : Boolean
      {
         return _enthrallSwicth;
      }
      
      public function get isEnthrall() : Boolean
      {
         return enthrallSwicth && (!_hasApproved || _isMinor);
      }
      
      public function get interfaceID() : int
      {
         if(!_interfaceID)
         {
            return 0;
         }
         return _interfaceID;
      }
   }
}

class SingletonEnfocer
{
    
   
   function SingletonEnfocer()
   {
      super();
   }
}
