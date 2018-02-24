package explorerManual.view.chapter
{
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.data.ExplorerManualInfo;
   import flash.events.MouseEvent;
   
   public class ChapterListView extends SimpleTileList
   {
       
      
      private var _chapterList:Array;
      
      private var _ctrl:ExplorerManualController;
      
      public function ChapterListView(param1:ExplorerManualController, param2:int = 2, param3:int = 0){super(null,null);}
      
      public function updateProgress(param1:ExplorerManualInfo) : void{}
      
      public function set templeteData(param1:Array) : void{}
      
      private function createItem(param1:int) : void{}
      
      private function __itemCLickHandler(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
