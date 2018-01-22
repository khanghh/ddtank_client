package game.actions
{
   import ddt.data.BallInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BallManager;
   import ddt.manager.SoundManager;
   import game.objects.GameSceneEffect;
   import game.objects.SimpleBomb;
   import game.view.map.MapView;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   
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
      
      private var _map:MapView;
      
      private var _sceneEffect:GameSceneEffect;
      
      private var _canShootImp:Boolean;
      
      public function SceneEffectShootBombAction(param1:int, param2:MapView, param3:Array, param4:CrazyTankSocketEvent, param5:int){super();}
      
      override public function prepare() : void{}
      
      protected function onCallbackPrepared() : void{}
      
      private function canShoot() : void{}
      
      override public function execute() : void{}
      
      private function executeImp(param1:Boolean) : void{}
   }
}
