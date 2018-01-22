package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.setTimeout;
   
   public class WorldBossCutHpMC extends Sprite
   {
      
      public static const _space:int = 19;
       
      
      private var _num:Number;
      
      private var _type:int;
      
      private var _numBitmapArr:Array;
      
      public function WorldBossCutHpMC(param1:Number)
      {
         super();
         _num = Math.abs(param1);
         init();
      }
      
      private function init() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _numBitmapArr = [];
         var _loc3_:String = _num.toString();
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("worldboss.cutHP.valuNum10");
         _numBitmapArr.push(_loc2_);
         _loc2_.alpha = 0;
         _loc2_.scaleX = 0.5;
         addChild(_loc2_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("worldboss.cutHP.valuNum" + _loc3_.charAt(_loc4_));
            _loc1_.x = 19 * (_loc4_ + 1);
            _loc1_.alpha = 0;
            _loc1_.scaleX = 0.5;
            _numBitmapArr.push(_loc1_);
            addChild(_loc1_);
            _loc4_++;
         }
         addEventListener("enterFrame",actionOne);
      }
      
      private function actionOne(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _numBitmapArr.length)
         {
            if(_numBitmapArr[_loc2_].alpha >= 1)
            {
               removeEventListener("enterFrame",actionOne);
               return;
               §§push(setTimeout(actionTwo,500));
            }
            else
            {
               _numBitmapArr[_loc2_].alpha = _numBitmapArr[_loc2_].alpha + 0.2;
               _numBitmapArr[_loc2_].scaleX = _numBitmapArr[_loc2_].scaleX + 0.1;
               _numBitmapArr[_loc2_].x = _numBitmapArr[_loc2_].x + 2;
               _numBitmapArr[_loc2_].y = _numBitmapArr[_loc2_].y - 7;
               _loc2_++;
               continue;
            }
         }
      }
      
      private function actionTwo() : void
      {
         addEventListener("enterFrame",actionTwoStart);
      }
      
      private function actionTwoStart(param1:Event) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _numBitmapArr.length)
         {
            if(_numBitmapArr[_loc2_].alpha <= 0)
            {
               dispose();
               return;
            }
            _numBitmapArr[_loc2_].alpha = _numBitmapArr[_loc2_].alpha - 0.2;
            _numBitmapArr[_loc2_].y = _numBitmapArr[_loc2_].y - 7;
            _loc2_++;
         }
      }
      
      private function dispose() : void
      {
         var _loc1_:int = 0;
         removeEventListener("enterFrame",actionTwoStart);
         if(_numBitmapArr)
         {
            _loc1_ = 0;
            while(_loc1_ < _numBitmapArr.length)
            {
               removeChild(_numBitmapArr[_loc1_]);
               _numBitmapArr[_loc1_] = null;
               _numBitmapArr.shift();
            }
            _numBitmapArr = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
