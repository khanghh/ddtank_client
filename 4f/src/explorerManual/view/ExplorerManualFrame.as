package explorerManual.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import explorerManual.ExplorerManualController;
   import explorerManual.data.ExplorerManualInfo;
   import explorerManual.view.chapter.ExplorerChapterView;
   import explorerManual.view.page.ExplorerPageView;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ExplorerManualFrame extends Frame
   {
       
      
      private var _closeBtn:BaseButton;
      
      private var _chapterView:ExplorerChapterView;
      
      private var _pageView:ExplorerPageView = null;
      
      private var _leftMenu:ManualLeftMenu;
      
      private var _rightMenu:ManualRightMenu;
      
      private var _manualModel:ExplorerManualInfo = null;
      
      private var _control:ExplorerManualController;
      
      private var _helpBtn:BaseButton;
      
      private var _mainMovie:MovieClip;
      
      private var _curSelectChapter:int;
      
      private var _confirmFrame:BaseAlerFrame;
      
      public function ExplorerManualFrame(param1:ExplorerManualInfo, param2:ExplorerManualController){super();}
      
      override protected function init() : void{}
      
      private function subtractAlpha() : void{}
      
      private function addAlpha() : void{}
      
      private function endMovie() : void{}
      
      private function __pageChangleHandler(param1:CEvent) : void{}
      
      private function __leftMenuClickHandler(param1:MouseEvent) : void{}
      
      private function __rightMenuClickHandler(param1:CEvent) : void{}
      
      public function openPageView(param1:int) : void{}
      
      private function openChapterView() : void{}
      
      private function showPuzzleAffim(param1:Object) : void{}
      
      private function __closeBtnClickHandler(param1:MouseEvent) : void{}
      
      public function show() : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      override protected function addChildren() : void{}
      
      override public function dispose() : void{}
   }
}
