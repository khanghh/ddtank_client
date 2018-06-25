package team.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.ComboBox;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TeamCaptainTransferViewUI extends View
   {
       
      
      public var btn_esc:Button = null;
      
      public var text2:Label = null;
      
      public var btn_cancel:Button = null;
      
      public var btn_confirm:Button = null;
      
      public var text1:Label = null;
      
      public var text3:Label = null;
      
      public var comboBox_selectName:ComboBox = null;
      
      public function TeamCaptainTransferViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TeamCaptainTransferView.xml");
      }
   }
}
