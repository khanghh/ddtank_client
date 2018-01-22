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
      
      public function TrainerEquip3D(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1)
      {
         super(param1,param2,param3,param4,param5,param6);
         init();
      }
      
      private function init() : void
      {
         var _loc1_:String = !!PlayerManager.Instance.Self.Sex?"asset.trainer.TrainerManEquipAsset":"asset.trainer.TrainerWomanEquipAsset";
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
