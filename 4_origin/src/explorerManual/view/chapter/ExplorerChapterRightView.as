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
      
      public function ExplorerChapterRightView(param1:ExplorerManualInfo, param2:ExplorerManualController)
      {
         super();
         _model = param1;
         _ctrl = param2;
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         _chapterList = new ChapterListView(_ctrl);
         _chapterList.hSpace = 56;
         _chapterList.vSpace = 32;
         PositionUtils.setPos(_chapterList,"explorerManual.chapterListPos");
         addChild(_chapterList);
      }
      
      private function initData() : void
      {
         var _loc1_:Array = ExplorerManualManager.instance.getChaptersInfo();
         if(_loc1_ != null)
         {
            _loc1_.sortOn("Sort");
            _chapterList.templeteData = _loc1_;
         }
      }
      
      private function initEvent() : void
      {
         if(_model)
         {
            _model.addEventListener("manualModelUpdate",__modelUpdateHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("manualModelUpdate",__modelUpdateHandler);
         }
      }
      
      private function __modelUpdateHandler(param1:Event) : void
      {
         _chapterList.updateProgress(_model);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_chapterList)
         {
            ObjectUtils.disposeObject(_chapterList);
         }
         _chapterList = null;
         _model = null;
         _ctrl = null;
      }
   }
}
