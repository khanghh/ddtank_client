package mark.mornUI.items
{
   import morn.core.components.Clip;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class MarkArtificeItemUI extends View
   {
       
      
      public var clipBg:Clip = null;
      
      public var imgWhat:Image = null;
      
      public var lblPro:Label = null;
      
      public var maxTxt:Image = null;
      
      public function MarkArtificeItemUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
