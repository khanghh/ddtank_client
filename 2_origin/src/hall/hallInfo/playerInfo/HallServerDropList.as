package hall.hallInfo.playerInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.ServerManager;
   import flash.events.Event;
   import serverlist.view.ServerDropList;
   
   public class HallServerDropList extends ServerDropList
   {
       
      
      public function HallServerDropList()
      {
         super();
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         ServerManager.Instance.addEventListener("changeServer",__changeServerHandler);
      }
      
      protected function __changeServerHandler(param1:Event) : void
      {
         _cb.textField.text = ServerManager.Instance.current.Name;
      }
      
      override protected function initView() : void
      {
         _cb = ComponentFactory.Instance.creat("hall.playerInfoview.serverCombo");
         addChild(_cb);
      }
      
      override public function dispose() : void
      {
         ServerManager.Instance.removeEventListener("changeServer",__changeServerHandler);
         super.dispose();
      }
   }
}
