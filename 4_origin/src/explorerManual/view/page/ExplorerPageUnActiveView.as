package explorerManual.view.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.data.ExplorerManualInfo;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class ExplorerPageUnActiveView extends ExplorerPageRightViewBase
   {
       
      
      private var _unActiveItem:Bitmap;
      
      public function ExplorerPageUnActiveView(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController)
      {
         super(param1,param2,param3);
      }
      
      override protected function initView() : void
      {
         _unActiveItem = ComponentFactory.Instance.creat("asset.explorerManual.pageRightView.unActiveItem");
         addChild(_unActiveItem);
         super.initView();
         PositionUtils.setPos(_associationBtn,"explorerManual.associationBtnPos");
      }
      
      override protected function __modelUpdateHandler(param1:Event) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_unActiveItem);
         _unActiveItem = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
