package gameStarling.actions
{
   import ddt.events.GameEvent;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Player;
   import gameStarling.objects.GamePlayer3D;
   import gameStarling.view.map.MapView3D;
   import guardCore.GuardCoreManager;
   
   public class ViewEachPlayerAction extends BaseAction
   {
       
      
      private var _map:MapView3D;
      
      private var _players:Array;
      
      private var _interval:Number;
      
      private var _index:int;
      
      private var _count:int;
      
      public function ViewEachPlayerAction(param1:MapView3D, param2:Array, param3:Number = 1500){super();}
      
      override public function execute() : void{}
   }
}
