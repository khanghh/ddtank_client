package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TipColorBlock extends Sprite
   {
       
      
      private var sp:Sprite;
      
      private var colorBoard:Bitmap;
      
      public function TipColorBlock(color:uint)
      {
         super();
         addChild(ComponentFactory.Instance.creat("asset.core.tip.color"));
         colorBoard = ComponentFactory.Instance.creat("asset.core.tip.ColorPiece");
         addChild(colorBoard);
         sp = new Sprite();
         sp.graphics.clear();
         sp.graphics.beginFill(color,1);
         sp.graphics.drawRect(0,0,14,14);
         sp.graphics.endFill();
         sp.x = colorBoard.x + 1;
         sp.y = colorBoard.y + 1;
         addChild(sp);
      }
      
      public function move(x:Number, y:Number) : void
      {
         this.x = x;
         this.y = y;
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            removeChild(sp);
            removeChild(colorBoard);
            sp = null;
            colorBoard = null;
            parent.removeChild(this);
         }
      }
   }
}
