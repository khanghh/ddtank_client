package room.view.states
{
   import com.pickgliss.ui.LayerManager;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.display.Sprite;
   import trainer.controller.NewHandGuideManager;
   
   public class FreshmanRoomState extends BaseRoomState
   {
       
      
      private var black:Sprite;
      
      public function FreshmanRoomState(){super();}
      
      override public function getType() : String{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
   }
}
