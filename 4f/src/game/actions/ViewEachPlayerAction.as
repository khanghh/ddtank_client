package game.actions
{
   import ddt.events.GameEvent;
   import game.objects.GamePlayer;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Player;
   import guardCore.GuardCoreManager;
   
   public class ViewEachPlayerAction extends BaseAction
   {
       
      
      private var _map:MapView;
      
      private var _players:Array;
      
      private var _interval:Number;
      
      private var _index:int;
      
      private var _count:int;
      
      public function ViewEachPlayerAction(param1:MapView, param2:Array, param3:Number = 1500){super();}
      
      override public function execute() : void{}
   }
}
