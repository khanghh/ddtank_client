package team.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.TextInput;
   import morn.core.components.View;
   
   public class TeamQuitViewUI extends View
   {
       
      
      public var btn_esc:Button = null;
      
      public var teamText3:Label = null;
      
      public var teamText2:Label = null;
      
      public var btn_cancel:Button = null;
      
      public var btn_confirm:Button = null;
      
      public var input_quit:TextInput = null;
      
      public var teamText1:Label = null;
      
      public function TeamQuitViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TeamQuitView.xml");
      }
   }
}
