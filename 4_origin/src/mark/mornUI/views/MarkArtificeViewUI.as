package mark.mornUI.views
{
   import mark.items.MarkArtificeItem;
   import mark.items.MarkPropItem;
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.Container;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   
   public class MarkArtificeViewUI extends View
   {
       
      
      public var conItemLeft:Container = null;
      
      public var clipLeftStar1:Clip = null;
      
      public var clipLeftStar2:Clip = null;
      
      public var clipLeftStar3:Clip = null;
      
      public var clipLeftStar4:Clip = null;
      
      public var clipLeftStar5:Clip = null;
      
      public var lblLeftAttachPro:Label = null;
      
      public var listTransfer:List = null;
      
      public var lblMarkCost:Label = null;
      
      public var icon14:Image = null;
      
      public var lblStoneTotal:Label = null;
      
      public var lblMarkMoneyTotal:Label = null;
      
      public var btnTransfer:Button = null;
      
      public var lblOtherCost:Label = null;
      
      public var icon15:Image = null;
      
      public var listProps:List = null;
      
      public var btnSubmit:Button = null;
      
      public var btnCancel:Button = null;
      
      public var conLight:Container = null;
      
      public var label1:Label = null;
      
      public var imgArrow:Image = null;
      
      public function MarkArtificeViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["mark.items.MarkArtificeItem"] = MarkArtificeItem;
         viewClassMap["mark.items.MarkPropItem"] = MarkPropItem;
         super.createChildren();
         loadUI("views/MarkArtificeView.xml");
      }
   }
}
