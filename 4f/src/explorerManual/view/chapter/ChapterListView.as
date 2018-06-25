package explorerManual.view.chapter{   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.utils.ObjectUtils;   import explorerManual.ExplorerManualController;   import explorerManual.data.ExplorerManualInfo;   import flash.events.MouseEvent;      public class ChapterListView extends SimpleTileList   {                   private var _chapterList:Array;            private var _ctrl:ExplorerManualController;            public function ChapterListView(ctrl:ExplorerManualController, columnNum:int = 2, arrangeType:int = 0) { super(null,null); }
            public function updateProgress(model:ExplorerManualInfo) : void { }
            public function set templeteData(info:Array) : void { }
            private function createItem(chapterID:int) : void { }
            private function __itemCLickHandler(evt:MouseEvent) : void { }
            override public function dispose() : void { }
   }}