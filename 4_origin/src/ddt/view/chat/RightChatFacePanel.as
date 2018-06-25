package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   
   public class RightChatFacePanel extends ChatFacePanel
   {
       
      
      public function RightChatFacePanel(inGame:Boolean = false)
      {
         super(inGame);
      }
      
      override protected function createBg() : void
      {
         _bg = ComponentFactory.Instance.creat("chat.FacePanelBg2");
         _bg.x = 3;
         _bg.y = -75;
         addChild(_bg);
      }
   }
}
