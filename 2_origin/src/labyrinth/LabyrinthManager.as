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
      
      public function LabyrinthManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      protected function __onRemainCleanOutTime(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var selectedType:int = pkg.readInt();
         _model.sType = selectedType;
         _model.remainTime = pkg.readInt();
         _model.currentRemainTime = pkg.readInt();
         dispatchEvent(new Event("updateRemainTime"));
      }
      
      protected function __onUpdataCleanOutInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         var pkg:PackageIn = event.pkg;
         var selectedType:int = pkg.readInt();
         var info:CleanOutInfo = new CleanOutInfo();
         info.FamRaidLevel = pkg.readInt();
         info.exp = pkg.readInt();
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            obj = {};
            obj["TemplateID"] = pkg.readInt();
            obj["num"] = pkg.readInt();
            info.TemplateIDs.push(obj);
            i++;
         }
         info.HardCurrency = pkg.readInt();
         if(_model.cleanOutInfos[info.FamRaidLevel])
         {
            _model.cleanOutInfos.remove(info.FamRaidLevel);
            delete _model.cleanOutInfos[info.FamRaidLevel];
         }
         _model.sType = selectedType;
         _model.cleanOutInfos.add(info.FamRaidLevel,info);
      }
      
      protected function __onUpdataInfo(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var selectedType:int = pkg.readInt();
         _model.sType = selectedType;
         _model.myProgress = pkg.readInt();
         _model.currentFloor = pkg.readInt();
         _model.completeChallenge = pkg.readBoolean();
         _model.remainTime = pkg.readInt();
         _model.accumulateExp = pkg.readInt();
         _model.cleanOutAllTime = pkg.readInt();
         _model.cleanOutGold = pkg.readInt();
         _model.myRanking = pkg.readInt();
         _model.isDoubleAward = pkg.readBoolean();
         _model.isInGame = pkg.readBoolean();
         _model.isCleanOut = pkg.readBoolean();
         _model.serverMultiplyingPower = pkg.readBoolean();
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
      
      public function set model(value:LabyrinthModel) : void
      {
         _model = value;
      }
      
      public function chat() : void
      {
         dispatchEvent(new Event("LabyrinthChat"));
      }
   }
}
