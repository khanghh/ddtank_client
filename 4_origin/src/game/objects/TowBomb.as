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
      
      public function TowBomb(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
      {
         initData(param1);
         super(param1,param2,param3,param4);
      }
      
      private function initData(param1:Bomb) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Array = [];
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param1.Actions.length)
         {
            _loc2_ = param1.Actions[_loc5_] as BombAction;
            if(_loc2_.type == 25 || _loc2_.type == 26 || _loc2_.type == 5 || _loc2_.type == 29)
            {
               _loc4_.push(_loc2_);
            }
            else
            {
               _loc3_.push(param1.Actions[_loc5_]);
            }
            _loc5_++;
         }
         _loc4_.sort(actionSort);
         _tempAction = _loc4_;
         param1.Actions = _loc3_;
      }
      
      private function actionSort(param1:BombAction, param2:BombAction) : int
      {
         if(param1.time < param2.time)
         {
            return -1;
         }
         if(param1.time == param2.time)
         {
            if(param1.type == 23)
            {
               return -1;
            }
            if(param1.type == 5)
            {
               return 1;
            }
            if(param1.type == 25 || param1.type == 26 || param1.type == 5 || param1.type == 29)
            {
               if(param2.type == 26 || param2.type == 25 || param2.type == 5 || param1.type == 29)
               {
                  if(param1.param4 > param2.param4)
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
      
      override public function setMap(param1:Map) : void
      {
         super.setMap(param1);
         _tempMap = param1;
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
