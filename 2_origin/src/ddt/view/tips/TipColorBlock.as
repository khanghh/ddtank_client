package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TipColorBlock extends Sprite
   {
       
      
      private var sp:Sprite;
      
      private var colorBoard:Bitmap;
      
      public function TipColorBlock(param1:uint)
      {
         super();
         addChild(ComponentFactory.Instance.creat("asset.core.tip.color"));
         colorBoard = ComponentFactory.Instance.creat("asset.core.tip.ColorPiece");
         addChild(colorBoard);
         sp = new Sprite();
         sp.graphics.clear();
         sp.graphics.beginFill(param1,1);
         sp.graphics.drawRect(0,0,14,14);
         sp.graphics.endFill();
         sp.x = colorBoard.x + 1;
         sp.y = colorBoard.y + 1;
         addChild(sp);
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
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
