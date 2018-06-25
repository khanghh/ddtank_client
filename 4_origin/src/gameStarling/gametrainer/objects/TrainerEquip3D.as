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
      
      public function TrainerEquip3D(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,layerType,mass,gravityFactor,windFactor,airResitFactor);
         init();
      }
      
      private function init() : void
      {
         var str:String = !!PlayerManager.Instance.Self.Sex?"asset.trainer.TrainerManEquipAsset":"asset.trainer.TrainerWomanEquipAsset";
         _equip = BoneMovieFactory.instance.creatBoneMovie("TrainerEquip3D.as 23行");
         addChild(_equip);
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(_equip);
         _equip = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
