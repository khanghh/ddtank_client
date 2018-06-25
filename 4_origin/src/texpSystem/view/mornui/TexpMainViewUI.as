package texpSystem.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.ProgressBar;
   import morn.core.components.View;
   import morn.core.ex.NumberImageEx;
   import morn.core.ex.TabListEx;
   
   public class TexpMainViewUI extends View
   {
       
      
      public var tabViewBg:Clip = null;
      
      public var propertyImage:Clip = null;
      
      public var viewTab:TabListEx = null;
      
      public var effectLabel:Label = null;
      
      public var nextEffectLabel:Label = null;
      
      public var tabList0:TabListEx = null;
      
      public var tabList1:TabListEx = null;
      
      public var texpBtn:Button = null;
      
      public var usableNum:NumberImageEx = null;
      
      public var totalNum:NumberImageEx = null;
      
      public var levelLabel:Label = null;
      
      public var levelLabel1:Label = null;
      
      public var levelLabel0:Label = null;
      
      public var levelLabel2:Label = null;
      
      public var levelLabel3:Label = null;
      
      public var levelLabel4:Label = null;
      
      public var levelLabel5:Label = null;
      
      public var levelLabel6:Label = null;
      
      public var texpAllTips:Image = null;
      
      public var buyTexpBtn1:Button = null;
      
      public var buyTexpBtn0:Button = null;
      
      public var progress:ProgressBar = null;
      
      public var progressLabel:Label = null;
      
      public function TexpMainViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TexpMainView.xml");
      }
   }
}