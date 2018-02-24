package gameStarling.actions
{
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameStarling.view.map.MapView3D;
   import road7th.comm.PackageIn;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class GameOverAction extends BaseAction
   {
       
      
      private var _event:CrazyTankSocketEvent;
      
      private var _executed:Boolean;
      
      private var _count:int;
      
      private var _map:MapView3D;
      
      private var _current:GameInfo;
      
      private var _func:Function;
      
      public function GameOverAction(param1:MapView3D, param2:CrazyTankSocketEvent, param3:Function, param4:Number = 3000){super();}
      
      private function readInfo(param1:CrazyTankSocketEvent) : void{}
      
      override public function cancel() : void{}
      
      override public function execute() : void{}
   }
}
