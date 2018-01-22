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
      
      public function ViewEachPlayerAction(param1:MapView3D, param2:Array, param3:Number = 1500)
      {
         super();
         _players = param2.sortOn("x",16);
         _map = param1;
         _interval = param3 / 40;
         _index = 0;
         _count = 0;
      }
      
      override public function execute() : void
      {
         var _loc1_:* = null;
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         if(_count <= 0)
         {
            if(_index < _players.length)
            {
               _map.setCenter(_players[_index].x,_players[_index].y - 150,true);
               _count = _interval;
               _index = Number(_index) + 1;
            }
            else
            {
               _isFinished = true;
            }
         }
         _count = Number(_count) - 1;
         if(_count == 20)
         {
            _loc1_ = (_players[_index - 1] as GamePlayer3D).player;
            if(_loc1_ == null)
            {
               return;
            }
            if(_loc1_.ringFlag)
            {
               GameControl.Instance.dispatchEvent(new GameEvent("addringanamition",_players[_index - 1]));
            }
            if(GameControl.Instance.Current.guardCoreEnable)
            {
               if(_loc1_.playerInfo.guardCoreID != 0 && _loc1_.playerInfo.Grade >= GuardCoreManager.instance.guardCoreMinLevel)
               {
                  GameControl.Instance.dispatchEvent(new GameEvent("addguardcoreeffect",_players[_index - 1]));
               }
            }
         }
      }
   }
}
