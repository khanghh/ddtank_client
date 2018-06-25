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
      
      public function LeftRouletteGlintView(pointArray:Array)
      {
         super();
         init();
         _pointArray = pointArray;
      }
      
      private function init() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function showThreeCell(value:int) : void
      {
         var rotations:Array = new Array(0,60,120,180,240,300);
         if(value >= 0 && value <= 5)
         {
            if(_glintSp == null)
            {
               _glintSp = ComponentFactory.Instance.creat("asset.roulette.GlintAsset");
               addChild(_glintSp);
            }
            _glintSp.gotoAndPlay(1);
            _glintSp.x = _pointArray[value].x;
            _glintSp.y = _pointArray[value].y;
            _glintSp.rotation = rotations[value];
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
