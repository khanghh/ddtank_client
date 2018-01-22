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
      
      public function showButton(param1:HallStateView) : void
      {
         _hallView = param1;
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
      
      private function __onThumbnailComplete(param1:TimesEvent) : void
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
      
      public function showByQQtips(param1:int) : void
      {
         _isQQshow = true;
         _page = param1;
         __onBtnClick(null);
      }
      
      private function _QQshowComplete() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Array = _controller.model.contentInfos;
         var _loc1_:TimesPicInfo = new TimesPicInfo();
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_[_loc5_].length)
            {
               _loc2_++;
               if(_loc2_ == _page)
               {
                  _loc1_.targetCategory = _loc5_;
                  _loc1_.targetPage = _loc3_;
               }
               _loc3_++;
            }
            _loc5_++;
         }
         _controller.dispatchEvent(new TimesEvent("gotoContent",_loc1_));
      }
      
      private function __keyBoardEventHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 27)
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
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Vector.<int> = _statistics.stayTime;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc4_ = _loc4_ + _loc1_[_loc5_];
            _loc5_++;
         }
         if(_loc4_ == 0)
         {
            _statistics.stopTick();
            return;
         }
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_["Versions"] = _controller.model.edition;
         _loc3_["Forum1"] = _loc1_[0];
         _loc3_["Forum2"] = _loc1_[1];
         _loc3_["Forum3"] = _loc1_[2];
         _loc3_["Forum4"] = _loc1_[3];
         _loc3_["Forum5"] = _loc1_[4];
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("CommitWeeklyUserRecord.ashx"),6,_loc3_);
         LoadResourceManager.Instance.startLoad(_loc2_);
         _statistics.stopTick();
      }
      
      private function __timesEventHandler(param1:TimesEvent) : void
      {
         var _loc2_:* = param1.type;
         if("closeView" !== _loc2_)
         {
            if("playSound" !== _loc2_)
            {
               if("gotEgg" !== _loc2_)
               {
                  if("purchase" === _loc2_)
                  {
                     SoundManager.instance.play("008");
                     ShopBuyManager.Instance.buy(int(param1.info.templateID));
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
      
      private function __onBtnClick(param1:MouseEvent) : void
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
      
      private function __canGenerateEgg(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _controller.model.isShowEgg = _loc2_.readBoolean();
         _isReturn = true;
         show();
      }
      
      private function __onUIProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "times")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __onSmallLoadingClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onUIComplete);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__onUIProgress);
      }
      
      private function __onUIComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "times")
         {
            _isUIComplete = true;
         }
         if(param1.module == "timesupdate")
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
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.SITE_WEEKLY + "weekly/weeklyInfo.xml",2);
         _loc1_.loadErrorMessage = "Error occur when loading times pic! Please refer to webmaster!";
         _loc1_.analyzer = new TimesAnalyzer(TimesController.Instance.setup);
         LoadResourceManager.Instance.startLoad(_loc1_,true);
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
      
      public function checkLoadUpdateRes(param1:Array, param2:Array) : void
      {
         _updateContentList = param1;
         var _loc4_:String = SharedManager.Instance.edictumVersion;
         var _loc3_:String = param2.join("|");
         if(_loc4_ != _loc3_)
         {
            _isNeedOpenUpdateFrame = true;
            SharedManager.Instance.edictumVersion = _loc3_;
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.addUIModuleImp("timesupdate");
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "timesupdate")
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
         var _loc1_:TimesUpdateFrame = ComponentFactory.Instance.creatComponentByStylename("TimesUpdateFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
         isShowActivityAdvView = true;
      }
      
      public function get isShowUpdateView() : Boolean
      {
         return _updateContentList && _updateContentList.length > 0;
      }
   }
}
