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
      
      public function TofflistController()
      {
         super();
      }
      
      private function init() : void
      {
         _view = new TofflistView(this);
         addChild(_view);
         loadFormData("personalBattleAccumulate","CelebByDayFightPowerList.xml","personal");
         celeTotalPrestigeData();
      }
      
      private function celeTotalPrestigeData() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("CelebByTotalPrestige.xml"),5);
         loader.analyzer = new CeleTotalPrestigeAnalyer(completeHander2);
      }
      
      public function completeHander2(analyzer:CeleTotalPrestigeAnalyer) : void
      {
      }
      
      override public function getView() : DisplayObject
      {
         return _view;
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         init();
         _view.addEvent();
         ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.selfConsortionComplete,1,6,PlayerManager.Instance.Self.ConsortiaName,-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(90) && TaskManager.instance.getQuestDataByID(358))
         {
            SocketManager.Instance.out.sendQuestCheck(358,1,0);
            SocketManager.Instance.out.syncWeakStep(90);
         }
         if(TofflistModel.Instance.rankInfo == null)
         {
            TofflistModel.Instance.loadRankInfo();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_view);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         dispose();
         super.leaving(next);
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "tofflist";
      }
      
      public function loadFormData(_dataInfo:String, _url:String, _type:String) : void
      {
         _dataInfo = _dataInfo;
         _url = _url;
         _type = _type;
         _temporaryTofflistListData = _dataInfo;
         if(!TofflistModel.Instance[_temporaryTofflistListData])
         {
            if(_type == "personal")
            {
               var tofflistListTwoAnalyzer:DataAnalyzer = new TofflistListTwoAnalyzer(__personalResult);
            }
            else if(_type == "sociaty")
            {
               tofflistListTwoAnalyzer = new TofflistListAnalyzer(__sociatyResult);
            }
            else if(_type == "team")
            {
               AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createTeamBattleSegmentLoader());
               AssetModuleLoader.startLoader(function():*
               {
                  var /*UnknownSlot*/:* = function():void
                  {
                     tofflistListTwoAnalyzer = new TofflistListThirdAnalyzer(__teamResult);
                     _loadXml(_url,tofflistListTwoAnalyzer,5);
                  };
                  return function():void
                  {
                     tofflistListTwoAnalyzer = new TofflistListThirdAnalyzer(__teamResult);
                     _loadXml(_url,tofflistListTwoAnalyzer,5);
                  };
               }());
               return;
            }
            _loadXml(_url,tofflistListTwoAnalyzer,5);
         }
         else
         {
            TofflistModel.Instance[_temporaryTofflistListData] = TofflistModel.Instance[_temporaryTofflistListData];
         }
      }
      
      private function __teamResult(analyzer:TofflistListThirdAnalyzer) : void
      {
         TofflistModel.Instance[_temporaryTofflistListData] = analyzer.data;
      }
      
      private function __personalResult(analyzer:TofflistListTwoAnalyzer) : void
      {
         TofflistModel.Instance[_temporaryTofflistListData] = analyzer.data;
      }
      
      private function __sociatyResult(analyzer:TofflistListAnalyzer) : void
      {
         TofflistModel.Instance[_temporaryTofflistListData] = analyzer.data;
      }
      
      public function clearDisplayContent() : void
      {
         _view.clearDisplayContent();
      }
      
      public function loadList(type:int) : void
      {
      }
      
      private function _loadXml($url:String, $dataAnalyzer:DataAnalyzer, $requestType:int, $loadErrorMessage:String = "") : void
      {
         _view.rightView.gridBox.orderList.clearList();
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var loadSelfConsortiaMemberList:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath($url),$requestType,args);
         loadSelfConsortiaMemberList.loadErrorMessage = $loadErrorMessage;
         loadSelfConsortiaMemberList.analyzer = $dataAnalyzer;
         LoadResourceManager.Instance.startLoad(loadSelfConsortiaMemberList);
      }
   }
}
