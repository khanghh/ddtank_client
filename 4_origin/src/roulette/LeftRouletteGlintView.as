package roulette
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class LeftRouletteGlintView extends Sprite implements Disposeable
   {
       
      
      private var _pointArray:Array;
      
      private var _glintSp:MovieClip;
      
      public function LeftRouletteGlintView(param1:Array)
      {
         super();
         init();
         _pointArray = param1;
      }
      
      private function init() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function showThreeCell(param1:int) : void
      {
         var _loc2_:Array = new Array(0,60,120,180,240,300);
         if(param1 >= 0 && param1 <= 5)
         {
            if(_glintSp == null)
            {
               _glintSp = ComponentFactory.Instance.creat("asset.roulette.GlintAsset");
               addChild(_glintSp);
            }
            _glintSp.gotoAndPlay(1);
            _glintSp.x = _pointArray[param1].x;
            _glintSp.y = _pointArray[param1].y;
            _glintSp.rotation = _loc2_[param1];
            _glintSp.visible = true;
         }
      }
      
      public function stopGlint() : void
      {
         if(_glintSp)
         {
            _glintSp.gotoAndStop(1);
            _glintSp.visible = false;
         }
      }
      
      public function dispose() : void
      {
         if(_glintSp)
         {
            removeChild(_glintSp);
         }
         _glintSp = null;
      }
   }
}
