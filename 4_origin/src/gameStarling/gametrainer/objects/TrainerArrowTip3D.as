package gameStarling.gametrainer.objects
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import starlingPhy.object.PhysicalObj3D;
   
   public class TrainerArrowTip3D extends PhysicalObj3D
   {
       
      
      private var _bannerAsset:BoneMovieStarling;
      
      public function TrainerArrowTip3D(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1)
      {
         super(param1,param2,param3,param4,param5,param6);
         init();
      }
      
      private function init() : void
      {
         _bannerAsset = BoneMovieFactory.instance.creatBoneMovie("TrainerArrowTip3D.as 23行");
         this.addChild(_bannerAsset);
      }
      
      public function play(param1:String) : void
      {
         if(_bannerAsset)
         {
            _bannerAsset.play(param1);
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
