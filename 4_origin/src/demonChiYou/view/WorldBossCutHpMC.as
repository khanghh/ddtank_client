package demonChiYou.view
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
      
      public function WorldBossCutHpMC(num:Number)
      {
         super();
         _num = Math.abs(num);
         init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var numBitmap:* = null;
         _numBitmapArr = [];
         var value:String = _num.toString();
         var cutBitmap:Bitmap = ComponentFactory.Instance.creatBitmap("DemonChiYou.cutHP.valuNum10");
         _numBitmapArr.push(cutBitmap);
         cutBitmap.alpha = 0;
         cutBitmap.scaleX = 0.5;
         addChild(cutBitmap);
         for(i = 0; i < value.length; )
         {
            numBitmap = ComponentFactory.Instance.creatBitmap("DemonChiYou.cutHP.valuNum" + value.charAt(i));
            numBitmap.x = 19 * (i + 1);
            numBitmap.alpha = 0;
            numBitmap.scaleX = 0.5;
            _numBitmapArr.push(numBitmap);
            addChild(numBitmap);
            i++;
         }
         addEventListener("enterFrame",actionOne);
      }
      
      private function actionOne(e:Event) : void
      {
         var i:int = 0;
         for(i = 0; i < _numBitmapArr.length; )
         {
            if(_numBitmapArr[i].alpha >= 1)
            {
               removeEventListener("enterFrame",actionOne);
               setTimeout(actionTwo,500);
               return;
            }
            _numBitmapArr[i].alpha = _numBitmapArr[i].alpha + 0.2;
            _numBitmapArr[i].scaleX = _numBitmapArr[i].scaleX + 0.1;
            _numBitmapArr[i].x = _numBitmapArr[i].x + 2;
            _numBitmapArr[i].y = _numBitmapArr[i].y - 7;
            i++;
         }
      }
      
      private function actionTwo() : void
      {
         addEventListener("enterFrame",actionTwoStart);
      }
      
      private function actionTwoStart(e:Event) : void
      {
         var i:int = 0;
         for(i = 0; i < _numBitmapArr.length; )
         {
            if(_numBitmapArr[i].alpha <= 0)
            {
               dispose();
               return;
            }
            _numBitmapArr[i].alpha = _numBitmapArr[i].alpha - 0.2;
            _numBitmapArr[i].y = _numBitmapArr[i].y - 7;
            i++;
         }
      }
      
      private function dispose() : void
      {
         var i:int = 0;
         removeEventListener("enterFrame",actionOne);
         removeEventListener("enterFrame",actionTwoStart);
         if(_numBitmapArr)
         {
            for(i = 0; i < _numBitmapArr.length; )
            {
               removeChild(_numBitmapArr[i]);
               _numBitmapArr[i] = null;
               _numBitmapArr.shift();
            }
            _numBitmapArr = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _numBitmapArr = null;
      }
   }
}
