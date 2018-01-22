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
      
      public function FreshmanRoomState()
      {
         super();
      }
      
      override public function getType() : String
      {
         if(StartupResourceLoader.firstEnterHall)
         {
            return "freshmanRoom2";
         }
         return "freshmanRoom1";
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         MainToolBar.Instance.hide();
         LayerManager.Instance.clearnGameDynamic();
         black = new Sprite();
         black.graphics.beginFill(0,1);
         black.graphics.drawRect(0,0,1000,600);
         black.graphics.endFill();
         addChild(black);
         if((NewHandGuideManager.Instance.mapID == 115 || NewHandGuideManager.Instance.mapID == 116) && PlayerManager.Instance.Self.getBag(3).items.length < 3)
         {
            SocketManager.Instance.out.sendBuyProp(1001202,false);
         }
         SocketManager.Instance.out.enterUserGuide(NewHandGuideManager.Instance.mapID);
         GameInSocketOut.sendGameStart();
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         if(black && black.parent)
         {
            black.parent.removeChild(black);
         }
         super.leaving(param1);
      }
   }
}
