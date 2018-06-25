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
      
      public function ConsortiaGuardBoss(index:int)
      {
         super();
         _index = index;
         init();
      }
      
      private function init() : void
      {
         var rect:Rectangle = ComponentFactory.Instance.creatCustomObject("consortiaGuard.bossRect" + _index);
         var spr:Shape = new Shape();
         spr.graphics.beginFill(16711680,0);
         spr.graphics.drawRect(0,0,rect.width,rect.height);
         spr.graphics.endFill();
         this.buttonMode = true;
         this.x = rect.x;
         this.y = rect.y;
         addChild(spr);
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
