package starling.scene.consortiaDomain.buildView
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import starling.display.Sprite;
   
   public class UpStateIconSp extends Sprite
   {
       
      
      private var _state:int = -1;
      
      private var _upgradeAni:BoneMovieFastStarling;
      
      private var _fightAni:BoneMovieFastStarling;
      
      public function UpStateIconSp()
      {
         super();
      }
      
      public function set state(param1:int) : void
      {
         var _loc2_:* = null;
         if(_state != param1)
         {
            clear();
            if(param1 != 1)
            {
               if(param1 == 2)
               {
                  _upgradeAni = BoneMovieFactory.instance.creatBoneMovieFast("consortiaDomainBuildStateIconUpgrade");
                  addChild(_upgradeAni);
               }
               else if(param1 == 3 || param1 == 4)
               {
                  _loc2_ = new RepairAni();
                  _loc2_.x = -17;
                  _loc2_.y = -26;
                  addChild(_loc2_);
                  if(param1 == 3)
                  {
                     _loc2_.startRepair();
                  }
               }
               else if(param1 == 6)
               {
                  _fightAni = BoneMovieFactory.instance.creatBoneMovieFast("consortiaDomainBuildStateIconFight");
                  addChild(_fightAni);
               }
            }
            _state = param1;
         }
      }
      
      private function clear() : void
      {
         removeChildren(0,-1,true);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _upgradeAni = null;
         _fightAni = null;
      }
   }
}
