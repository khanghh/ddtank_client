package gameStarling.objects
{
   import com.greensock.TweenLite;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class PhantomBomb3D extends SimpleBomb3D
   {
       
      
      private var _phantomCount:int;
      
      private var _currentBombActions:Array;
      
      private var _maxTime:Number = 0;
      
      private var _tweenVec:Array;
      
      public function PhantomBomb3D(param1:Bomb, param2:Living, param3:int = 0)
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _tweenVec = [];
         super(param1,param2,param3);
         _currentBombActions = [];
         _loc5_ = 0;
         while(_loc5_ < _info.Actions.length)
         {
            _loc4_ = _info.Actions[_loc5_] as BombAction3D;
            if(_loc4_.type == 2 || _loc4_.type == 4)
            {
               _maxTime = _loc4_.time;
               _currentBombActions.push(_loc4_);
            }
            else if(_loc4_.type == 23)
            {
               _currentBombActions.push(_loc4_);
            }
            _loc5_++;
         }
         if(_maxTime > 0)
         {
            _phantomCount = int((_maxTime - 2500) / 500);
         }
      }
      
      override public function moveTo(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         super.moveTo(param1);
         if(_lifeTime % 80 == 0)
         {
            if(_phantomCount > 0)
            {
               _loc2_ = new Bomb();
               ObjectUtils.copyProperties(_loc2_,_info);
               _loc2_.Template = _info.Template;
               _loc2_.Actions = _currentBombActions.concat();
               _loc3_ = new SimpleBomb3D(_loc2_,_owner,_refineryLevel,true);
               _loc3_.alpha = 0.2;
               this.map.addPhysical(_loc3_);
               if(fastModel)
               {
                  _loc3_.bombAtOnce();
               }
               changeAlphaPlay(_loc3_,_maxTime);
            }
            _phantomCount = Number(_phantomCount) - 1;
         }
      }
      
      private function changeAlphaPlay(param1:SimpleBomb3D, param2:Number) : void
      {
         TweenLite.to(param1,param2 / 1000,{"alpha":0.9});
         _tweenVec.push(param1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         if(_tweenVec)
         {
            _loc1_ = 0;
            while(_loc1_ < _tweenVec.length)
            {
               TweenLite.killTweensOf(_tweenVec[_loc1_]);
               _loc1_++;
            }
            _tweenVec = null;
         }
      }
   }
}
