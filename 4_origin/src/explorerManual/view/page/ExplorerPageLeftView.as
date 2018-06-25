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
      
      public function ExplorerPageLeftView(type:int, model:ExplorerManualInfo)
      {
         super();
         _model = model;
         _chapterID = type;
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
      
      private function __manualModelUpdateHandler(evt:Event) : void
      {
         allProData();
      }
      
      private function __activeUpdateHandler(evt:Event) : void
      {
         var result:Boolean = _model.checkPageActiveByPageID(_curPageInfo.ID);
         _activeStateTitle.text = LanguageMgr.GetTranslation("explorerManual.activeProState") + (!!result?LanguageMgr.GetTranslation("explorerManual.active"):LanguageMgr.GetTranslation("explorerManual.unActive"));
      }
      
      public function set pageInfo(info:ManualPageItemInfo) : void
      {
         clear();
         _curPageInfo = info;
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
      
      public function set curChapter(id:int) : void
      {
         _chapterID = id;
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
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         _curPageInfo = null;
         if(_curProSpri)
         {
            for(i = 0; i < _curProSpri.numChildren; )
            {
               ObjectUtils.disposeObject(_curProSpri.getChildAt(i));
               i++;
            }
            _curProSpri.removeChildren();
         }
         if(_activeProSpri)
         {
            for(j = 0; j < _activeProSpri.numChildren; )
            {
               ObjectUtils.disposeObject(_activeProSpri.getChildAt(j));
               j++;
            }
            _activeProSpri.removeChildren();
         }
         if(_totalProSpri)
         {
            for(k = 0; k < _totalProSpri.numChildren; )
            {
               ObjectUtils.disposeObject(_totalProSpri.getChildAt(k));
               k++;
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
         var curPro:* = null;
         var j:int = 0;
         var i:int = 0;
         var collectArr:Array = ManualProType.collectProArr;
         var lan:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         for(j = 0; j < collectArr.length; )
         {
            if(int(_curPageInfo[collectArr[j]]) > 0)
            {
               curPro = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProValueTxt");
               _curProSpri.addChild(curPro);
               curPro.text = lan[j] + " +" + _curPageInfo[collectArr[j]];
               curPro.x = 100 * (i % 2) + 66;
               curPro.y = 163 + int(i / 2) * 20;
               i++;
               if(i >= 4)
               {
                  return;
               }
            }
            j++;
         }
      }
      
      private function activeProData() : void
      {
         var activePro:* = null;
         var j:int = 0;
         var i:int = 0;
         var activateArr:Array = ManualProType.activateProArr;
         var lan:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         for(j = 0; j < activateArr.length; )
         {
            if(int(_curPageInfo[activateArr[j]]) > 0)
            {
               activePro = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProValueTxt");
               _activeProSpri.addChild(activePro);
               activePro.text = lan[j] + " +" + _curPageInfo[activateArr[j]];
               activePro.x = 100 * (i % 2) + 66;
               activePro.y = 163 + int(i / 2) * 20;
               i++;
               if(i >= 4)
               {
                  return;
               }
            }
            j++;
         }
      }
      
      private function allProData() : void
      {
         var totalPro:* = null;
         var j:int = 0;
         if(_totalProSpri && _totalProSpri.numChildren > 0)
         {
            ObjectUtils.disposeAllChildren(_totalProSpri);
         }
         var allProArr:Array = ManualProType.pageProArr;
         var lan:Array = LanguageMgr.GetTranslation("explorerManual.manualAllPro.name").split(",");
         for(j = 0; j < allProArr.length; )
         {
            totalPro = ComponentFactory.Instance.creatComponentByStylename("explorerManual.pageLeftView.curProValueTxt");
            _totalProSpri.addChild(totalPro);
            totalPro.text = lan[j] + " +" + _model.pageAllPro[allProArr[j]];
            totalPro.x = 100 * (j % 2) + 66;
            totalPro.y = 163 + int(j / 2) * 20;
            j++;
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
