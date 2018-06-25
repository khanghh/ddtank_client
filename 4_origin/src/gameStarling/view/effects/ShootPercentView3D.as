package gameStarling.view.effects
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import gameCommon.BloodNumberCreater;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ShootPercentView3D extends Sprite
   {
       
      
      private var _type:int;
      
      private var _isAdd:Boolean;
      
      private var _picBmp:Sprite;
      
      private var add:Boolean = true;
      
      private var tmp:int = 0;
      
      public function ShootPercentView3D(n:int, type:int = 1, isadd:Boolean = false)
      {
         super();
         _type = type;
         _isAdd = isadd;
         _picBmp = getPercent(n);
         addChild(_picBmp);
         this.addEventListener("addedToStage",__addToStage);
      }
      
      override public function dispose() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         StarlingObjectUtils.disposeAllChildren(_picBmp);
         StarlingObjectUtils.disposeObject(_picBmp);
         _picBmp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
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
      
      public function getPercent(n:int) : Sprite
      {
         var numArr:* = null;
         var s:* = null;
         var len:int = 0;
         var xpos:int = 0;
         var addIcon:* = null;
         var bm:* = null;
         var i:int = 0;
         var b:* = null;
         var p:* = null;
         var numberContainer:Sprite = new Sprite();
         numberContainer.touchable = false;
         if(n <= 99999999)
         {
            numArr = [];
            numArr = [0,0,0,0];
            s = String(n);
            len = s.length;
            xpos = 33 + (4 - len) * 10;
            if(_isAdd)
            {
               s = " " + s;
               len = len + 1;
               xpos = xpos - 10;
               addIcon = StarlingMain.instance.createImage("game_blood_addIcon");
               addIcon.x = xpos;
               addIcon.y = 20;
               numArr.push(addIcon);
            }
            else if(_type == 2)
            {
               bm = StarlingMain.instance.createImage("game_blood_RBg");
               bm.x = bm.x + 5;
               bm.y = -10;
               numArr.push(bm);
            }
            i = !!_isAdd?1:0;
            while(i < len)
            {
               if(_isAdd)
               {
                  b = BloodNumberCreater.createGreenImageNum(int(s.charAt(i)));
               }
               else
               {
                  b = BloodNumberCreater.createRedImageNum(int(s.charAt(i)));
               }
               b.x = xpos + i * 20;
               b.y = 20;
               numArr.push(b);
               i++;
            }
            numArr = returnNum(numArr);
            for(i = 4; i < numArr.length; )
            {
               p = new Point(numArr[i].x - numArr[0],numArr[i].y - numArr[1]);
               PositionUtils.setPos(p,numArr[i]);
               numberContainer.addChild(numArr[i]);
               i++;
            }
            numberContainer.x = numArr[0];
            numberContainer.y = numArr[1];
            numArr = null;
         }
         return numberContainer;
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
