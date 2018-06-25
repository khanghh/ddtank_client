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
      
      public function set newTask(value:Boolean) : void
      {
         _newTask = value;
      }
      
      public function setup() : void
      {
         if(switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            PlayerManager.Instance.Self.addEventListener("propertychange",__onChange);
         }
      }
      
      private function __onChange(event:PlayerPropertyEvent) : void
      {
         if(event.changedProperties["Grade"] && PlayerManager.Instance.Self.IsUpGrade)
         {
            checkLevelFunction();
            MainToolBar.Instance.btnOpen();
            MainToolBar.Instance.refresh();
         }
      }
      
      public function timeStatistics(type:int, startTime:Number) : void
      {
         var time:Number = new Date().getTime() - startTime;
         if(type == 0)
         {
            if(time <= 60000)
            {
               return;
            }
         }
         else if(type == 1)
         {
            if(time <= 30000)
            {
               return;
            }
         }
         var urlVar:URLVariables = new URLVariables();
         urlVar.id = PlayerManager.Instance.Self.ID;
         urlVar.type = type;
         urlVar.time = time;
         urlVar.grade = PlayerManager.Instance.Self.Grade;
         urlVar.serverID = PlayerManager.Instance.Self.ZoneID;
         var url:URLRequest = new URLRequest(PathManager.solveRequestPath("LogTime.ashx"));
         url.method = "POST";
         url.data = urlVar;
         var loader:URLLoader = new URLLoader();
         loader.load(url);
      }
      
      public function statistics(type:int, startTime:Number) : void
      {
         var time:Number = new Date().getTime() - startTime;
         var urlVar:URLVariables = new URLVariables();
         urlVar.id = PlayerManager.Instance.Self.ID;
         urlVar.type = type;
         urlVar.time = time;
         urlVar.grade = PlayerManager.Instance.Self.Grade;
         urlVar.serverID = PlayerManager.Instance.Self.ZoneID;
         var url:URLRequest = new URLRequest(PathManager.solveRequestPath("LogTime.ashx"));
         url.method = "POST";
         url.data = urlVar;
         var loader:URLLoader = new URLLoader();
         loader.load(url);
      }
      
      public function setStepFinish(step:int) : void
      {
         step--;
         var index:int = step / 8;
         var offset:int = step % 8;
         var b:ByteArray = PlayerManager.Instance.Self.weaklessGuildProgress;
         if(b)
         {
            b[index] = b[index] | 1 << offset;
            PlayerManager.Instance.Self.weaklessGuildProgress = b;
         }
      }
      
      public function showMainToolBarBtnOpen(step:int, pos:String) : void
      {
         var p:Point = ComponentFactory.Instance.creatCustomObject(pos);
         var mc:MovieClipWrapper = new MovieClipWrapper(ClassUtils.CreatInstance("asset.trainer.openMainToolBtn"),true,true);
         mc.movie.x = p.x;
         mc.movie.y = p.y;
         LayerManager.Instance.addToLayer(mc.movie,3,false);
         SocketManager.Instance.out.syncWeakStep(step);
      }
      
      public function checkFunction() : void
      {
         checkLevelFunction();
      }
      
      public function checkOpen(step:int, lv:int) : Boolean
      {
         if(PlayerManager.Instance.Self.Grade < lv)
         {
            return false;
         }
         if(!WeakGuildManager.Instance.switchUserGuide || PlayerManager.Instance.Self.IsWeakGuildFinish(950))
         {
            return true;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(step))
         {
            return false;
         }
         return true;
      }
      
      public function openBuildTip(buildName:String) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.hall.ChooseHallView.openBuildTip",LanguageMgr.GetTranslation(buildName)));
      }
      
      public function showBuildPreview(type:String, title:String) : void
      {
         _type = type;
         _title = title;
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         _bmpLoader = LoadResourceManager.Instance.createLoader(PathManager.solveNewHandBuild(_type),0);
         _bmpLoader.addEventListener("progress",__loadProgress);
         _bmpLoader.addEventListener("complete",__loadComplete);
         LoadResourceManager.Instance.startLoad(_bmpLoader);
      }
      
      private function __loadProgress(evt:LoaderEvent) : void
      {
         UIModuleSmallLoading.Instance.progress = evt.loader.progress * 100;
      }
      
      private function __loadComplete(evt:LoaderEvent) : void
      {
         disposeBmpLoader();
         if(evt.loader.isSuccess)
         {
            PreviewFrameManager.Instance.createBuildPreviewFrame(_title,evt.loader.content);
         }
      }
      
      private function __onClose(event:Event) : void
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
         var lv:int = PlayerManager.Instance.Self.Grade;
         if(lv > 1)
         {
            openFunction(1);
            openFunction(95);
         }
         if(lv > 2)
         {
            openFunction(18);
            openFunction(17);
            openFunction(7);
            openFunction(97);
            openFunction(99);
         }
         if(lv > 3)
         {
            openFunction(19);
         }
         if(lv > 4)
         {
            openFunction(3);
            openFunction(13);
            openFunction(27);
            openFunction(20);
         }
         if(lv > 5)
         {
            openFunction(60);
            openFunction(14);
            openFunction(21);
         }
         if(lv > 6)
         {
            openFunction(62);
            openFunction(15);
            openFunction(22);
            openFunction(33);
         }
         if(lv > 7)
         {
            openFunction(64);
            openFunction(16);
            openFunction(32);
         }
         if(lv > 8)
         {
            openFunction(66);
            openFunction(9);
         }
         if(lv > 9)
         {
            openFunction(35);
         }
         if(lv > 11)
         {
            openFunction(36);
            openFunction(76);
         }
         if(lv > 12)
         {
            openFunction(77);
            openFunction(79);
         }
         if(lv > 13)
         {
            openFunction(80);
            openFunction(82);
         }
         if(lv > 14)
         {
            openFunction(83);
            openFunction(85);
         }
      }
      
      private function openFunction(id:int) : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(id))
         {
            SocketManager.Instance.out.syncWeakStep(id);
         }
      }
   }
}
