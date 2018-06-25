package game.animations
{
   import game.objects.GameLiving;
   import game.objects.SimpleBomb;
   import game.view.map.MapView;
   import phy.object.PhysicalObj;
   
   public class BombFocusAnimation extends PhysicalObjFocusAnimation
   {
       
      
      protected var _phy:SimpleBomb;
      
      protected var _owner:GameLiving;
      
      public function BombFocusAnimation(phy:SimpleBomb, life:int = 100, offsetY:int = 0, owner:PhysicalObj = null)
      {
         super(phy,life,offsetY);
         _phy = phy;
         _level = 1;
         _owner = owner as GameLiving;
      }
      
      override public function update(movie:MapView) : Boolean
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
