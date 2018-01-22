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
      
      public function ExplorerManualFrame(param1:ExplorerManualInfo, param2:ExplorerManualController)
      {
         _manualModel = param1;
         _control = param2;
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"explorerManual.helpbtn",null,LanguageMgr.GetTranslation("explorerManual.helpDis"),"asset.explorerManual.helpDis",404,490);
         _chapterView = new ExplorerChapterView(_manualModel,_control);
         PositionUtils.setPos(_chapterView,"explorerManual.chapterViewPos");
         _pageView = new ExplorerPageView(_manualModel,_control);
         PositionUtils.setPos(_pageView,"explorerManual.pageViewPos");
         _pageView.visible = false;
         _pageView.addEventListener("pageChange",__pageChangleHandler);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.frame.closeBtn");
         _closeBtn.addEventListener("click",__closeBtnClickHandler);
         _leftMenu = new ManualLeftMenu(_manualModel);
         PositionUtils.setPos(_leftMenu,"explorerManual.manualLeftMenuPos");
         _leftMenu.addEventListener("click",__leftMenuClickHandler);
         _rightMenu = new ManualRightMenu();
         PositionUtils.setPos(_rightMenu,"explorerManual.manualRightMenuPos");
         _rightMenu.addEventListener("itemClick",__rightMenuClickHandler);
         _rightMenu.selectItem = 0;
         _mainMovie = ComponentFactory.Instance.creat("explorerManual.pageChange.animation");
         _mainMovie.addFrameScript(5,subtractAlpha);
         _mainMovie.addFrameScript(10,subtractAlpha);
         _mainMovie.addFrameScript(15,subtractAlpha);
         _mainMovie.addFrameScript(20,subtractAlpha);
         _mainMovie.addFrameScript(27,addAlpha);
         _mainMovie.addFrameScript(33,addAlpha);
         _mainMovie.addFrameScript(36,addAlpha);
         _mainMovie.addFrameScript(41,endMovie);
         _mainMovie.stop();
      }
      
      private function subtractAlpha() : void
      {
         _pageView.alpha = _pageView.alpha - Math.max(0.3,0);
         if(_pageView.alpha < 0)
         {
            _pageView.alpha = 0;
         }
      }
      
      private function addAlpha() : void
      {
         _pageView.alpha = _pageView.alpha + Math.min(0.3,1);
      }
      
      private function endMovie() : void
      {
         _pageView.alpha = 1;
         _mainMovie.stop();
      }
      
      private function __pageChangleHandler(param1:CEvent) : void
      {
         var _loc2_:int = param1.data;
         if(_loc2_ == 1)
         {
            _mainMovie.scaleX = -1;
            PositionUtils.setPos(_mainMovie,"explorerManual.pageChange.mainMoviePos1");
         }
         else
         {
            _mainMovie.scaleX = 1;
            PositionUtils.setPos(_mainMovie,"explorerManual.pageChange.mainMoviePos");
         }
         _mainMovie.play();
      }
      
      private function __leftMenuClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openChapterView();
      }
      
      private function __rightMenuClickHandler(param1:CEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = param1.data;
         if(_loc2_ == 0)
         {
            openChapterView();
         }
         else
         {
            openPageView(_loc2_);
         }
      }
      
      public function openPageView(param1:int) : void
      {
         var _loc2_:* = null;
         if(_curSelectChapter == param1)
         {
            return;
         }
         if(_control && _control.puzzleState)
         {
            _loc2_ = {};
            _loc2_.fun = openPageView;
            _loc2_.params = param1;
            showPuzzleAffim(_loc2_);
            return;
         }
         _curSelectChapter = param1;
         _rightMenu.selectItem = param1;
         _chapterView.visible = false;
         if(_pageView == null)
         {
            _pageView = new ExplorerPageView(_manualModel,_control);
         }
         _pageView.chapter = param1;
         _pageView.visible = true;
         if(_control)
         {
            _control.requestManualPageData(param1);
         }
      }
      
      private function openChapterView() : void
      {
         var _loc1_:* = null;
         if(_curSelectChapter == 0)
         {
            return;
         }
         if(_control && _control.puzzleState)
         {
            _loc1_ = {};
            _loc1_.fun = openChapterView;
            _loc1_.params = "not";
            showPuzzleAffim(_loc1_);
            return;
         }
         _curSelectChapter = 0;
         _rightMenu.selectItem = 0;
         if(_chapterView == null)
         {
            _chapterView = new ExplorerChapterView(_manualModel,_control);
         }
         if(_pageView)
         {
            _pageView.visible = false;
         }
         _chapterView.visible = true;
      }
      
      private function showPuzzleAffim(param1:Object) : void
      {
         callfun = param1;
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("explorerManual.checkPuzzleState.prompt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",function():*
         {
            var /*UnknownSlot*/:* = function(param1:FrameEvent):void
            {
               SoundManager.instance.play("008");
               _confirmFrame.removeEventListener("response",__confirmBuy);
               _confirmFrame = null;
               if(param1.responseCode == 3 || param1.responseCode == 2)
               {
                  _control.puzzleState = false;
                  if(callfun)
                  {
                     if(callfun.params == "not")
                     {
                        callfun.fun.apply();
                     }
                     else
                     {
                        callfun.fun(callfun.params);
                     }
                  }
               }
            };
            return function(param1:FrameEvent):void
            {
               SoundManager.instance.play("008");
               _confirmFrame.removeEventListener("response",__confirmBuy);
               _confirmFrame = null;
               if(param1.responseCode == 3 || param1.responseCode == 2)
               {
                  _control.puzzleState = false;
                  if(callfun)
                  {
                     if(callfun.params == "not")
                     {
                        callfun.fun.apply();
                     }
                     else
                     {
                        callfun.fun(callfun.params);
                     }
                  }
               }
            };
         }());
      }
      
      private function __closeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(_control && _control.puzzleState)
         {
            _loc2_ = {};
            _loc2_.fun = __closeBtnClickHandler;
            _loc2_.params = null;
            showPuzzleAffim(_loc2_);
            return;
         }
         dispose();
      }
      
      public function show() : void
      {
         addEventListener("response",_response);
         LayerManager.Instance.addToLayer(this,3,false,1);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            __closeBtnClickHandler(null);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_closeBtn)
         {
            addToContent(_closeBtn);
         }
         if(_chapterView)
         {
            addToContent(_chapterView);
         }
         if(_leftMenu)
         {
            addToContent(_leftMenu);
         }
         if(_rightMenu)
         {
            addToContent(_rightMenu);
         }
         if(_pageView)
         {
            addToContent(_pageView);
         }
         if(_helpBtn)
         {
            addToContent(_helpBtn);
         }
         if(_mainMovie)
         {
            addToContent(_mainMovie);
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_response);
         _manualModel = null;
         _control = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_chapterView);
         _chapterView = null;
         if(_pageView)
         {
            _pageView.removeEventListener("pageChange",__pageChangleHandler);
         }
         ObjectUtils.disposeObject(_pageView);
         _pageView = null;
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeBtnClickHandler);
            ObjectUtils.disposeObject(_closeBtn);
         }
         _closeBtn = null;
         if(_leftMenu)
         {
            _leftMenu.removeEventListener("click",__leftMenuClickHandler);
            ObjectUtils.disposeObject(_leftMenu);
         }
         _leftMenu = null;
         if(_mainMovie)
         {
            _mainMovie.stop();
            ObjectUtils.disposeObject(_mainMovie);
            _mainMovie = null;
         }
         if(_rightMenu)
         {
            _rightMenu.removeEventListener("click",__rightMenuClickHandler);
            ObjectUtils.disposeObject(_rightMenu);
         }
         _rightMenu = null;
         ObjectUtils.disposeObject(_confirmFrame);
         _confirmFrame = null;
         super.dispose();
      }
   }
}
