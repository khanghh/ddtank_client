package game.gametrainer.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import phy.object.PhysicalObj;
   
   public class TrainerArrowTip extends PhysicalObj
   {
       
      
      private var _bannerAsset:MovieClip;
      
      public function TrainerArrowTip(param1:int, param2:int = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1, param6:Number = 1)
      {
         super(param1,param2,param3,param4,param5,param6);
         init();
      }
      
      private function init() : void
      {
         _bannerAsset = ComponentFactory.Instance.creat("asset.trainer.TrainerArrowAsset");
         this.addChild(_bannerAsset);
      }
      
      public function gotoAndStopII(param1:int) : void
      {
         if(_bannerAsset)
         {
            _bannerAsset.gotoAndStop(param1);
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
