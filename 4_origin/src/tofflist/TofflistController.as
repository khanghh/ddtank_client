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
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("CelebByTotalPrestige.xml"),5);
         _loc1_.analyzer = new CeleTotalPrestigeAnalyer(completeHander2);
      }
      
      public function completeHander2(param1:CeleTotalPrestigeAnalyer) : void
      {
      }
      
      override public function getView() : DisplayObject
      {
         return _view;
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
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
      
      override public function leaving(param1:BaseStateView) : void
      {
         dispose();
         super.leaving(param1);
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "tofflist";
      }
      
      public function loadFormData(param1:String, param2:String, param3:String) : void
      {
         _dataInfo = param1;
         _url = param2;
         _type = param3;
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
      
      private function __teamResult(param1:TofflistListThirdAnalyzer) : void
      {
         TofflistModel.Instance[_temporaryTofflistListData] = param1.data;
      }
      
      private function __personalResult(param1:TofflistListTwoAnalyzer) : void
      {
         TofflistModel.Instance[_temporaryTofflistListData] = param1.data;
      }
      
      private function __sociatyResult(param1:TofflistListAnalyzer) : void
      {
         TofflistModel.Instance[_temporaryTofflistListData] = param1.data;
      }
      
      public function clearDisplayContent() : void
      {
         _view.clearDisplayContent();
      }
      
      public function loadList(param1:int) : void
      {
      }
      
      private function _loadXml(param1:String, param2:DataAnalyzer, param3:int, param4:String = "") : void
      {
         _view.rightView.gridBox.orderList.clearList();
         var _loc5_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loc6_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(param1),param3,_loc5_);
         _loc6_.loadErrorMessage = param4;
         _loc6_.analyzer = param2;
         LoadResourceManager.Instance.startLoad(_loc6_);
      }
   }
}
