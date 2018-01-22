package labyrinth
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import labyrinth.data.CleanOutInfo;
   import labyrinth.model.LabyrinthModel;
   import road7th.comm.PackageIn;
   
   public class LabyrinthManager extends CoreManager
   {
      
      public static const UPDATE_INFO:String = "updateInfo";
      
      public static const UPDATE_REMAIN_TIME:String = "updateRemainTime";
      
      public static const LABYRINTH_CHAT:String = "LabyrinthChat";
      
      public static const LABYRINTH_OPENVIEW:String = "LabyrinthOpenView";
      
      private static var _instance:LabyrinthManager;
       
      
      private var _model:LabyrinthModel;
      
      public function LabyrinthManager(param1:IEventDispatcher = null)
      {
         super(param1);
         _model = new LabyrinthModel();
         initEvent();
      }
      
      public static function get Instance() : LabyrinthManager
      {
         if(_instance == null)
         {
            _instance = new LabyrinthManager();
         }
         return _instance;
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(131,2),__onUpdataInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(131,7),__onUpdataCleanOutInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(131,3),__onRemainCleanOutTime);
      }
      
      protected function __onRemainCleanOutTime(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _model.sType = _loc2_;
         _model.remainTime = _loc3_.readInt();
         _model.currentRemainTime = _loc3_.readInt();
         dispatchEvent(new Event("updateRemainTime"));
      }
      
      protected function __onUpdataCleanOutInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         var _loc7_:CleanOutInfo = new CleanOutInfo();
         _loc7_.FamRaidLevel = _loc3_.readInt();
         _loc7_.exp = _loc3_.readInt();
         var _loc5_:int = _loc3_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = {};
            _loc4_["TemplateID"] = _loc3_.readInt();
            _loc4_["num"] = _loc3_.readInt();
            _loc7_.TemplateIDs.push(_loc4_);
            _loc6_++;
         }
         _loc7_.HardCurrency = _loc3_.readInt();
         if(_model.cleanOutInfos[_loc7_.FamRaidLevel])
         {
            _model.cleanOutInfos.remove(_loc7_.FamRaidLevel);
            delete _model.cleanOutInfos[_loc7_.FamRaidLevel];
         }
         _model.sType = _loc2_;
         _model.cleanOutInfos.add(_loc7_.FamRaidLevel,_loc7_);
      }
      
      protected function __onUpdataInfo(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _model.sType = _loc2_;
         _model.myProgress = _loc3_.readInt();
         _model.currentFloor = _loc3_.readInt();
         _model.completeChallenge = _loc3_.readBoolean();
         _model.remainTime = _loc3_.readInt();
         _model.accumulateExp = _loc3_.readInt();
         _model.cleanOutAllTime = _loc3_.readInt();
         _model.cleanOutGold = _loc3_.readInt();
         _model.myRanking = _loc3_.readInt();
         _model.isDoubleAward = _loc3_.readBoolean();
         _model.isInGame = _loc3_.readBoolean();
         _model.isCleanOut = _loc3_.readBoolean();
         _model.serverMultiplyingPower = _loc3_.readBoolean();
         dispatchEvent(new Event("updateInfo"));
      }
      
      public function enterGame() : void
      {
         SocketManager.Instance.out.enterUserGuide(0,15);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new Event("LabyrinthOpenView"));
      }
      
      public function get model() : LabyrinthModel
      {
         return _model;
      }
      
      public function set model(param1:LabyrinthModel) : void
      {
         _model = param1;
      }
      
      public function chat() : void
      {
         dispatchEvent(new Event("LabyrinthChat"));
      }
   }
}
