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
      
      public function ChangePlayerAction(map:MapView, info:Living, event:CrazyTankSocketEvent, sysMap:PackageIn, waitTime:Number = 200, turnTime:int = -1)
      {
         super();
         _event = event;
         _event.executed = false;
         _pkg = sysMap;
         _map = map;
         _info = info;
         _count = waitTime / 40;
         _turnTime = turnTime;
      }
      
      private function syncMap() : void
      {
         var localPlayer:* = null;
         var i:* = 0;
         var bid:int = 0;
         var bx:int = 0;
         var by:int = 0;
         var subType:int = 0;
         var box:* = null;
         var j:int = 0;
         var livingID:int = 0;
         var isLiving:Boolean = false;
         var tx:int = 0;
         var ty:int = 0;
         var blood:int = 0;
         var nonole:Boolean = false;
         var maxEnergy:int = 0;
         var psychic:int = 0;
         var dander:int = 0;
         var petMaxMP:int = 0;
         var petMP:int = 0;
         var shootCount:int = 0;
         var flyCount:int = 0;
         var turnCount:int = 0;
         var player:* = null;
         var outBombsLength:int = 0;
         var outBombs:* = null;
         var k:int = 0;
         var bomb:* = null;
         var windDic:Boolean = _pkg.readBoolean();
         var windPowerNum0:int = _pkg.readByte();
         var windPowerNum1:int = _pkg.readByte();
         var windPowerNum2:int = _pkg.readByte();
         var weatherLevel:int = _pkg.readInt();
         var weatherRate:Number = _pkg.readInt() / 100;
         var weatherRotation:int = _pkg.readInt();
         var windNumArr:Array = [windDic,windPowerNum0,windPowerNum1,windPowerNum2,weatherLevel,weatherRotation];
         GameControl.Instance.Current.setWind(GameControl.Instance.Current.wind,_info.LivingID == GameControl.Instance.Current.selfGamePlayer.LivingID,windNumArr);
         _info.isHidden = _pkg.readBoolean();
         var turnTime:int = _pkg.readInt();
         if(_info is LocalPlayer)
         {
            localPlayer = LocalPlayer(_info);
            if(_turnTime == -1)
            {
               if(turnTime > 0)
               {
                  localPlayer.turnTime = turnTime;
               }
               else
               {
                  localPlayer.turnTime = RoomManager.getTurnTimeByType(RoomManager.Instance.current.timeType);
               }
            }
            else
            {
               localPlayer.turnTime = _turnTime;
               GameInSocketOut.sendGameSkipNext(0);
            }
            if(turnTime == RoomManager.getTurnTimeByType(RoomManager.Instance.current.timeType))
            {
            }
         }
         var boxCount:int = _pkg.readInt();
         for(i = uint(0); i < boxCount; )
         {
            bid = _pkg.readInt();
            bx = _pkg.readInt();
            by = _pkg.readInt();
            subType = _pkg.readInt();
            box = new SimpleBox(bid,String(PathInfo.GAME_BOXPIC),subType);
            box.x = bx;
            box.y = by;
            _map.addPhysical(box);
            i++;
         }
         var playerCount:int = _pkg.readInt();
         for(j = 0; j < playerCount; )
         {
            livingID = _pkg.readInt();
            isLiving = _pkg.readBoolean();
            tx = _pkg.readInt();
            ty = _pkg.readInt();
            blood = _pkg.readInt();
            nonole = _pkg.readBoolean();
            maxEnergy = _pkg.readInt();
            psychic = _pkg.readInt();
            dander = _pkg.readInt();
            petMaxMP = _pkg.readInt();
            petMP = _pkg.readInt();
            shootCount = _pkg.readInt();
            flyCount = _pkg.readInt();
            turnCount = _pkg.readInt();
            player = GameControl.Instance.Current.livings[livingID];
            if(player)
            {
               if(!player.isLiving && isLiving)
               {
                  (_map.gameView as GameView).revivePlayerChangePlayer(player.LivingID);
               }
               player.updateBlood(blood,5);
               player.isNoNole = nonole;
               player.maxEnergy = maxEnergy;
               player.psychic = psychic;
               player.turnCount = turnCount;
               if(player.isSelf)
               {
                  localPlayer = LocalPlayer(player);
                  localPlayer.energy = player.maxEnergy;
                  localPlayer.shootCount = shootCount;
                  localPlayer.dander = dander;
                  if(localPlayer.currentPet)
                  {
                     localPlayer.currentPet.MaxMP = petMaxMP;
                     localPlayer.currentPet.MP = petMP;
                  }
                  localPlayer.soulPropCount = 0;
                  localPlayer.flyCount = flyCount;
               }
               if(!isLiving)
               {
                  player.die();
               }
               else
               {
                  player.onChange = false;
                  player.pos = new Point(tx,ty);
                  player.onChange = true;
               }
            }
            j++;
         }
         _map.currentTurn = _pkg.readInt();
         var isOutCrater:Boolean = _pkg.readBoolean();
         if(isOutCrater)
         {
            outBombsLength = _pkg.readInt();
            outBombs = new DictionaryData();
            for(k = 0; k < outBombsLength; )
            {
               bomb = new Bomb();
               bomb.Id = _pkg.readInt();
               bomb.X = _pkg.readInt();
               bomb.Y = _pkg.readInt();
               outBombs.add(k,bomb);
               k++;
            }
            _map.DigOutCrater(outBombs);
         }
      }
      
      override public function execute() : void
      {
         if(!_changed)
         {
            if(_map.hasSomethingMoving() == false && (_map.currentPlayer == null || _map.currentPlayer.actionCount == 0))
            {
               executeImp(false);
            }
         }
         else
         {
            _count = Number(_count) - 1;
            if(_count <= 0)
            {
               changePlayer();
            }
         }
      }
      
      private function changePlayer() : void
      {
         if(_info is TurnedLiving && !BombKingManager.instance.Recording)
         {
            TurnedLiving(_info).isAttacking = true;
         }
         _map.gameView.updateControlBarState(_info);
         _isFinished = true;
      }
      
      override public function cancel() : void
      {
         _event.executed = true;
      }
      
      private function executeImp(fastModel:Boolean) : void
      {
         var gameLiving:* = null;
         var _turnMovie:* = null;
         if(!_info.isExist)
         {
            _isFinished = true;
            _map.gameView.updateControlBarState(null);
            return;
         }
         if(!_changed)
         {
            _event.executed = true;
            _changed = true;
            if(_pkg)
            {
               syncMap();
            }
            var _loc6_:* = 0;
            var _loc5_:* = GameControl.Instance.Current.livings;
            for each(var p in GameControl.Instance.Current.livings)
            {
               p.beginNewTurn();
            }
            _map.gameView.setCurrentPlayer(_info);
            gameLiving = _map.getPhysical(_info.LivingID) as GameLiving;
            if(gameLiving)
            {
               gameLiving.needFocus(0,0,{"priority":3});
            }
            else
            {
               trace("ChangePlayerAction->infoLivingID:" + _info.LivingID + " 未在map.getPhysical方法中找到！");
            }
            _info.gemDefense = false;
            if(_info is LocalPlayer && !fastModel && !BombKingManager.instance.Recording)
            {
               KeyboardManager.getInstance().reset();
               SoundManager.instance.play("016");
               _turnMovie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.game.TurnAsset")),true,true);
               _turnMovie.repeat = false;
               _loc6_ = false;
               _turnMovie.movie.mouseEnabled = _loc6_;
               _turnMovie.movie.mouseChildren = _loc6_;
               _turnMovie.movie.x = 440;
               _turnMovie.movie.y = 180;
               _map.gameView.addChild(_turnMovie.movie);
            }
            else
            {
               SoundManager.instance.play("038");
               changePlayer();
            }
         }
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         executeImp(false);
         changePlayer();
      }
   }
}
