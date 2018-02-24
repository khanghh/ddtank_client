package explorerManual.view.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.ManualProType;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ExplorerPageLeftView extends Sprite implements Disposeable
   {
       
      
      private var _titleIcon:Bitmap;
      
      private var _chapterID:int;
      
      private var _curProTitle:FilterFrameText;
      
      private var _titleTxt:FilterFrameText;
      
      private var _curPageInfo:ManualPageItemInfo;
      
      private var _activeStateTitle:FilterFrameText;
      
      private var _model:ExplorerManualInfo;
      
      private var _curProSpri:Sprite;
      
      private var _activeProSpri:Sprite;
      
      private var _totalProSpri:Sprite;
      
      private var _directorySpri:Sprite;
      
      private var _directoryLeftBg:Bitmap;
      
      private var _pageDescribe:FilterFrameText;
      
      public function ExplorerPageLeftView(param1:int, param2:ExplorerManualInfo){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __manualModelUpdateHandler(param1:Event) : void{}
      
      private function __activeUpdateHandler(param1:Event) : void{}
      
      public function set pageInfo(param1:ManualPageItemInfo) : void{}
      
      private function updatePageDescris() : void{}
      
      private function visibleView() : void{}
      
      public function set curChapter(param1:int) : void{}
      
      private function updateTitleIcon() : void{}
      
      private function clear() : void{}
      
      private function updateData() : void{}
      
      private function curProData() : void{}
      
      private function activeProData() : void{}
      
      private function allProData() : void{}
      
      public function dispose() : void{}
   }
}
