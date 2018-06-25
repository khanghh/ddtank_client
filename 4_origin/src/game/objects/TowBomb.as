package game.objects
{
   import flash.geom.Point;
   import game.view.map.MapView;
   import gameCommon.model.Bomb;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import phy.maps.Map;
   import phy.object.PhysicalObj;
   
   public class TowBomb extends SimpleBomb
   {
       
      
      private var _tempAction:Array;
      
      private var _tempMap:Map;
      
      public function TowBomb(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         initData(info);
         super(info,owner,refineryLevel,isPhantom);
      }
      
      private function initData(info:Bomb) : void
      {
         var i:int = 0;
         var tempAction:* = null;
         var arr1:Array = [];
         var arr2:Array = [];
         for(i = 0; i < info.Actions.length; )
         {
            tempAction = info.Actions[i] as BombAction;
            if(tempAction.type == 25 || tempAction.type == 26 || tempAction.type == 5 || tempAction.type == 29)
            {
               arr1.push(tempAction);
            }
            else
            {
               arr2.push(info.Actions[i]);
            }
            i++;
         }
         arr1.sort(actionSort);
         _tempAction = arr1;
         info.Actions = arr2;
      }
      
      private function actionSort(a:BombAction, b:BombAction) : int
      {
         if(a.time < b.time)
         {
            return -1;
         }
         if(a.time == b.time)
         {
            if(a.type == 23)
            {
               return -1;
            }
            if(a.type == 5)
            {
               return 1;
            }
            if(a.type == 25 || a.type == 26 || a.type == 5 || a.type == 29)
            {
               if(b.type == 26 || b.type == 25 || b.type == 5 || a.type == 29)
               {
                  if(a.param4 > b.param4)
                  {
                     return 1;
                  }
                  return -1;
               }
               return -1;
            }
         }
         return 1;
      }
      
      override public function setMap(map:Map) : void
      {
         super.setMap(map);
         _tempMap = map;
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
      
      override public function bomb() : void
      {
         super.bomb();
         exeTempAction();
      }
      
      private function exeTempAction() : void
      {
         if(_tempAction && _tempMap && _tempAction.length > 0)
         {
            var tempAction:BombAction = _tempAction.shift();
            var param1:int = tempAction.param1;
            var param2:int = tempAction.param2;
            var param3:int = tempAction.param3;
            var param4:int = tempAction.param4;
            var mapView:MapView = _tempMap as MapView;
            var gameInfo:GameInfo = mapView.gameInfo;
            if(tempAction.type == 25)
            {
               var moveInfo1:PhysicalObj = mapView.getPhysical(param1);
               if(moveInfo1 is GameLiving)
               {
                  (moveInfo1 as GameLiving).setProperty("speedMult","8");
               }
               var moveInfo2:Living = gameInfo.findLiving(param1);
               if(moveInfo2)
               {
                  if(param2 > moveInfo2.pos.x)
                  {
                     moveInfo2.direction = 1;
                  }
                  else if(param2 < moveInfo2.pos.x)
                  {
                     moveInfo2.direction = -1;
                  }
                  var backFun:Function = function():void
                  {
                     (moveInfo1 as GameLiving).setProperty("speedMult","1");
                     exeTempAction();
                  };
                  var params1:Array = [4,new Point(param2,param3),moveInfo2.direction,true,null,backFun];
                  (moveInfo1 as GameLiving).playerMoveTo(params1);
               }
            }
            else if(tempAction.type == 26)
            {
               var fallingInfo1:Living = gameInfo.findLiving(param1);
               var fallingInfo2:PhysicalObj = mapView.getPhysical(param1);
               if(fallingInfo1 || fallingInfo2 is GameLiving)
               {
                  var params2:Array = [1,new Point(param2,param3),fallingInfo1.direction,true,null,exeTempAction];
                  (fallingInfo2 as GameLiving).playerMoveTo(params2);
               }
            }
            else if(tempAction.type == 29)
            {
               var fallingDie1:Living = gameInfo.findLiving(param1);
               var fallingDie2:PhysicalObj = mapView.getPhysical(param1);
               if(fallingDie1 || fallingDie2 is GameLiving)
               {
                  var params3:Array = [1,new Point(param2,param3),fallingDie1.direction,false];
                  (fallingDie2 as GameLiving).playerMoveTo(params3);
               }
            }
            else if(tempAction.type == 5)
            {
               var player:Living = gameInfo.findLiving(param1);
               if(player)
               {
                  player.updateBlood(param4,param3,0 - param2);
                  player.isHidden = false;
               }
               exeTempAction();
            }
         }
         else
         {
            _tempAction = null;
            _tempMap = null;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
