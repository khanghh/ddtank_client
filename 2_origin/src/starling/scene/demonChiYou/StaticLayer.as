package starling.scene.demonChiYou
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import bones.display.BoneMovieStarling;
   import demonChiYou.DemonChiYouManager;
   import starling.display.Sprite;
   
   public class StaticLayer extends Sprite
   {
       
      
      private var _bgLayer:BgLayer;
      
      private var _promptMovie:BoneMovieStarling;
      
      public function StaticLayer()
      {
         var _loc2_:* = null;
         super();
         _bgLayer = new BgLayer();
         addChild(_bgLayer);
         if(!DemonChiYouManager.instance.hasShowPromptMC)
         {
            _loc2_ = BoneMovieFactory.instance.creatBoneMovieFast("demon_chi_you_prompt");
            addChild(_loc2_);
            DemonChiYouManager.instance.hasShowPromptMC = true;
         }
         var _loc1_:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast("demon_chi_you");
         addChild(_loc1_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _bgLayer = null;
      }
   }
}
