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
      
      public function ChapterListView(ctrl:ExplorerManualController, columnNum:int = 2, arrangeType:int = 0)
      {
         _ctrl = ctrl;
         super(columnNum,arrangeType);
         _chapterList = [];
      }
      
      public function updateProgress(model:ExplorerManualInfo) : void
      {
         var item:* = null;
         var i:int = 0;
         for(i = 0; i < _chapterList.length; )
         {
            item = _chapterList[i] as ExplorerChapterItemView;
            item.updateProgress(model.chapterProgress(item.chapterID));
            i++;
         }
      }
      
      public function set templeteData(info:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < info.length; )
         {
            createItem(info[i].ID);
            i++;
         }
      }
      
      private function createItem(chapterID:int) : void
      {
         var item:ExplorerChapterItemView = new ExplorerChapterItemView(chapterID);
         addChild(item);
         item.addEventListener("click",__itemCLickHandler);
         _chapterList.push(item);
      }
      
      private function __itemCLickHandler(evt:MouseEvent) : void
      {
         var item:ExplorerChapterItemView = evt.target as ExplorerChapterItemView;
         _ctrl.switchChapterView(item.chapterID);
      }
      
      override public function dispose() : void
      {
         var item:* = null;
         while(_chapterList && _chapterList.length > 0)
         {
            item = _chapterList.shift();
            item.removeEventListener("click",__itemCLickHandler);
            ObjectUtils.disposeObject(item);
         }
         _chapterList = null;
         _ctrl = null;
      }
   }
}
