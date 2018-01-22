package mark.views
{
   import com.pickgliss.utils.ObjectUtils;
   import mark.MarkMgr;
   import mark.data.MarkBagData;
   import mark.event.MarkEvent;
   import mark.items.MarkSuitItem;
   import mark.mornUI.views.MarkRightViewUI;
   import morn.core.handlers.Handler;
   
   public class MarkRightView extends MarkRightViewUI
   {
       
      
      private var _bag:MarkBagView = null;
      
      private var _bagId:int = -1;
      
      public function MarkRightView(){super();}
      
      override protected function initialize() : void{}
      
      private function render(param1:MarkSuitItem, param2:int) : void{}
      
      private function select(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function updateStatus() : void{}
      
      private function updateChips(param1:MarkEvent = null) : void{}
      
      private function disposeView(param1:MarkEvent) : void{}
      
      override public function dispose() : void{}
   }
}
