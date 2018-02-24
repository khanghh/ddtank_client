package gameStarling.actions
{
   import ddt.data.BallInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameStarling.objects.GameSceneEffect3D;
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.view.map.MapView3D;
   
   public class SceneEffectShootBombAction extends BaseAction
   {
       
      
      private var _bombs:Array;
      
      private var _isShoot:Boolean;
      
      private var _prepared:Boolean;
      
      private var _prepareAction:String;
      
      private var _shootInterval:int;
      
      private var _info:BallInfo;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _endAction:String = "";
      
      private var _livingId:int;
      
      private var _map:MapView3D;
      
      private var _sceneEffect:GameSceneEffect3D;
      
      private var _canShootImp:Boolean;
      
      public function SceneEffectShootBombAction(param1:int, param2:MapView3D, param3:Array, param4:CrazyTankSocketEvent, param5:int){super();}
      
      override public function prepare() : void{}
      
      protected function onCallbackPrepared() : void{}
      
      private function canShoot() : void{}
      
      override public function execute() : void{}
      
      private function executeImp(param1:Boolean) : void{}
   }
}
