package gameStarling.gametrainer.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import starlingPhy.object.PhysicalObj3D;
   
   public class TrainerWeapon3D extends PhysicalObj3D
   {
       
      
      private var _weaponAsset:BoneMovieStarling;
      
      public function TrainerWeapon3D(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1){super(null,null,null,null,null,null);}
      
      private function init() : void{}
      
      override public function dispose() : void{}
   }
}
