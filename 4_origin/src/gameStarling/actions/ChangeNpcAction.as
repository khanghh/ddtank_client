package gameStarling.actions
{
   import ddt.data.PathInfo;
   import ddt.events.CrazyTankSocketEvent;
   import gameCommon.GameControl;
   import gameCommon.actions.BaseAction;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameCommon.model.SmallEnemy;
   import gameStarling.objects.GameSmallEnemy3D;
   import gameStarling.objects.SimpleBox3D;
   import gameStarling.view.GameView3D;
   import gameStarling.view.map.MapView3D;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class ChangeNpcAction extends BaseAction
   {
       
      
      private var _gameView:GameView3D;
      
      private var _map:MapView3D;
      
      private var _info:Living;
      
      private var _pkg:PackageIn;
      
      private var _event:CrazyTankSocketEvent;
      
      private var _ignoreSmallEnemy:Boolean;
      
      public function ChangeNpcAction(game:GameView3D, map:MapView3D, info:Living, event:CrazyTankSocketEvent, sysMap:PackageIn, ignoreSmallEnemy:Boolean)
      {
         super();
         _gameView = game;
         _event = event;
         _event.executed = false;
         _pkg = sysMap;
         _map = map;
         _info = info;
         _ignoreSmallEnemy = ignoreSmallEnemy;
      }
      
      private function syncMap() : void
      {
         var windDic:Boolean = false;
         var windPowerNum0:int = 0;
         var windPowerNum1:int = 0;
         var windPowerNum2:int = 0;
         var weatherLevel:int = 0;
         var weatherRate:Number = NaN;
         var weatherRotation:int = 0;
         var windNumArr:* = null;
         var count:int = 0;
         var i:* = 0;
         var bid:int = 0;
         var bx:int = 0;
         var by:int = 0;
         var subType:* = 0;
         var box:* = null;
         var isOutCrater:Boolean = false;
         var outBombsLength:int = 0;
         var outBombs:* = null;
         var k:int = 0;
         var bomb:* = null;
         if(_pkg)
         {
            windDic = _pkg.readBoolean();
            windPowerNum0 = _pkg.readByte();
            windPowerNum1 = _pkg.readByte();
            windPowerNum2 = _pkg.readByte();
            weatherLevel = _pkg.readInt();
            weatherRate = _pkg.readInt() / 100;
            weatherRotation = _pkg.readInt();
            windNumArr = [windDic,windPowerNum0,windPowerNum1,windPowerNum2,weatherLevel,weatherRotation];
            GameControl.Instance.Current.setWind(GameControl.Instance.Current.wind,false,windNumArr);
            _pkg.readBoolean();
            _pkg.readInt();
            count = _pkg.readInt();
            for(i = uint(0); i < count; )
            {
               bid = _pkg.readInt();
               bx = _pkg.readInt();
               by = _pkg.readInt();
               subType = uint(_pkg.readInt());
               box = new SimpleBox3D(bid,String(PathInfo.GAME_BOXPIC),subType);
               box.x = bx;
               box.y = by;
               _map.addPhysical(box);
               i++;
            }
            isOutCrater = _pkg.readBoolean();
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
      }
      
      private function updateNpc() : void
      {
         if(GameControl.Instance.Current == null)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = GameControl.Instance.Current.livings;
         for each(var p in GameControl.Instance.Current.livings)
         {
            p.beginNewTurn();
         }
         _map.cancelFocus();
         _gameView.setCurrentPlayer(_info);
         if(!_map.smallMap.locked)
         {
            focusOnSmallEnemy();
         }
         if(!_ignoreSmallEnemy)
         {
            _ignoreSmallEnemy = true;
            _gameView.updateControlBarState(GameControl.Instance.Current.selfGamePlayer);
            return;
         }
      }
      
      private function getClosestEnemy() : SmallEnemy
      {
         var result:* = null;
         var instance:int = -1;
         var x:int = GameControl.Instance.Current.selfGamePlayer.pos.x;
         var _loc6_:int = 0;
         var _loc5_:* = GameControl.Instance.Current.livings;
         for each(var p in GameControl.Instance.Current.livings)
         {
            if(p is SmallEnemy && p.isLiving && p.typeLiving != 3)
            {
               if(instance == -1 || Math.abs(p.pos.x - x) < instance)
               {
                  instance = Math.abs(p.pos.x - x);
                  result = p as SmallEnemy;
               }
            }
         }
         return result;
      }
      
      private function focusOnSmallEnemy() : void
      {
         var closestEnemy:SmallEnemy = getClosestEnemy();
         if(closestEnemy)
         {
            if(closestEnemy.LivingID && _map.getPhysical(closestEnemy.LivingID))
            {
               (_map.getPhysical(closestEnemy.LivingID) as GameSmallEnemy3D).needFocus();
               _map.currentFocusedLiving = _map.getPhysical(closestEnemy.LivingID) as GameSmallEnemy3D;
            }
         }
      }
      
      override public function execute() : void
      {
         _event.executed = true;
         syncMap();
         updateNpc();
         _isFinished = true;
      }
   }
}
