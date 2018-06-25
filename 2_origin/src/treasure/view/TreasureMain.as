package treasure.view
{
   import com.pickgliss.manager.CacheSysManager;
   import ddt.manager.ChatManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   
   public class TreasureMain extends BaseStateView
   {
       
      
      private var _treasure:TreasureView;
      
      public function TreasureMain()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         CacheSysManager.lock("treasure");
         MainToolBar.Instance.hide();
         _treasure = new TreasureView();
         addChild(_treasure);
         ChatManager.Instance.state = 30;
         ChatManager.Instance.lock = ChatManager.HALL_CHAT_LOCK;
         addChild(ChatManager.Instance.view);
         super.enter(prev,data);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         CacheSysManager.unlock("treasure");
         CacheSysManager.getInstance().release("treasure");
         MainToolBar.Instance.show();
         super.leaving(next);
         dispose();
      }
      
      override public function getType() : String
      {
         return "treasure";
      }
      
      override public function getBackType() : String
      {
         return "farm";
      }
      
      override public function dispose() : void
      {
         if(_treasure)
         {
            _treasure.dispose();
            _treasure = null;
         }
      }
   }
}
