package gameStarling.animations
{
   import gameStarling.objects.GameLiving3D;
   import gameStarling.objects.SimpleBomb3D;
   import gameStarling.view.map.MapView3D;
   import phy.object.PhysicalObj;
   
   public class BombFocusAnimation extends PhysicalObjFocusAnimation
   {
       
      
      protected var _phy:SimpleBomb3D;
      
      protected var _owner:GameLiving3D;
      
      public function BombFocusAnimation(phy:SimpleBomb3D, life:int = 100, offsetY:int = 0, owner:PhysicalObj = null)
      {
         super(phy,life,offsetY);
         _phy = phy;
         _level = 1;
         _owner = owner as GameLiving3D;
      }
      
      override public function update(movie:MapView3D) : Boolean
      {
         var distanceTotal:Number = NaN;
         var distance:Number = NaN;
         var progress:Number = NaN;
         var targetScale:Number = NaN;
         var minTargetScale:Number = NaN;
         var minScale:Number = NaN;
         var scale:Number = NaN;
         var zoomInProcedure:Number = NaN;
         var zoomOutProcedure:Number = NaN;
         return super.update(movie);
      }
      
      private function smoothDown(start:Number, target:Number, progress:Number) : Number
      {
         progress = Math.sqrt(progress);
         var smooth:Number = (target - start) * progress;
         return start + smooth;
      }
      
      private function smoothUp(start:Number, target:Number, progress:Number) : Number
      {
         progress = progress * progress;
         var smooth:Number = (target - start) * progress;
         return start + smooth;
      }
   }
}
