package consortion.view.club
{
   import com.pickgliss.ui.controls.container.VBox;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaApplyInfo;
   import consortion.event.ConsortionEvent;
   import ddt.data.ConsortiaInfo;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortionList extends VBox
   {
       
      
      private var _currentItem:ConsortionListItem;
      
      private var items:Vector.<ConsortionListItem>;
      
      private var _selfApplyList:Vector.<ConsortiaApplyInfo>;
      
      public function ConsortionList(){super();}
      
      private function __applyListChange(param1:ConsortionEvent) : void{}
      
      override protected function init() : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      public function get currentItem() : ConsortionListItem{return null;}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      public function setListData(param1:Vector.<ConsortiaInfo>) : void{}
      
      private function setStatus() : void{}
      
      override public function dispose() : void{}
   }
}
