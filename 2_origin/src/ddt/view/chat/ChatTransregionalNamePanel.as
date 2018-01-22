package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import ddt.manager.IMManager;
   import flash.events.MouseEvent;
   
   public class ChatTransregionalNamePanel extends ChatBasePanel
   {
       
      
      private var _bg:Image;
      
      private var _blackListBtn:IconButton;
      
      private var _name:String;
      
      public function ChatTransregionalNamePanel()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatComponentByStylename("chat.FriendListBgII");
         _blackListBtn = ComponentFactory.Instance.creatComponentByStylename("chat.TransregionalItemBlackList");
         addChild(_bg);
         addChild(_blackListBtn);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _blackListBtn.addEventListener("click",__onblackList);
      }
      
      public function set NickName(param1:String) : void
      {
         _name = param1;
      }
      
      public function get NickName() : String
      {
         return _name;
      }
      
      protected function __onblackList(param1:MouseEvent) : void
      {
         IMManager.Instance.addTransregionalblackList(_name);
      }
      
      public function getHight() : int
      {
         return _bg.height;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _blackListBtn.removeEventListener("click",__onblackList);
      }
   }
}
