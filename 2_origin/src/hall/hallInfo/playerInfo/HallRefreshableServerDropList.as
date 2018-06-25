package hall.hallInfo.playerInfo
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import serverlist.view.ServerDropList;
   
   public class HallRefreshableServerDropList extends ServerDropList
   {
       
      
      private var _refreshBtn:SimpleBitmapButton;
      
      public function HallRefreshableServerDropList()
      {
         super();
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         ServerManager.Instance.addEventListener("changeServer",__changeServerHandler);
      }
      
      protected function __changeServerHandler(event:Event) : void
      {
         _cb.textField.text = ServerManager.Instance.current.Name;
      }
      
      override protected function initView() : void
      {
         _cb = ComponentFactory.Instance.creat("hall.playerInfoview.refresh.serverCombo");
         addChild(_cb);
         _refreshBtn = ComponentFactory.Instance.creat("hall.server.refreshBtn");
         addChild(_refreshBtn);
         _refreshBtn.addEventListener("click",onRefreshClick);
      }
      
      protected function onRefreshClick(e:MouseEvent) : void
      {
         _refreshBtn.mouseEnabled = false;
         TweenMax.delayedCall(5,refreshBtnEnable);
         SocketManager.Instance.refresh();
      }
      
      private function refreshBtnEnable() : void
      {
         if(_refreshBtn != null)
         {
            _refreshBtn.mouseEnabled = true;
         }
      }
      
      override public function dispose() : void
      {
         TweenMax.killTweensOf(_refreshBtn);
         _refreshBtn.removeEventListener("click",onRefreshClick);
         ServerManager.Instance.removeEventListener("changeServer",__changeServerHandler);
         super.dispose();
      }
   }
}
