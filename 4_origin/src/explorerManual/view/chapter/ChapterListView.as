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
      
      public function ChapterListView(param1:ExplorerManualController, param2:int = 2, param3:int = 0)
      {
         _ctrl = param1;
         super(param2,param3);
         _chapterList = [];
      }
      
      public function updateProgress(param1:ExplorerManualInfo) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _chapterList.length)
         {
            _loc2_ = _chapterList[_loc3_] as ExplorerChapterItemView;
            _loc2_.updateProgress(param1.chapterProgress(_loc2_.chapterID));
            _loc3_++;
         }
      }
      
      public function set templeteData(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            createItem(param1[_loc2_].ID);
            _loc2_++;
         }
      }
      
      private function createItem(param1:int) : void
      {
         var _loc2_:ExplorerChapterItemView = new ExplorerChapterItemView(param1);
         addChild(_loc2_);
         _loc2_.addEventListener("click",__itemCLickHandler);
         _chapterList.push(_loc2_);
      }
      
      private function __itemCLickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ExplorerChapterItemView = param1.target as ExplorerChapterItemView;
         _ctrl.switchChapterView(_loc2_.chapterID);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         while(_chapterList && _chapterList.length > 0)
         {
            _loc1_ = _chapterList.shift();
            _loc1_.removeEventListener("click",__itemCLickHandler);
            ObjectUtils.disposeObject(_loc1_);
         }
         _chapterList = null;
         _ctrl = null;
      }
   }
}
