package mark.mornUI.items
{
   import morn.core.components.Box;
   import morn.core.components.Clip;
   import morn.core.components.Container;
   import morn.core.components.Image;
   import morn.core.components.View;
   
   public class MarkBagItemUI extends View
   {
       
      
      public var itemBox:Box = null;
      
      public var conStars1:Container = null;
      
      public var clipStar11:Clip = null;
      
      public var conStars2:Container = null;
      
      public var clipStar21:Clip = null;
      
      public var clipStar22:Clip = null;
      
      public var conStars3:Container = null;
      
      public var clipStar31:Clip = null;
      
      public var clipStar32:Clip = null;
      
      public var clipStar33:Clip = null;
      
      public var conStars4:Container = null;
      
      public var clipStar41:Clip = null;
      
      public var clipStar42:Clip = null;
      
      public var clipStar43:Clip = null;
      
      public var clipStar44:Clip = null;
      
      public var conStars5:Container = null;
      
      public var clipStar51:Clip = null;
      
      public var clipStar52:Clip = null;
      
      public var clipStar53:Clip = null;
      
      public var clipStar54:Clip = null;
      
      public var clipStar55:Clip = null;
      
      public var imgStatus:Image = null;
      
      public function MarkBagItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("items/MarkBagItem.xml");
      }
   }
}
