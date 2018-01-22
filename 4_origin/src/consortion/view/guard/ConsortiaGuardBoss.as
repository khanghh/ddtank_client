package consortion.view.guard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ConsortiaGuardBoss extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _location:Point;
      
      public function ConsortiaGuardBoss(param1:int)
      {
         super();
         _index = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc1_:Rectangle = ComponentFactory.Instance.creatCustomObject("consortiaGuard.bossRect" + _index);
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,0);
         _loc2_.graphics.drawRect(0,0,_loc1_.width,_loc1_.height);
         _loc2_.graphics.endFill();
         this.buttonMode = true;
         this.x = _loc1_.x;
         this.y = _loc1_.y;
         addChild(_loc2_);
         _location = ComponentFactory.Instance.creatCustomObject("consortiaGuard.bossLocationPos" + _index);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get location() : Point
      {
         return _location;
      }
      
      public function dispose() : void
      {
         _location = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
