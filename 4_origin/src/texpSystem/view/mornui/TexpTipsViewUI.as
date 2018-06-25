package texpSystem.view.mornui
{
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TexpTipsViewUI extends View
   {
       
      
      public var imgBg:Image = null;
      
      public var texpLabel0:Label = null;
      
      public var texpLabel1:Label = null;
      
      public var texpLabel2:Label = null;
      
      public var texpLabel3:Label = null;
      
      public var texpLabel4:Label = null;
      
      public var texpLabel5:Label = null;
      
      public var texpLabel6:Label = null;
      
      public var texpLabel7:Label = null;
      
      public var texpLabel8:Label = null;
      
      public var texpLabel9:Label = null;
      
      public var texpLabel10:Label = null;
      
      public var texpLabel11:Label = null;
      
      public var texpLabel12:Label = null;
      
      public var texpLabel13:Label = null;
      
      public function TexpTipsViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TexpTipsView.xml");
      }
   }
}
