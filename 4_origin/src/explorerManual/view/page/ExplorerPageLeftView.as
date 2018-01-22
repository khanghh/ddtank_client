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
      
      public function ExplorerPageLeftView(param1:int, param2:ExplorerManualInfo)
      {
         super();
         _model = param2;
         _chapterID = param1;
         _curProSpri = new Sprite();
         addChild(_curProSpri);
         _activeProSpri = new Sprite();
         addChild(_activeProSpri);
         PositionUtils.setPos(_activeProSpri,"explorerManual.activeProSpriPos");
         _totalProSpri = new Sprite();
         addChild(_totalProSpri);
         PositionUtils.setPos(_totalProSpri,"explorerManual.totalProSpriPos");
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.titleTxt");
         _titleTxt.width = 250;
         addChild(_titleTxt);
         _titleIcon = ComponentFactory.Instance.creat("asset.explorerManual.pageLeftView.desc" + _chapterID);
         addChild(_titleIcon);
         _curProTitle = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProTitleTxt");
         addChild(_curProTitle);
         _curProTitle.text = LanguageMgr.GetTranslation("explorerManual.pagePro");
         PositionUtils.setPos(_curProTitle,"explorerManual.pageLeft.curProTitlePos");
         _activeStateTitle = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProTitleTxt");
         addChild(_activeStateTitle);
         PositionUtils.setPos(_activeStateTitle,"explorerManual.pageLeft.curunActiveProTitlePos");
         _directorySpri = new Sprite();
         addChild(_directorySpri);
         _directorySpri.visible = false;
         _directoryLeftBg = ComponentFactory.Instance.creatBitmap("asset.explorerManual.directoryleftView.bg");
         _directorySpri.addChild(_directoryLeftBg);
         _pageDescribe = ComponentFactory.Instance.creatComponentByStylename("explorerManual.leftView.pageDescribe");
         _directorySpri.addChild(_pageDescribe);
      }
      
      private function initEvent() : void
      {
         if(_model)
         {
            _model.addEventListener("pageActiveComplete",__activeUpdateHandler);
            _model.addEventListener("manualModelUpdate",__manualModelUpdateHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("pageActiveComplete",__activeUpdateHandler);
            _model.removeEventListener("manualModelUpdate",__manualModelUpdateHandler);
         }
      }
      
      private function __manualModelUpdateHandler(param1:Event) : void
      {
         allProData();
      }
      
      private function __activeUpdateHandler(param1:Event) : void
      {
         var _loc2_:Boolean = _model.checkPageActiveByPageID(_curPageInfo.ID);
         _activeStateTitle.text = LanguageMgr.GetTranslation("explorerManual.activeProState") + (!!_loc2_?LanguageMgr.GetTranslation("explorerManual.active"):LanguageMgr.GetTranslation("explorerManual.unActive"));
      }
      
      public function set pageInfo(param1:ManualPageItemInfo) : void
      {
         clear();
         _curPageInfo = param1;
         visibleView();
         if(_curPageInfo.Sort == 0)
         {
            allProData();
         }
         else
         {
            updateData();
         }
      }
      
      private function updatePageDescris() : void
      {
         _pageDescribe.text = ExplorerManualManager.instance.getChapterInfoByChapterID(_chapterID).Describe;
      }
      
      private function visibleView() : void
      {
         if(_directorySpri)
         {
            _directorySpri.visible = _curPageInfo.Sort == 0;
         }
         if(_titleTxt)
         {
            _titleTxt.visible = _curPageInfo.Sort > 0;
         }
         if(_activeStateTitle)
         {
            _activeStateTitle.visible = _curPageInfo.Sort > 0;
         }
         _curProTitle.visible = _curPageInfo.Sort > 0;
      }
      
      public function set curChapter(param1:int) : void
      {
         _chapterID = param1;
         updateTitleIcon();
         updatePageDescris();
      }
      
      private function updateTitleIcon() : void
      {
         if(_titleIcon)
         {
            ObjectUtils.disposeObject(_titleIcon);
         }
         _titleIcon = ComponentFactory.Instance.creat("asset.explorerManual.pageLeftView.desc" + _chapterID);
         addChild(_titleIcon);
      }
      
      private function clear() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _curPageInfo = null;
         if(_curProSpri)
         {
            _loc3_ = 0;
            while(_loc3_ < _curProSpri.numChildren)
            {
               ObjectUtils.disposeObject(_curProSpri.getChildAt(_loc3_));
               _loc3_++;
            }
            _curProSpri.removeChildren();
         }
         if(_activeProSpri)
         {
            _loc1_ = 0;
            while(_loc1_ < _activeProSpri.numChildren)
            {
               ObjectUtils.disposeObject(_activeProSpri.getChildAt(_loc1_));
               _loc1_++;
            }
            _activeProSpri.removeChildren();
         }
         if(_totalProSpri)
         {
            _loc2_ = 0;
            while(_loc2_ < _totalProSpri.numChildren)
            {
               ObjectUtils.disposeObject(_totalProSpri.getChildAt(_loc2_));
               _loc2_++;
            }
            _totalProSpri.removeChildren();
         }
      }
      
      private function updateData() : void
      {
         _titleTxt.text = _curPageInfo.Name;
         curProData();
         activeProData();
         allProData();
         __activeUpdateHandler(null);
      }
      
      private function curProData() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = ManualProType.collectProArr;
         var _loc3_:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(int(_curPageInfo[_loc1_[_loc4_]]) > 0)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProValueTxt");
               _curProSpri.addChild(_loc2_);
               _loc2_.text = _loc3_[_loc4_] + " +" + _curPageInfo[_loc1_[_loc4_]];
               _loc2_.x = 100 * (_loc5_ % 2) + 66;
               _loc2_.y = 163 + int(_loc5_ / 2) * 20;
               _loc5_++;
               if(_loc5_ >= 4)
               {
                  return;
               }
            }
            _loc4_++;
         }
      }
      
      private function activeProData() : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Array = ManualProType.activateProArr;
         var _loc2_:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(int(_curPageInfo[_loc1_[_loc4_]]) > 0)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProValueTxt");
               _activeProSpri.addChild(_loc3_);
               _loc3_.text = _loc2_[_loc4_] + " +" + _curPageInfo[_loc1_[_loc4_]];
               _loc3_.x = 100 * (_loc5_ % 2) + 66;
               _loc3_.y = 163 + int(_loc5_ / 2) * 20;
               _loc5_++;
               if(_loc5_ >= 4)
               {
                  return;
               }
            }
            _loc4_++;
         }
      }
      
      private function allProData() : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         if(_totalProSpri && _totalProSpri.numChildren > 0)
         {
            ObjectUtils.disposeAllChildren(_totalProSpri);
         }
         var _loc1_:Array = ManualProType.pageProArr;
         var _loc2_:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProValueTxt");
            _totalProSpri.addChild(_loc4_);
            _loc4_.text = _loc2_[_loc3_] + " +" + _model.pageAllPro[_loc1_[_loc3_]];
            _loc4_.x = 100 * (_loc3_ % 2) + 66;
            _loc4_.y = 163 + int(_loc3_ / 2) * 20;
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         clear();
         _curProSpri = null;
         _activeProSpri = null;
         _totalProSpri = null;
         if(_directorySpri)
         {
            while(_directorySpri.numChildren > 0)
            {
               ObjectUtils.disposeObject(_directorySpri.getChildAt(0));
            }
            _directorySpri.removeChildren();
            _directorySpri = null;
         }
         ObjectUtils.disposeObject(_pageDescribe);
         _pageDescribe = null;
         _curPageInfo = null;
         _model = null;
         if(_titleTxt)
         {
            ObjectUtils.disposeObject(_titleTxt);
         }
         _titleTxt = null;
         if(_titleIcon)
         {
            ObjectUtils.disposeObject(_titleIcon);
         }
         _titleIcon = null;
         if(_curProTitle)
         {
            ObjectUtils.disposeObject(_curProTitle);
         }
         _curProTitle = null;
         if(_activeStateTitle)
         {
            ObjectUtils.disposeObject(_activeStateTitle);
         }
         _activeStateTitle = null;
      }
   }
}
