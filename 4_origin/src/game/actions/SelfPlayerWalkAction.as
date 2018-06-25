package game.actions
{
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.view.character.GameCharacter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.objects.GameLocalPlayer;
   import game.objects.SimpleObject;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Player;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import phy.object.PhysicalObj;
   import room.RoomManager;
   
   public class SelfPlayerWalkAction extends BaseAction
   {
       
      
      private var _player:GameLocalPlayer;
      
      private var _end:Point;
      
      private var _count:int;
      
      private var _currentReverse:int;
      
      private var _transmissionGate:Boolean = true;
      
      public function SelfPlayerWalkAction(player:GameLocalPlayer, $reverse:int = 1)
      {
         super();
         _player = player;
         _count = 0;
         _currentReverse = $reverse;
         _isFinished = false;
      }
      
      override public function connect(action:BaseAction) : Boolean
      {
         return action is SelfPlayerWalkAction;
      }
      
      private function isDirkeyDown() : Boolean
      {
         if(_player.info.direction * _currentReverse == -1)
         {
            return KeyboardManager.isDown(KeyStroke.VK_A.getCode()) || KeyboardManager.isDown(37);
         }
         return KeyboardManager.isDown(KeyStroke.VK_D.getCode()) || KeyboardManager.isDown(39);
      }
      
      override public function prepare() : void
      {
         _player.startMoving();
         _player.needFocus(0,0,{
            "strategy":"directly",
            "priority":1
         });
      }
      
      override public function execute() : void
      {
         var pos:* = null;
         var playerHitPhy:Boolean = false;
         var isCollideObjArr:* = null;
         var playerRect:* = null;
         var i:int = 0;
         var phyO:* = null;
         var t:* = null;
         var tx1:Number = NaN;
         var pos1:* = null;
         var tx:Number = NaN;
         if(!_player || !_player.info)
         {
            _isFinished = true;
            return;
         }
         if(isDirkeyDown() && (_player.localPlayer.powerRatio == 0 || _player.localPlayer.energy > 0) && _player.localPlayer.isAttacking && !_player.localPlayer.forbidMoving)
         {
            pos = _player.getNextWalkPoint(_player.info.direction);
            if(pos)
            {
               _player.info.pos = pos;
               _player.body.doAction(_player.body.walkAction);
               _player.body.WingState = 2;
               SoundManager.instance.play("044",false,false);
               _player.needFocus(0,0,{
                  "strategy":"directly",
                  "priority":1
               },_player);
               _count = Number(_count) + 1;
               if(_count >= 20)
               {
                  sendAction();
               }
            }
            else
            {
               playerHitPhy = false;
               isCollideObjArr = _player.map.getIsCollideObj();
               playerRect = _player.getCollideRect();
               playerRect.offset(_player.x,_player.y);
               for(i = 0; i < isCollideObjArr.length; )
               {
                  phyO = isCollideObjArr[i];
                  t = phyO.getCollideRect();
                  t.offset(phyO.x,phyO.y);
                  if(t.intersects(playerRect))
                  {
                     playerHitPhy = true;
                  }
                  i++;
               }
               if(playerHitPhy)
               {
                  tx1 = _player.x + _player.info.direction * Player.MOVE_SPEED;
                  pos1 = new Point(tx1,_player.y);
                  _player.info.pos = pos1;
                  _player.body.doAction(_player.body.walkAction);
                  _player.body.WingState = 2;
                  SoundManager.instance.play("044",false,false);
                  _player.needFocus(0,0,{
                     "strategy":"directly",
                     "priority":1
                  });
                  _count = Number(_count) + 1;
                  if(_count >= 20)
                  {
                     sendAction();
                  }
                  return;
               }
               sendAction();
               finish();
               tx = _player.x + _player.info.direction * Player.MOVE_SPEED;
               if(_player.canMoveDirection(_player.info.direction) && _player.canStand(tx,_player.y) == false)
               {
                  pos = _player.map.findYLineNotEmptyPointDown(tx,_player.y - 7,_player.map.bound.height);
                  if(pos)
                  {
                     _player.act(new PlayerFallingAction(_player,pos,true,false));
                     GameInSocketOut.sendGameStartMove(1,pos.x,pos.y,0,true,_player.map.currentTurn);
                  }
                  else if(GameControl.Instance.Current.gameMode == 56)
                  {
                     _player.act(new PlayerFallingAction(_player,new Point(tx,_player.map.bound.height - 70),true,false));
                     GameInSocketOut.sendGameStartMove(1,tx,_player.map.bound.height,0,true,_player.map.currentTurn);
                  }
                  else
                  {
                     _player.act(new PlayerFallingAction(_player,new Point(tx,_player.map.bound.height - 70),false,false));
                     GameInSocketOut.sendGameStartMove(1,tx,_player.map.bound.height,0,false,_player.map.currentTurn);
                  }
               }
            }
         }
         else
         {
            if(_player.localPlayer.energy <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.game.actions.SelfPlayerWalkAction"));
            }
            sendAction();
            finish();
         }
         if(RoomManager.Instance.current.type == 15)
         {
            transmissionGate();
         }
      }
      
      private function transmissionGate() : void
      {
         var playerRect:Rectangle = _player.getCollideRect();
         playerRect.offset(_player.x,_player.y);
         var list:Array = _player.map.getCollidedPhysicalObjects(playerRect,_player);
         if(list.length != 0 && _transmissionGate)
         {
            var _loc5_:int = 0;
            var _loc4_:* = list;
            for each(var i in list)
            {
               if(i is SimpleObject && i.layerType == 3)
               {
                  _player.localPlayer.isAttacking = false;
                  _player.showTransmissionEffoct();
                  GameInSocketOut.sendTransmissionGate(true);
                  _transmissionGate = false;
               }
            }
         }
      }
      
      private function sendAction() : void
      {
         GameInSocketOut.sendGameStartMove(0,_player.x,_player.y,_player.info.direction,_player.isLiving,_player.map.currentTurn);
         _count = 0;
      }
      
      private function finish() : void
      {
         _player.stopMoving();
         _player.doAction(GameCharacter.STAND);
         _isFinished = true;
      }
   }
}
