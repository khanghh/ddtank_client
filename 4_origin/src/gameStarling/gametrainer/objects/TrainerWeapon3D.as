package gameStarling.gametrainer.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import starlingPhy.object.PhysicalObj3D;
   
   public class TrainerWeapon3D extends PhysicalObj3D
   {
       
      
      private var _weaponAsset:BoneMovieStarling;
      
      public function TrainerWeapon3D(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1)
      {
         super(param1,param2,param3,param4,param5,param6);
         init();
      }
      
      private function init() : void
      {
         _weaponAsset = BoneMovieFactory.instance.creatBoneMovie("TrainerWeapon3D.as 28行");
         addChild(_weaponAsset);
      }
      
      override public function dispose() : void
      {
         if(_weaponAsset && _weaponAsset.parent)
         {
            _weaponAsset.parent.removeChild(_weaponAsset);
         }
         _weaponAsset = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
