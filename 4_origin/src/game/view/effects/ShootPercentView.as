package game.view.effects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameCommon.BloodNumberCreater;
   
   public class ShootPercentView extends Sprite
   {
       
      
      private var _type:int;
      
      private var _isAdd:Boolean;
      
      private var _picBmp:Bitmap;
      
      private var add:Boolean = true;
      
      private var tmp:int = 0;
      
      public function ShootPercentView(n:int, type:int = 1, isadd:Boolean = false)
      {
         super();
         _type = type;
         _isAdd = isadd;
         _picBmp = getPercent(n);
         this.addEventListener("addedToStage",__addToStage);
         if(_picBmp != null)
         {
            addChild(_picBmp);
         }
      }
      
      public function dispose() : void
      {
         if(_picBmp)
         {
            removeEventListener("enterFrame",__enterFrame);
            _picBmp.bitmapData.dispose();
            removeChild(_picBmp);
            _picBmp = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __addToStage(evt:Event) : void
      {
         removeEventListener("addedToStage",__addToStage);
         if(_picBmp == null)
         {
            return;
         }
         if(_type == 1)
         {
            _picBmp.x = -70;
            _picBmp.y = -20;
         }
         else
         {
            var _loc2_:* = 0.5;
            _picBmp.scaleY = _loc2_;
            _picBmp.scaleX = _loc2_;
         }
         _picBmp.alpha = 0;
         addEventListener("enterFrame",__enterFrame);
      }
      
      private function __enterFrame(evt:Event) : void
      {
         if(_type == 1)
         {
            doShowType1();
         }
         else
         {
            doShowType2();
         }
      }
      
      private function doShowType1() : void
      {
         if(_picBmp.alpha > 0.95)
         {
            tmp = Number(tmp) + 1;
            if(tmp == 20)
            {
               add = false;
               _picBmp.alpha = 0.9;
            }
         }
         if(_picBmp.alpha < 1)
         {
            if(add)
            {
               _picBmp.y = _picBmp.y - 8;
               _picBmp.alpha = _picBmp.alpha + 0.22;
            }
            else
            {
               _picBmp.y = _picBmp.y - 6;
               _picBmp.alpha = _picBmp.alpha - 0.1;
            }
         }
         if(_picBmp.alpha < 0.05)
         {
            dispose();
         }
      }
      
      private function doShowType2() : void
      {
         if(_picBmp.alpha > 0.95)
         {
            tmp = Number(tmp) + 1;
            if(tmp == 20)
            {
               add = false;
               _picBmp.alpha = 0.9;
            }
         }
         if(_picBmp.alpha < 1)
         {
            if(add)
            {
               _picBmp.scaleY = _picBmp.scaleY + 0.24;
               _picBmp.scaleX = _picBmp.scaleY + 0.24;
               _picBmp.alpha = _picBmp.alpha + 0.4;
            }
            else
            {
               _picBmp.scaleY = _picBmp.scaleY + 0.125;
               _picBmp.scaleX = _picBmp.scaleY + 0.125;
               _picBmp.alpha = _picBmp.alpha - 0.15;
            }
            _picBmp.x = -_picBmp.width / 2 + 10;
            _picBmp.y = -_picBmp.height / 2;
         }
         if(_picBmp.alpha < 0.05)
         {
            dispose();
         }
      }
      
      public function getPercent(n:int) : Bitmap
      {
         var bm:* = null;
         var addIcon:* = null;
         var i:int = 0;
         var b:* = null;
         if(n > 99999999)
         {
            return null;
         }
         var numberContainer:Sprite = new Sprite();
         var numArr:Array = [];
         numArr = [0,0,0,0];
         var _loc12_:Boolean = false;
         numberContainer.mouseEnabled = _loc12_;
         numberContainer.mouseChildren = _loc12_;
         if(_type == 2)
         {
            if(!_isAdd)
            {
               bm = ComponentFactory.Instance.creatBitmap("asset.game.redNumberBackgoundAsset") as Bitmap;
               bm.x = bm.x + 5;
               bm.y = -10;
               numArr.push(bm);
            }
         }
         var s:String = String(n);
         var len:int = s.length;
         var xpos:int = 33 + (4 - len) * 10;
         if(_isAdd)
         {
            s = " " + s;
            len = len + 1;
            xpos = xpos - 10;
            addIcon = ComponentFactory.Instance.creatBitmap("asset.game.addBloodIconAsset") as Bitmap;
            addIcon.x = xpos;
            addIcon.y = 20;
            numArr.push(addIcon);
         }
         i = !!_isAdd?1:0;
         while(i < len)
         {
            if(_isAdd)
            {
               b = BloodNumberCreater.createGreenNum(int(s.charAt(i)));
            }
            else
            {
               b = BloodNumberCreater.createRedNum(int(s.charAt(i)));
            }
            b.smoothing = true;
            b.x = xpos + i * 20;
            b.y = 20;
            numArr.push(b);
            i++;
         }
         numArr = returnNum(numArr);
         var bmpData:BitmapData = new BitmapData(numArr[2],numArr[3],true,0);
         _picBmp = new Bitmap(bmpData,"auto",true);
         for(i = 4; i < numArr.length; )
         {
            bmpData.copyPixels(numArr[i].bitmapData,new Rectangle(0,0,numArr[i].width,numArr[i].height),new Point(numArr[i].x - numArr[0],numArr[i].y - numArr[1]),null,null,true);
            i++;
         }
         _picBmp.x = numArr[0];
         _picBmp.y = numArr[1];
         numArr = null;
         return _picBmp;
      }
      
      private function returnNum(arr:Array) : Array
      {
         var i:int = 0;
         for(i = 4; i < arr.length; )
         {
            arr[0] = arr[0] > arr[i].x?arr[i].x:arr[0];
            arr[1] = arr[1] > arr[i].y?arr[i].y:arr[1];
            arr[2] = arr[2] > arr[i].width + arr[i].x?arr[2]:arr[i].width + arr[i].x;
            arr[3] = arr[3] > arr[i].height + arr[i].y?arr[3]:arr[i].height + arr[i].y;
            i++;
         }
         arr[2] = arr[2] - arr[0];
         arr[3] = arr[3] - arr[1];
         return arr;
      }
   }
}
