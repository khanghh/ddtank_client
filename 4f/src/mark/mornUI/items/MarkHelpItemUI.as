package mark.mornUI.items
{
   import morn.core.components.Clip;
   import morn.core.components.Label;
   import morn.core.components.TextArea;
   import morn.core.components.View;
   
   public class MarkHelpItemUI extends View
   {
       
      
      public var lablName:Label = null;
      
      public var lblDesc:TextArea = null;
      
      public var clipTypes:Clip = null;
      
      public function MarkHelpItemUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
