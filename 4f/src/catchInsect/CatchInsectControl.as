package catchInsect
{
   import catchInsect.componets.InsectTitleTip;
   import catchInsect.event.CatchInsectRoomEvent;
   import catchInsect.event.InsectEvent;
   import catchInsect.view.CatchInsectCheckGeinFrame;
   import catchInsect.view.CatchInsectChooseFrame;
   import catchInsect.view.CatchInsectRoomView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.SoundManager;
   import flash.events.EventDispatcher;
   
   public class CatchInsectControl extends EventDispatcher
   {
      
      private static var _instance:CatchInsectControl;
       
      
      private var _checkGeinFrame:CatchInsectCheckGeinFrame;
      
      private var _chooseRoomFrame:CatchInsectChooseFrame;
      
      private var _view:CatchInsectRoomView;
      
      public var isUnicorn:Boolean;
      
      public var refMonsID:int;
      
      public var isRefreshMonster:Boolean;
      
      public function CatchInsectControl(){super();}
      
      public static function get instance() : CatchInsectControl{return null;}
      
      public function setup() : void{}
      
      protected function __onMovePlayer(param1:CatchInsectRoomEvent) : void{}
      
      protected function __onUpdateSelfState(param1:CatchInsectRoomEvent) : void{}
      
      protected function __onUpdatePlayerState(param1:CatchInsectRoomEvent) : void{}
      
      protected function __onCreatRoomView(param1:CatchInsectRoomEvent) : void{}
      
      protected function __onSetViewAgain(param1:CatchInsectRoomEvent) : void{}
      
      public function openCheckGeinFrame() : void{}
      
      private function __response(param1:FrameEvent) : void{}
      
      public function doOpenCatchInsectFrame() : void{}
      
      protected function __onDisposeEnterIcon(param1:InsectEvent) : void{}
   }
}
