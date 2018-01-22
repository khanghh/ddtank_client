package trainer.controller
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PreviewFrameManager;
   import ddt.manager.SocketManager;
   import ddt.view.MainToolBar;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import road7th.utils.MovieClipWrapper;
   
   public class WeakGuildManager
   {
      
      private static var _instance:WeakGuildManager;
       
      
      private const LV:int = 15;
      
      private var _type:String;
      
      private var _title:String;
      
      private var _newTask:Boolean;
      
      private var _bmpLoader:BitmapLoader;
      
      public function WeakGuildManager()
      {
         super();
      }
      
      public static function get Instance() : WeakGuildManager
      {
         if(_instance == null)
         {
            _instance = new WeakGuildManager();
         }
         return _instance;
      }
      
      public function get switchUserGuide() : Boolean
      {
         return (PlayerManager.Instance.Self.Grade <= 15?true:false) && PathManager.solveUserGuildEnable();
      }
      
      public function get newTask() : Boolean
      {
         return _newTask;
      }
      
      public function set newTask(param1:Boolean) : void
      {
         _newTask = param1;
      }
      
      public function setup() : void
      {
         if(switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            PlayerManager.Instance.Self.addEventListener("propertychange",__onChange);
         }
      }
      
      private function __onChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade)
         {
            checkLevelFunction();
            MainToolBar.Instance.btnOpen();
            MainToolBar.Instance.refresh();
         }
      }
      
      public function timeStatistics(param1:int, param2:Number) : void
      {
         var _loc4_:Number = new Date().getTime() - param2;
         if(param1 == 0)
         {
            if(_loc4_ <= 60000)
            {
               return;
            }
         }
         else if(param1 == 1)
         {
            if(_loc4_ <= 30000)
            {
               return;
            }
         }
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.id = PlayerManager.Instance.Self.ID;
         _loc3_.type = param1;
         _loc3_.time = _loc4_;
         _loc3_.grade = PlayerManager.Instance.Self.Grade;
         _loc3_.serverID = PlayerManager.Instance.Self.ZoneID;
         var _loc6_:URLRequest = new URLRequest(PathManager.solveRequestPath("LogTime.ashx"));
         _loc6_.method = "POST";
         _loc6_.data = _loc3_;
         var _loc5_:URLLoader = new URLLoader();
         _loc5_.load(_loc6_);
      }
      
      public function statistics(param1:int, param2:Number) : void
      {
         var _loc4_:Number = new Date().getTime() - param2;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.id = PlayerManager.Instance.Self.ID;
         _loc3_.type = param1;
         _loc3_.time = _loc4_;
         _loc3_.grade = PlayerManager.Instance.Self.Grade;
         _loc3_.serverID = PlayerManager.Instance.Self.ZoneID;
         var _loc6_:URLRequest = new URLRequest(PathManager.solveRequestPath("LogTime.ashx"));
         _loc6_.method = "POST";
         _loc6_.data = _loc3_;
         var _loc5_:URLLoader = new URLLoader();
         _loc5_.load(_loc6_);
      }
      
      public function setStepFinish(param1:int) : void
      {
         param1--;
         var _loc2_:int = param1 / 8;
         var _loc4_:int = param1 % 8;
         var _loc3_:ByteArray = PlayerManager.Instance.Self.weaklessGuildProgress;
         if(_loc3_)
         {
            _loc3_[_loc2_] = _loc3_[_loc2_] | 1 << _loc4_;
            PlayerManager.Instance.Self.weaklessGuildProgress = _loc3_;
         }
      }
      
      public function showMainToolBarBtnOpen(param1:int, param2:String) : void
      {
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject(param2);
         var _loc3_:MovieClipWrapper = new MovieClipWrapper(ClassUtils.CreatInstance("asset.trainer.openMainToolBtn"),true,true);
         _loc3_.movie.x = _loc4_.x;
         _loc3_.movie.y = _loc4_.y;
         LayerManager.Instance.addToLayer(_loc3_.movie,3,false);
         SocketManager.Instance.out.syncWeakStep(param1);
      }
      
      public function checkFunction() : void
      {
         checkLevelFunction();
      }
      
      public function checkOpen(param1:int, param2:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Grade < param2)
         {
            return false;
         }
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return true;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(param1))
         {
            return false;
         }
         return true;
      }
      
      public function openBuildTip(param1:String) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.hall.ChooseHallView.openBuildTip",LanguageMgr.GetTranslation(param1)));
      }
      
      public function showBuildPreview(param1:String, param2:String) : void
      {
         _type = param1;
         _title = param2;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         _bmpLoader = LoadResourceManager.Instance.createLoader(PathManager.solveNewHandBuild(_type),0);
         _bmpLoader.addEventListener("progress",__loadProgress);
         _bmpLoader.addEventListener("complete",__loadComplete);
         LoadResourceManager.Instance.startLoad(_bmpLoader);
      }
      
      private function __loadProgress(param1:LoaderEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
      }
      
      private function __loadComplete(param1:LoaderEvent) : void
      {
         disposeBmpLoader();
         if(param1.loader.isSuccess)
         {
            PreviewFrameManager.Instance.createBuildPreviewFrame(_title,param1.loader.content);
         }
      }
      
      private function __onClose(param1:Event) : void
      {
         disposeBmpLoader();
      }
      
      private function disposeBmpLoader() : void
      {
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleSmallLoading.Instance.hide();
         if(_bmpLoader)
         {
            _bmpLoader.removeEventListener("progress",__loadProgress);
            _bmpLoader.removeEventListener("complete",__loadComplete);
            _bmpLoader = null;
         }
      }
      
      private function checkLevelFunction() : void
      {
         var _loc1_:int = PlayerManager.Instance.Self.Grade;
         if(_loc1_ > 1)
         {
            openFunction(1);
            openFunction(95);
         }
         if(_loc1_ > 2)
         {
            openFunction(18);
            openFunction(17);
            openFunction(7);
            openFunction(97);
            openFunction(99);
         }
         if(_loc1_ > 3)
         {
            openFunction(19);
         }
         if(_loc1_ > 4)
         {
            openFunction(3);
            openFunction(13);
            openFunction(27);
            openFunction(20);
         }
         if(_loc1_ > 5)
         {
            openFunction(60);
            openFunction(14);
            openFunction(21);
         }
         if(_loc1_ > 6)
         {
            openFunction(62);
            openFunction(15);
            openFunction(22);
            openFunction(33);
         }
         if(_loc1_ > 7)
         {
            openFunction(64);
            openFunction(16);
            openFunction(32);
         }
         if(_loc1_ > 8)
         {
            openFunction(66);
            openFunction(9);
         }
         if(_loc1_ > 9)
         {
            openFunction(35);
         }
         if(_loc1_ > 11)
         {
            openFunction(36);
            openFunction(76);
         }
         if(_loc1_ > 12)
         {
            openFunction(77);
            openFunction(79);
         }
         if(_loc1_ > 13)
         {
            openFunction(80);
            openFunction(82);
         }
         if(_loc1_ > 14)
         {
            openFunction(83);
            openFunction(85);
         }
      }
      
      private function openFunction(param1:int) : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(param1))
         {
            SocketManager.Instance.out.syncWeakStep(param1);
         }
      }
   }
}
