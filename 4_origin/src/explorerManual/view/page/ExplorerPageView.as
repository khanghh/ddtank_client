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
      
      public function ExplorerPageView(param1:ExplorerManualInfo, param2:ExplorerManualController)
      {
         super();
         _model = param1;
         _ctrl = param2;
         initEvent();
      }
      
      public function get curPageIndex() : int
      {
         return _curPageIndex;
      }
      
      public function set curPageIndex(param1:int) : void
      {
         _curPageIndex = param1;
      }
      
      private function initEvent() : void
      {
         _model.addEventListener("updatePageView",__updatePageViewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("updatePageView",__updatePageViewHandler);
         }
         if(_upPageBtn)
         {
            _upPageBtn.removeEventListener("click",__upPageBtnHandler);
         }
         if(_downPageBtn)
         {
            _downPageBtn.removeEventListener("click",__downPageBtnHandler);
         }
         if(_pageDirectoryView)
         {
            _pageDirectoryView.removeEventListener("directionryTurn",directionryClick_Handler);
         }
      }
      
      private function __updatePageViewHandler(param1:Event) : void
      {
         initView();
         initPage();
      }
      
      public function get curPage() : ManualPageItemInfo
      {
         return _curPage;
      }
      
      public function set curPage(param1:ManualPageItemInfo) : void
      {
         _curPage = param1;
         updateView();
         updateBtn();
      }
      
      private function updateBtn() : void
      {
         var _loc1_:int = _curAllPage.length;
         _downPageBtn.enable = true;
         _upPageBtn.enable = true;
         if(_curPage.Sort == 0)
         {
            _downPageBtn.enable = true;
            _upPageBtn.enable = false;
         }
         else if(_curPage.Sort == _loc1_ - 1)
         {
            _downPageBtn.enable = false;
            _upPageBtn.enable = true;
         }
      }
      
      private function updateView() : void
      {
         _leftView.pageInfo = curPage;
         _leftView.curChapter = _curChapter;
         if(_curPage.Sort == 0)
         {
            _pageDirectoryView.visible = true;
            _rightView.visible = false;
            _unActiveView.visible = false;
            _pageDirectoryView.initDirectory(_curAllPage);
         }
         else
         {
            _pageDirectoryView.visible = false;
            if(_model.debrisInfo.getHaveDebrisByPageID(curPage.ID).length > 0)
            {
               _rightView.visible = true;
               _unActiveView.visible = false;
               _rightView.pageInfo = curPage;
            }
            else
            {
               _rightView.visible = false;
               _unActiveView.visible = true;
               _unActiveView.pageInfo = curPage;
            }
         }
      }
      
      public function set chapter(param1:int) : void
      {
         _curChapter = param1;
      }
      
      private function initView() : void
      {
         if(_leftView)
         {
            return;
         }
         _bg = ComponentFactory.Instance.creat("asset.explorerManual.pageView.bg");
         addChild(_bg);
         _leftView = new ExplorerPageLeftView(_curChapter,_model);
         addChild(_leftView);
         _pageDirectoryView = new ExplorerPageDirectoryView(_curChapter,_model,_ctrl);
         addChild(_pageDirectoryView);
         _pageDirectoryView.addEventListener("directionryTurn",directionryClick_Handler);
         _pageDirectoryView.visible = false;
         _rightView = new ExplorerPageRightView(_curChapter,_model,_ctrl);
         addChild(_rightView);
         _rightView.visible = false;
         _unActiveView = new ExplorerPageUnActiveView(_curChapter,_model,_ctrl);
         addChild(_unActiveView);
         _unActiveView.visible = false;
         PositionUtils.setPos(_unActiveView,"explorerManual.unActiveViewPos");
         _upPageBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualpageView.upPageBtn");
         addChild(_upPageBtn);
         _upPageBtn.enable = false;
         _upPageBtn.addEventListener("click",__upPageBtnHandler);
         _downPageBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.manualpageView.downPageBtn");
         addChild(_downPageBtn);
         _downPageBtn.enable = false;
         _downPageBtn.addEventListener("click",__downPageBtnHandler);
      }
      
      private function directionryClick_Handler(param1:CEvent) : void
      {
         var _loc2_:int = param1.data;
         curPageIndex = _loc2_ - 1;
         turnPage(2);
      }
      
      private function __upPageBtnHandler(param1:MouseEvent) : void
      {
         turnPage(1);
      }
      
      private function turnPage(param1:int) : void
      {
         type = param1;
         if(_curAllPage.length <= 0)
         {
            return;
         }
         if(_ctrl && _ctrl.puzzleState)
         {
            showPuzzleAffim(type == 1?__upPageBtnHandler:__downPageBtnHandler);
            return;
         }
         if(!checkCanClick())
         {
            return;
         }
         this.dispatchEvent(new CEvent("pageChange",type));
         _timer = setTimeout(function():*
         {
            var /*UnknownSlot*/:* = function():void
            {
               clearInterval(_timer);
               if(_curAllPage == null)
               {
                  return;
               }
               if(type == 1)
               {
                  if(curPageIndex == 0)
                  {
                     return;
                  }
                  curPageIndex = Number(curPageIndex) - 1;
               }
               else if(type == 2)
               {
                  if(curPageIndex == _curAllPage.length - 1)
                  {
                     return;
                  }
                  curPageIndex = Number(curPageIndex) + 1;
               }
               curPage = _curAllPage[curPageIndex];
            };
            return function():void
            {
               clearInterval(_timer);
               if(_curAllPage == null)
               {
                  return;
               }
               if(type == 1)
               {
                  if(curPageIndex == 0)
                  {
                     return;
                  }
                  curPageIndex = Number(curPageIndex) - 1;
               }
               else if(type == 2)
               {
                  if(curPageIndex == _curAllPage.length - 1)
                  {
                     return;
                  }
                  curPageIndex = Number(curPageIndex) + 1;
               }
               curPage = _curAllPage[curPageIndex];
            };
         }(),800);
      }
      
      private function __downPageBtnHandler(param1:MouseEvent) : void
      {
         turnPage(2);
      }
      
      private function checkCanClick() : Boolean
      {
         var _loc1_:Number = new Date().time;
         if(_loc1_ - _clickNum < 2000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"),0,true);
            return false;
         }
         _clickNum = _loc1_;
         return true;
      }
      
      private function showPuzzleAffim(param1:Function) : void
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
                  _ctrl.puzzleState = false;
                  if(callfun)
                  {
                     callfun(null);
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
                  _ctrl.puzzleState = false;
                  if(callfun)
                  {
                     callfun(null);
                  }
               }
            };
         }());
      }
      
      private function initPage() : void
      {
         _curAllPage = [];
         curPageIndex = 0;
         _curAllPage = ExplorerManualManager.instance.getAllPageByChapterID(_curChapter);
         _curAllPage.sortOn("Sort");
         _curAllPage.unshift(new ManualPageItemInfo());
         if(_curAllPage.length > 0)
         {
            curPage = _curAllPage[curPageIndex];
         }
      }
      
      private function clearView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_upPageBtn);
         _upPageBtn = null;
         ObjectUtils.disposeObject(_downPageBtn);
         _downPageBtn = null;
         ObjectUtils.disposeObject(_unActiveView);
         _unActiveView = null;
         ObjectUtils.disposeObject(_confirmFrame);
         _confirmFrame = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_pageDirectoryView);
         _pageDirectoryView = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _curPageIndex = 0;
         if(_curAllPage)
         {
            _curAllPage = null;
         }
         _curPage = null;
         _model = null;
         _ctrl = null;
         clearView();
      }
   }
}
