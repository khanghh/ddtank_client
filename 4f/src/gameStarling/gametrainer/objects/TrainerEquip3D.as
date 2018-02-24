package gameStarling.gametrainer.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.manager.PlayerManager;
   import starlingPhy.object.PhysicalObj3D;
   
   public class TrainerEquip3D extends PhysicalObj3D
   {
       
      
      private var _equip:BoneMovieStarling;
      
      public function TrainerEquip3D(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1){super(null,null,null,null,null,null);}
      
      private function init() : void{}
      
      override public function dispose() : void{}
   }
}
