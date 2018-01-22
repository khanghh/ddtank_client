package littleGame.actions
{
   import ddt.ddt_internal;
   import flash.geom.Point;
   import littleGame.data.Grid;
   import littleGame.data.Node;
   import littleGame.model.LittleLiving;
   import littleGame.model.Scenario;
   
   use namespace ddt_internal;
   
   public class LittleLivingMoveAction extends LittleAction
   {
       
      
      protected var _path:Array;
      
      protected var _grid:Grid;
      
      protected var _idx:int = 0;
      
      protected var _scene:Scenario;
      
      protected var _len:int;
      
      protected var _totalTime:int;
      
      protected var _elapsed:int;
      
      public function LittleLivingMoveAction(param1:LittleLiving, param2:Array, param3:Scenario){super();}
      
      override public function connect(param1:LittleAction) : Boolean{return false;}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      override protected function finish() : void{}
      
      override public function cancel() : void{}
   }
}
