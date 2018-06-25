package gameStarling.gametrainer.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import starlingPhy.object.PhysicalObj3D;
   
   public class TrainerArrowTip3D extends PhysicalObj3D
   {
       
      
      private var _bannerAsset:BoneMovieStarling;
      
      public function TrainerArrowTip3D(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,layerType,mass,gravityFactor,windFactor,airResitFactor);
         init();
      }
      
      private function init() : void
      {
         _bannerAsset = BoneMovieFactory.instance.creatBoneMovie("TrainerArrowTip3D.as 23行");
         this.addChild(_bannerAsset);
      }
      
      public function play(action:String) : void
      {
         if(_bannerAsset)
         {
            _bannerAsset.play(action);
         }
      }
      
      override public function dispose() : void
      {
         StarlingObjectUtils.disposeObject(_bannerAsset);
         _bannerAsset = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
