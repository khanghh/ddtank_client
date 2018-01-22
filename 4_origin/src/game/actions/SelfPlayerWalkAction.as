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
      
      public function SelfPlayerWalkAction(param1:GameLocalPlayer, param2:int = 1)
      {
         super();
         _player = param1;
         _count = 0;
         _currentReverse = param2;
         _isFinished = false;
      }
      
      override public function connect(param1:BaseAction) : Boolean
      {
         return param1 is SelfPlayerWalkAction;
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
         var _loc10_:* = null;
         var _loc6_:Boolean = false;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         if(!_player || !_player.info)
         {
            _isFinished = true;
            return;
         }
         if(isDirkeyDown() && (_player.localPlayer.powerRatio == 0 || _player.localPlayer.energy > 0) && _player.localPlayer.isAttacking && !_player.localPlayer.forbidMoving)
         {
            _loc10_ = _player.getNextWalkPoint(_player.info.direction);
            if(_loc10_)
            {
               _player.info.pos = _loc10_;
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
               _loc6_ = false;
               _loc8_ = _player.map.getIsCollideObj();
               _loc5_ = _player.getCollideRect();
               _loc5_.offset(_player.x,_player.y);
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  _loc7_ = _loc8_[_loc9_];
                  _loc3_ = _loc7_.getCollideRect();
                  _loc3_.offset(_loc7_.x,_loc7_.y);
                  if(_loc3_.intersects(_loc5_))
                  {
                     _loc6_ = true;
                  }
                  _loc9_++;
               }
               if(_loc6_)
               {
                  _loc4_ = _player.x + _player.info.direction * Player.MOVE_SPEED;
                  _loc1_ = new Point(_loc4_,_player.y);
                  _player.info.pos = _loc1_;
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
               _loc2_ = _player.x + _player.info.direction * Player.MOVE_SPEED;
               if(_player.canMoveDirection(_player.info.direction) && _player.canStand(_loc2_,_player.y) == false)
               {
                  _loc10_ = _player.map.findYLineNotEmptyPointDown(_loc2_,_player.y - 7,_player.map.bound.height);
                  if(_loc10_)
                  {
                     _player.act(new PlayerFallingAction(_player,_loc10_,true,false));
                     GameInSocketOut.sendGameStartMove(1,_loc10_.x,_loc10_.y,0,true,_player.map.currentTurn);
                  }
                  else if(GameControl.Instance.Current.gameMode == 56)
                  {
                     _player.act(new PlayerFallingAction(_player,new Point(_loc2_,_player.map.bound.height - 70),true,false));
                     GameInSocketOut.sendGameStartMove(1,_loc2_,_player.map.bound.height,0,true,_player.map.currentTurn);
                  }
                  else
                  {
                     _player.act(new PlayerFallingAction(_player,new Point(_loc2_,_player.map.bound.height - 70),false,false));
                     GameInSocketOut.sendGameStartMove(1,_loc2_,_player.map.bound.height,0,false,_player.map.currentTurn);
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
         var _loc1_:Rectangle = _player.getCollideRect();
         _loc1_.offset(_player.x,_player.y);
         var _loc2_:Array = _player.map.getCollidedPhysicalObjects(_loc1_,_player);
         if(_loc2_.length != 0 && _transmissionGate)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loc2_;
            for each(var _loc3_ in _loc2_)
            {
               if(_loc3_ is SimpleObject && _loc3_.layerType == 3)
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
