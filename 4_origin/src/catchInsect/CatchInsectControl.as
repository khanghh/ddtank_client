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
      
      public function CatchInsectControl()
      {
         super();
      }
      
      public static function get instance() : CatchInsectControl
      {
         if(!_instance)
         {
            _instance = new CatchInsectControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         CatchInsectManager.instance.addEventListener("catchInsectCreatRoomView",__onCreatRoomView);
         CatchInsectManager.instance.addEventListener("catchInsectSetViewAgain",__onSetViewAgain);
         CatchInsectManager.instance.addEventListener("catchInsectUpdatePlayerState",__onUpdatePlayerState);
         CatchInsectManager.instance.addEventListener("catchInsectUpdateSelfState",__onUpdateSelfState);
         CatchInsectManager.instance.addEventListener("catchInsectMovePlayer",__onMovePlayer);
         CatchInsectManager.instance.addEventListener("catchInsectDisposeEnterIcon",__onDisposeEnterIcon);
      }
      
      protected function __onMovePlayer(param1:CatchInsectRoomEvent) : void
      {
         _view.movePlayer(param1.data["id"],param1.data["path"]);
      }
      
      protected function __onUpdateSelfState(param1:CatchInsectRoomEvent) : void
      {
         _view.updateSelfStatus(int(param1.data));
      }
      
      protected function __onUpdatePlayerState(param1:CatchInsectRoomEvent) : void
      {
         _view.updatePlayerStauts(param1.data["id"],param1.data["stauts"],param1.data["point"]);
      }
      
      protected function __onCreatRoomView(param1:CatchInsectRoomEvent) : void
      {
         _view = new CatchInsectRoomView(param1.data["view"],param1.data["model"]);
         _view.show();
      }
      
      protected function __onSetViewAgain(param1:CatchInsectRoomEvent) : void
      {
         if(_view)
         {
            _view.setViewAgain();
         }
      }
      
      public function openCheckGeinFrame() : void
      {
         _checkGeinFrame = ComponentFactory.Instance.creatComponentByStylename("catchInsect.checkGeinFrame");
         LayerManager.Instance.addToLayer(_checkGeinFrame,3,true,1);
         _checkGeinFrame.addEventListener("response",__response);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         _checkGeinFrame.removeEventListener("response",__response);
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            _checkGeinFrame.dispose();
            _checkGeinFrame = null;
         }
      }
      
      public function doOpenCatchInsectFrame() : void
      {
         CatchInsectManager.instance.loadUiModuleComplete = true;
         if(CatchInsectManager.instance.isShowIcon)
         {
            _chooseRoomFrame = ComponentFactory.Instance.creatComponentByStylename("catchInsect.chooseFrame");
            LayerManager.Instance.addToLayer(_chooseRoomFrame,3,true,1);
         }
      }
      
      protected function __onDisposeEnterIcon(param1:InsectEvent) : void
      {
         if(_checkGeinFrame)
         {
            _checkGeinFrame.dispose();
            _checkGeinFrame = null;
         }
         if(_chooseRoomFrame)
         {
            _chooseRoomFrame.dispose();
            _chooseRoomFrame = null;
         }
      }
   }
}
