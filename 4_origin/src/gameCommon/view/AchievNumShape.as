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
      
      public function drawNum(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:BitmapShape = _numShapes.shift();
         while(_loc4_ != null)
         {
            ObjectUtils.disposeObject(_loc4_);
            _loc4_ = _numShapes.shift();
         }
         var _loc2_:String = param1.toString();
         var _loc3_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _bitmapMgr.creatBitmapShape("asset.game.achiev.num" + _loc2_.substr(_loc5_,1));
            if(_loc5_ > 0)
            {
               _loc4_.x = _numShapes[_loc5_ - 1].x + _numShapes[_loc5_ - 1].width;
            }
            addChild(_loc4_);
            _numShapes.push(_loc4_);
            _loc5_++;
         }
         visible = true;
      }
   }
}
