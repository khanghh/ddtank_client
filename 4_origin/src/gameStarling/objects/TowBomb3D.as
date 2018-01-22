package gameStarling.objects
{
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameStarling.view.map.MapView3D;
   import road7th.data.DictionaryData;
   import starlingPhy.maps.Map3D;
   
   public class TowBomb3D extends SimpleBomb3D
   {
       
      
      private var _tempAction:Array;
      
      private var _tempMap:Map3D;
      
      public function TowBomb3D(param1:Bomb, param2:Living, param3:int = 0, param4:Boolean = false)
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
            _loc2_ = param1.Actions[_loc5_] as BombAction3D;
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
      
      private function actionSort(param1:BombAction3D, param2:BombAction3D) : int
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
      
      override public function setMap(param1:Map3D) : void
      {
         super.setMap(param1);
         if(param1 != null)
         {
            _tempMap = param1;
         }
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
      
      override public function bomb() : void
      {
         super.bomb();
         checkMonsterAction();
      }
      
      private function checkMonsterAction() : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:DictionaryData = new DictionaryData();
         _loc7_ = 0;
         while(_loc7_ < _tempAction.length)
         {
            _loc3_ = _tempAction[_loc7_] as BombAction3D;
            _loc1_ = _loc3_.param1;
            if(!_loc4_.hasKey(_loc1_))
            {
               _loc4_.add(_loc1_,[]);
            }
            _loc2_ = _loc4_[_loc1_];
            _loc2_.push(_loc3_);
            _loc7_++;
         }
         var _loc9_:int = 0;
         var _loc8_:* = _loc4_;
         for(var _loc6_ in _loc4_)
         {
            _loc5_ = (_tempMap as MapView3D).getPhysical(_loc6_) as GameLiving3D;
            if(_loc5_)
            {
               _loc5_.startAction(_loc4_[_loc6_]);
            }
         }
         _loc4_.clear();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _tempAction = null;
      }
   }
}
