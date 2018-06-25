package gameCommon.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.display.BitmapShape;
   import ddt.manager.BitmapManager;
   import flash.display.Sprite;
   
   public class AchievNumShape extends Sprite implements Disposeable
   {
       
      
      private var _bitmapMgr:BitmapManager;
      
      private var _numShapes:Vector.<BitmapShape>;
      
      public function AchievNumShape()
      {
         _numShapes = new Vector.<BitmapShape>();
         super();
         mouseEnabled = false;
         mouseChildren = false;
         visible = false;
         _bitmapMgr = BitmapManager.getBitmapMgr("GameView");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bitmapMgr);
         _bitmapMgr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function drawNum(num:int) : void
      {
         var i:int = 0;
         var shape:BitmapShape = _numShapes.shift();
         while(shape != null)
         {
            ObjectUtils.disposeObject(shape);
            shape = _numShapes.shift();
         }
         var numStr:String = num.toString();
         var len:int = numStr.length;
         for(i = 0; i < len; )
         {
            shape = _bitmapMgr.creatBitmapShape("asset.game.achiev.num" + numStr.substr(i,1));
            if(i > 0)
            {
               shape.x = _numShapes[i - 1].x + _numShapes[i - 1].width;
            }
            addChild(shape);
            _numShapes.push(shape);
            i++;
         }
         visible = true;
      }
   }
}
