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
      
      public function ExplorerPageUnActiveView(param1:int, param2:ExplorerManualInfo, param3:ExplorerManualController){super(null,null,null);}
      
      override protected function initView() : void{}
      
      override protected function __modelUpdateHandler(param1:Event) : void{}
      
      override public function dispose() : void{}
   }
}
