package tofflist
{
   import battleGroud.CeleTotalPrestigeAnalyer;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.RequestVairableCreater;
   import flash.display.DisplayObject;
   import flash.net.URLVariables;
   import quest.TaskManager;
   import tofflist.analyze.TofflistListAnalyzer;
   import tofflist.analyze.TofflistListThirdAnalyzer;
   import tofflist.analyze.TofflistListTwoAnalyzer;
   import tofflist.view.TofflistView;
   
   public class TofflistController extends BaseStateView
   {
       
      
      private var _view:TofflistView;
      
      private var _temporaryTofflistListData:String;
      
      public function TofflistController(){super();}
      
      private function init() : void{}
      
      private function celeTotalPrestigeData() : void{}
      
      public function completeHander2(param1:CeleTotalPrestigeAnalyer) : void{}
      
      override public function getView() : DisplayObject{return null;}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function dispose() : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      public function loadFormData(param1:String, param2:String, param3:String) : void{}
      
      private function __teamResult(param1:TofflistListThirdAnalyzer) : void{}
      
      private function __personalResult(param1:TofflistListTwoAnalyzer) : void{}
      
      private function __sociatyResult(param1:TofflistListAnalyzer) : void{}
      
      public function clearDisplayContent() : void{}
      
      public function loadList(param1:int) : void{}
      
      private function _loadXml(param1:String, param2:DataAnalyzer, param3:int, param4:String = "") : void{}
   }
}
