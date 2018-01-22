package mines.mornui.view
{
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.CheckBox;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class EquipmentViewUI extends View
   {
       
      
      public var box:Box = null;
      
      public var levelUpBtn:Button = null;
      
      public var allInCheckBtn:CheckBox = null;
      
      public var proLabel:Label = null;
      
      public function EquipmentViewUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
