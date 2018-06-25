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
      
      public function set state(value:int) : void
      {
         var repairAni:* = null;
         if(_state != value)
         {
            clear();
            if(value != 1)
            {
               if(value == 2)
               {
                  _upgradeAni = BoneMovieFactory.instance.creatBoneMovieFast("consortiaDomainBuildStateIconUpgrade");
                  addChild(_upgradeAni);
               }
               else if(value == 3 || value == 4)
               {
                  repairAni = new RepairAni();
                  repairAni.x = -17;
                  repairAni.y = -26;
                  addChild(repairAni);
                  if(value == 3)
                  {
                     repairAni.startRepair();
                  }
               }
               else if(value == 6)
               {
                  _fightAni = BoneMovieFactory.instance.creatBoneMovieFast("consortiaDomainBuildStateIconFight");
                  addChild(_fightAni);
               }
            }
            _state = value;
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
