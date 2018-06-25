package times
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.PathManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   import shop.manager.ShopBuyManager;
   import times.data.TimesAnalyzer;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   import times.data.TimesStatistics;
   import times.view.TimesView;
   
   public class TimesManager
   {
      
      private static var _instance:TimesManager;
       
      
      private var _timesBtn:MovieClip;
      
      private var _timesView:TimesView;
      
      private var _isReturn:Boolean;
      
      private var _isUIComplete:Boolean;
      
      private var _isUpdateResComplete:Boolean;
      
      private var _isThumbnailComplete:Boolean;
      
      private var _controller:TimesController;
      
      private var _statistics:TimesStatistics;
      
      private var _hallView:HallStateView;
      
      private var _isQQshow:Boolean = false;
      
      private var _page:int = 0;
      
      private var _updateContentList:Array;
      
      private var _isNeedOpenUpdateFrame:Boolean = false;
      
      public var isShowActivityAdvView:Boolean = false;
      
      public function TimesManager()
      {
         super();
      }
      
      public static function get Instance() : TimesManager
      {
         if(!_instance)
         {
            _instance = new TimesManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         createTimesInfo();
         _controller = TimesController.Instance;
         _controller.model.webPath = PathManager.SITE_WEEKLY + "weekly/";
         _controller.addEventListener("thumbnailLoadComplete",__onThumbnailComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(219),__canGenerateEgg);
         _statistics = new TimesStatistics();
      }
      
      public function showButton(hallView:HallStateView) : void
      {
         _hallView = hallView;
         if(_isThumbnailComplete)
         {
            if(_timesBtn && _timesBtn.parent || !_hallView)
            {
               return;
            }
            _timesBtn = ComponentFactory.Instance.creat("asset.times.TimesBtnMc");
            _timesBtn.buttonMode = true;
            _timesBtn.addEventListener("click",__onBtnClick);
            _hallView.addChild(_timesBtn);
         }
      }
      
      private function __onThumbnailComplete(event:TimesEvent) : void
      {
         _isThumbnailComplete = true;
         if(StateManager.currentStateType == "main")
         {
            showButton(_hallView);
         }
      }
      
      public function hideButton() : void
      {
         if(_timesBtn)
         {
            if(_timesBtn.parent)
            {
               _timesBtn.parent.removeChild(_timesBtn);
            }
            _timesBtn.removeEventListener("click",__onBtnClick);
            _timesBtn = null;
         }
      }
      
      public function show() : void
      {
         if(!_isReturn || !_isUIComplete || !_isUpdateResComplete)
         {
            return;
         }
         SoundManager.instance.playMusic("140");
         TimesController.Instance.updateContenList = _updateContentList;
         TimesController.Instance.isShowUpdateView = isShowUpdateView;
         _timesView = new TimesView();
         _controller.addEventListener("closeView",__timesEventHandler);
         _controller.addEventListener("playSound",__timesEventHandler);
         _controller.addEventListener("gotEgg",__timesEventHandler);
         _controller.addEventListener("purchase",__timesEventHandler);
         _controller.initEvent();
         StageReferance.stage.addEventListener("keyDown",__keyBoardEventHandler);
         LayerManager.Instance.addToLayer(_timesView,3,true,1);
         if(_isQQshow)
         {
            _isQQshow = false;
            _QQshowComplete();
         }
      }
      
      public function showByQQtips(page:int) : void
      {
         _isQQshow = true;
         _page = page;
         __onBtnClick(null);
      }
      
      private function _QQshowComplete() : void
      {
         var i:int = 0;
         var j:int = 0;
         var sum:int = 0;
         var contentArr:Array = _controller.model.contentInfos;
         var tempInfo:TimesPicInfo = new TimesPicInfo();
         while(i < contentArr.length)
         {
            for(j = 0; j < contentArr[i].length; )
            {
               sum++;
               if(sum == _page)
               {
                  tempInfo.targetCategory = i;
                  tempInfo.targetPage = j;
               }
               j++;
            }
            i++;
         }
         _controller.dispatchEvent(new TimesEvent("gotoContent",tempInfo));
      }
      
      private function __keyBoardEventHandler(event:KeyboardEvent) : void
      {
         if(event.keyCode == 27)
         {
            SoundManager.instance.play("008");
            hide();
         }
      }
      
      public function hide() : void
      {
         if(ShopBuyManager.Instance.isShow)
         {
            ShopBuyManager.Instance.dispose();
            return;
         }
         StageReferance.stage.removeEventListener("keyDown",__keyBoardEventHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(219),__canGenerateEgg);
         if(!StartupResourceLoader.firstEnterHall)
         {
            SoundManager.instance.playMusic("062");
         }
         sendStatistics();
         DisplayUtils.removeDisplay(_timesView);
         _controller.clearExtraObjects();
         _controller.removeEvent();
         ObjectUtils.disposeObject(_timesView);
         _timesView = null;
      }
      
      public function get statistics() : TimesStatistics
      {
         return _statistics;
      }
      
      private function sendStatistics() : void
      {
         var sum:int = 0;
         var i:int = 0;
         var stayTime:Vector.<int> = _statistics.stayTime;
         for(i = 0; i < stayTime.length; )
         {
            sum = sum + stayTime[i];
            i++;
         }
         if(sum == 0)
         {
            _statistics.stopTick();
            return;
         }
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["Versions"] = _controller.model.edition;
         args["Forum1"] = stayTime[0];
         args["Forum2"] = stayTime[1];
         args["Forum3"] = stayTime[2];
         args["Forum4"] = stayTime[3];
         args["Forum5"] = stayTime[4];
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CommitWeeklyUserRecord.ashx"),6,args);
         LoadResourceManager.Instance.startLoad(loader);
         _statistics.stopTick();
      }
      
      private function __timesEventHandler(event:TimesEvent) : void
      {
         var _loc2_:* = event.type;
         if("closeView" !== _loc2_)
         {
            if("playSound" !== _loc2_)
            {
               if("gotEgg" !== _loc2_)
               {
                  if("purchase" === _loc2_)
                  {
                     SoundManager.instance.play("008");
                     ShopBuyManager.Instance.buy(int(event.info.templateID));
                  }
               }
               else
               {
                  SoundManager.instance.play("008");
                  SocketManager.Instance.out.sendDailyAward(2);
                  _controller.model.isShowEgg = !_controller.model.isShowEgg;
               }
            }
            else
            {
               SoundManager.instance.play("008");
            }
         }
         else
         {
            SoundManager.instance.play("008");
            hide();
         }
      }
      
      private function __onBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         ComponentSetting.SEND_USELOG_ID(24);
         show();
         if(!_isReturn)
         {
            SocketManager.Instance.out.sendWeeklyClick();
         }
         if(!_isUIComplete || !_isUpdateResComplete)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onSmallLoadingClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onUIComplete);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__onUIProgress);
            UIModuleLoader.Instance.addUIModuleImp("timesupdate");
            UIModuleLoader.Instance.addUIModuleImp("times");
         }
      }
      
      private function __canGenerateEgg(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _controller.model.isShowEgg = pkg.readBoolean();
         _isReturn = true;
         show();
      }
      
      private function __onUIProgress(e:UIModuleEvent) : void
      {
         if(e.module == "times")
         {
            UIModuleSmallLoading.Instance.progress = e.loader.progress * 100;
         }
      }
      
      private function __onSmallLoadingClose(e:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
      }
      
      private function __onUIComplete(e:UIModuleEvent) : void
      {
         if(e.module == "times")
         {
            _isUIComplete = true;
         }
         if(e.module == "timesupdate")
         {
            _isUpdateResComplete = true;
         }
         if(!_isUIComplete || !_isUpdateResComplete)
         {
            return;
         }
         UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
         UIModuleSmallLoading.Instance.hide();
         show();
      }
      
      private function createTimesInfo() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_WEEKLY + "weekly/weeklyInfo.xml",2);
         loader.loadErrorMessage = "Error occur when loading times pic! Please refer to webmaster!";
         loader.analyzer = new TimesAnalyzer(TimesController.Instance.setup);
         LoadResourceManager.Instance.startLoad(loader,true);
      }
      
      public function get updateContentList() : Array
      {
         return _updateContentList;
      }
      
      public function checkOpenUpdateFrame() : void
      {
         if(_isNeedOpenUpdateFrame)
         {
            doOpenUpdateFrame();
         }
      }
      
      public function checkLoadUpdateRes(updateContentList:Array, idList:Array) : void
      {
         _updateContentList = updateContentList;
         var strLoction:String = SharedManager.Instance.edictumVersion;
         var idStr:String = idList.join("|");
         if(strLoction != idStr)
         {
            _isNeedOpenUpdateFrame = true;
            SharedManager.Instance.edictumVersion = idStr;
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.addUIModuleImp("timesupdate");
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "timesupdate")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            if(StateManager.currentStateType == "main")
            {
               doOpenUpdateFrame();
            }
         }
      }
      
      private function doOpenUpdateFrame() : void
      {
         _isNeedOpenUpdateFrame = false;
         var frame:TimesUpdateFrame = ComponentFactory.Instance.creatComponentByStylename("TimesUpdateFrame");
         LayerManager.Instance.addToLayer(frame,3,true,1);
         isShowActivityAdvView = true;
      }
      
      public function get isShowUpdateView() : Boolean
      {
         return _updateContentList && _updateContentList.length > 0;
      }
   }
}
