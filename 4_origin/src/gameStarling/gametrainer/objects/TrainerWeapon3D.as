package gameStarling.gametrainer.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import starlingPhy.object.PhysicalObj3D;
   
   public class TrainerWeapon3D extends PhysicalObj3D
   {
       
      
      private var _weaponAsset:BoneMovieStarling;
      
      public function TrainerWeapon3D(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,layerType,mass,gravityFactor,windFactor,airResitFactor);
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
