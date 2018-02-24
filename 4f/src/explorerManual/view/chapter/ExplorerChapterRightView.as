package explorerManual.view.chapter
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.ExplorerManualInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ExplorerChapterRightView extends Sprite implements Disposeable
   {
       
      
      private var _chapterList:ChapterListView;
      
      private var _model:ExplorerManualInfo;
      
      private var _ctrl:ExplorerManualController;
      
      public function ExplorerChapterRightView(param1:ExplorerManualInfo, param2:ExplorerManualController){super();}
      
      private function initView() : void{}
      
      private function initData() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __modelUpdateHandler(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
