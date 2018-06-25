package game.gametrainer.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import phy.object.PhysicalObj;
   
   public class TrainerArrowTip extends PhysicalObj
   {
       
      
      private var _bannerAsset:MovieClip;
      
      public function TrainerArrowTip(id:int, layerType:int = 1, mass:Number = 1, gravityFactor:Number = 1, windFactor:Number = 1, airResitFactor:Number = 1)
      {
         super(id,layerType,mass,gravityFactor,windFactor,airResitFactor);
         init();
      }
      
      private function init() : void
      {
         _bannerAsset = ComponentFactory.Instance.creat("asset.trainer.TrainerArrowAsset");
         this.addChild(_bannerAsset);
      }
      
      public function gotoAndStopII(I:int) : void
      {
         if(_bannerAsset)
         {
            _bannerAsset.gotoAndStop(I);
         }
      }
      
      override public function dispose() : void
      {
         if(_bannerAsset)
         {
            if(_bannerAsset.parent)
            {
               _bannerAsset.parent.removeChild(_bannerAsset);
            }
         }
         _bannerAsset = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
