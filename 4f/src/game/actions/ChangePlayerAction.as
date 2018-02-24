package game.actions
{
   import bombKing.BombKingManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.data.PathInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import game.objects.GameLiving;
   import game.objects.SimpleBox;
   import game.view.GameView;
   import game.view.map.MapView;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.TurnedLiving;
   import org.aswing.KeyboardManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   
   public class ChangePlayerAction extends BaseAction
   {
       
      
      private var _map:MapView;
      
      private var _info:Living;
      
      private var _count:int;
      
      private var _changed:Boolean;
      
      private var _pkg:PackageIn;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _turnTime:int;
      
      public function ChangePlayerAction(param1:MapView, param2:Living, param3:CrazyTankSocketEvent, param4:PackageIn, param5:Number = 200, param6:int = -1){super();}
      
      private function syncMap() : void{}
      
      override public function execute() : void{}
      
      private function changePlayer() : void{}
      
      override public function cancel() : void{}
      
      private function executeImp(param1:Boolean) : void{}
      
      override public function executeAtOnce() : void{}
   }
}
