package explorerManual.view.page
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   
   public class ExplorerPageView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _leftView:ExplorerPageLeftView;
      
      private var _rightView:ExplorerPageRightViewBase;
      
      private var _unActiveView:ExplorerPageRightViewBase;
      
      private var _pageDirectoryView:ExplorerPageDirectoryView;
      
      private var _curChapter:int;
      
      private var _curAllPage:Array;
      
      private var _curPageIndex:int;
      
      private var _curPage:ManualPageItemInfo;
      
      private var _model:ExplorerManualInfo;
      
      private var _ctrl:ExplorerManualController;
      
      private var _upPageBtn:BaseButton;
      
      private var _downPageBtn:BaseButton;
      
      private var _timer:int;
      
      private var _clickNum:Number = 0;
      
      private var _confirmFrame:BaseAlerFrame;
      
      public function ExplorerPageView(param1:ExplorerManualInfo, param2:ExplorerManualController){super();}
      
      public function get curPageIndex() : int{return 0;}
      
      public function set curPageIndex(param1:int) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __updatePageViewHandler(param1:Event) : void{}
      
      public function get curPage() : ManualPageItemInfo{return null;}
      
      public function set curPage(param1:ManualPageItemInfo) : void{}
      
      private function updateBtn() : void{}
      
      private function updateView() : void{}
      
      public function set chapter(param1:int) : void{}
      
      private function initView() : void{}
      
      private function directionryClick_Handler(param1:CEvent) : void{}
      
      private function __upPageBtnHandler(param1:MouseEvent) : void{}
      
      private function turnPage(param1:int) : void{}
      
      private function __downPageBtnHandler(param1:MouseEvent) : void{}
      
      private function checkCanClick() : Boolean{return false;}
      
      private function showPuzzleAffim(param1:Function) : void{}
      
      private function initPage() : void{}
      
      private function clearView() : void{}
      
      public function dispose() : void{}
   }
}
