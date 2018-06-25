package tofflist{   import battleGroud.CeleTotalPrestigeAnalyer;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.loader.LoaderCreate;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.states.BaseStateView;   import ddt.utils.AssetModuleLoader;   import ddt.utils.RequestVairableCreater;   import flash.display.DisplayObject;   import flash.net.URLVariables;   import quest.TaskManager;   import tofflist.analyze.TofflistListAnalyzer;   import tofflist.analyze.TofflistListThirdAnalyzer;   import tofflist.analyze.TofflistListTwoAnalyzer;   import tofflist.view.TofflistView;      public class TofflistController extends BaseStateView   {                   private var _view:TofflistView;            private var _temporaryTofflistListData:String;            public function TofflistController() { super(); }
            private function init() : void { }
            private function celeTotalPrestigeData() : void { }
            public function completeHander2(analyzer:CeleTotalPrestigeAnalyer) : void { }
            override public function getView() : DisplayObject { return null; }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function dispose() : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getBackType() : String { return null; }
            override public function getType() : String { return null; }
            public function loadFormData(_dataInfo:String, _url:String, _type:String) : void { }
            private function __teamResult(analyzer:TofflistListThirdAnalyzer) : void { }
            private function __personalResult(analyzer:TofflistListTwoAnalyzer) : void { }
            private function __sociatyResult(analyzer:TofflistListAnalyzer) : void { }
            public function clearDisplayContent() : void { }
            public function loadList(type:int) : void { }
            private function _loadXml($url:String, $dataAnalyzer:DataAnalyzer, $requestType:int, $loadErrorMessage:String = "") : void { }
   }}