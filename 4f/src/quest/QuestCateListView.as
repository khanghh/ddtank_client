package quest
{
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuestCateListView extends ScrollPanel
   {
      
      public static var MAX_LIST_LENGTH:int = 4;
       
      
      private var _content:VBox;
      
      private var _stripArr:Array;
      
      private var _currentStrip:TaskPannelStripView;
      
      public function QuestCateListView(){super();}
      
      private function initView() : void{}
      
      public function set dataProvider(param1:Array) : void{}
      
      public function active() : void{}
      
      private function gotoStrip(param1:TaskPannelStripView) : void{}
      
      private function __onStripClicked(param1:MouseEvent) : void{}
      
      private function clear() : void{}
      
      override public function dispose() : void{}
   }
}
