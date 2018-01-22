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
      
      public function LabyrinthManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : LabyrinthManager{return null;}
      
      private function initEvent() : void{}
      
      protected function __onRemainCleanOutTime(param1:PkgEvent) : void{}
      
      protected function __onUpdataCleanOutInfo(param1:PkgEvent) : void{}
      
      protected function __onUpdataInfo(param1:PkgEvent) : void{}
      
      public function enterGame() : void{}
      
      override protected function start() : void{}
      
      public function get model() : LabyrinthModel{return null;}
      
      public function set model(param1:LabyrinthModel) : void{}
      
      public function chat() : void{}
   }
}
