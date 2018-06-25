package totem.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   
   public class TotemLeftWindowOpenCartoonView extends Sprite implements Disposeable
   {
       
      
      private var _pointBomb:MovieClip;
      
      private var _lightBomb:MovieClip;
      
      private var _failPointBomb:MovieClip;
      
      private var _failTipTxtBitmap:Bitmap;
      
      private var _moveLightList:Vector.<MovieClip>;
      
      private var _openUsedNextPointInfo:TotemDataVo;
      
      private var _openUsedCallback:Function;
      
      private var _failOpenNextPointInfo:TotemDataVo;
      
      private var _failOpenCallback:Function;
      
      private var _totemPointLocationList:Array;
      
      private var __refreshGlowFilter:Function;
      
      private var __refreshTotemPoint:Function;
      
      private var _addTxt:FilterFrameText;
      
      private var _propertyTxtList:Array;
      
      private var _failBombCount:int;
      
      private var _bombCount:int;
      
      private var _moveTxtCount:int;
      
      private var _moveTxtEndCallbackTag:int;
      
      private var _moveLightCount:int;
      
      public function TotemLeftWindowOpenCartoonView(totemPointLocationList:Array, refreshGlowFilter:Function, refreshTotemPoint:Function)
      {
         super();
         _totemPointLocationList = totemPointLocationList;
         __refreshGlowFilter = refreshGlowFilter;
         __refreshTotemPoint = refreshTotemPoint;
         _pointBomb = ComponentFactory.Instance.creat("asset.totem.open.pointBomb");
         _lightBomb = ComponentFactory.Instance.creat("asset.totem.open.lightBomb");
         _pointBomb.gotoAndStop(2);
         _lightBomb.gotoAndStop(2);
         _failPointBomb = ComponentFactory.Instance.creat("asset.totem.failOpen.pointBomb");
         _failPointBomb.gotoAndStop(2);
         _failTipTxtBitmap = ComponentFactory.Instance.creatBitmap("asset.totem.failOpen.tipTxt");
         _addTxt = ComponentFactory.Instance.creatComponentByStylename("totem.totemOpenCartoon.moveTxt");
         _addTxt.alpha = 0;
         _propertyTxtList = LanguageMgr.GetTranslation("ddt.totem.sevenProperty").split(",");
      }
      
      public function failRefreshView(nextPointInfo:TotemDataVo, callback:Function = null) : void
      {
         _failOpenNextPointInfo = nextPointInfo;
         _failOpenCallback = callback;
         showFailOpenCartoon();
      }
      
      private function showFailOpenCartoon() : void
      {
         var locationPoint:Object = _totemPointLocationList[_failOpenNextPointInfo.Page - 1][_failOpenNextPointInfo.Location - 1];
         _lightBomb.gotoAndStop(1);
         _failPointBomb.x = locationPoint.x;
         _failPointBomb.y = locationPoint.y - 25;
         _lightBomb.x = locationPoint.x;
         _lightBomb.y = locationPoint.y + 17;
         addChild(_lightBomb);
         _failTipTxtBitmap.x = locationPoint.x - 26;
         _failTipTxtBitmap.y = locationPoint.y - 15;
         _failBombCount = 0;
         _lightBomb.addEventListener("enterFrame",lightBombFrameHandler,false,0,true);
      }
      
      private function lightBombFrameHandler(event:Event) : void
      {
         _failBombCount = Number(_failBombCount) + 1;
         if(_failBombCount == 8)
         {
            _lightBomb.removeEventListener("enterFrame",lightBombFrameHandler);
            _lightBomb.gotoAndStop(2);
            removeChild(_lightBomb);
            _failPointBomb.gotoAndStop(1);
            addChild(_failPointBomb);
            _failBombCount = 0;
            _failPointBomb.addEventListener("enterFrame",pointBombFrameHandler,false,0,true);
         }
      }
      
      private function pointBombFrameHandler(event:Event) : void
      {
         _failBombCount = Number(_failBombCount) + 1;
         if(_failBombCount == 6)
         {
            addChild(_failTipTxtBitmap);
            TweenLite.to(_failTipTxtBitmap,0.6,{
               "y":_failTipTxtBitmap.y - 56,
               "onComplete":moveFailTxtCompleteHandler
            });
         }
         else if(_failBombCount == 14)
         {
            if(_failPointBomb)
            {
               _failPointBomb.removeEventListener("enterFrame",pointBombFrameHandler);
               _failPointBomb.gotoAndStop(2);
               removeChild(_failPointBomb);
            }
         }
      }
      
      private function moveFailTxtCompleteHandler() : void
      {
         if(_failTipTxtBitmap)
         {
            removeChild(_failTipTxtBitmap);
         }
         if(_failOpenCallback != null)
         {
            _failOpenCallback();
            _failOpenCallback = null;
         }
         _failOpenNextPointInfo = null;
      }
      
      public function refreshView(nextPointInfo:TotemDataVo, callback:Function = null) : void
      {
         _openUsedNextPointInfo = nextPointInfo;
         _openUsedCallback = callback;
         showOpenCartoon();
      }
      
      private function showOpenCartoon() : void
      {
         var page:int = 0;
         var location:int = 0;
         if(!_openUsedNextPointInfo)
         {
            page = 5;
            location = 7;
         }
         else if(_openUsedNextPointInfo.Location == 1)
         {
            if(_openUsedNextPointInfo.Layers == 1)
            {
               page = _openUsedNextPointInfo.Page - 1;
            }
            else
            {
               page = _openUsedNextPointInfo.Page;
            }
            location = 7;
         }
         else
         {
            page = _openUsedNextPointInfo.Page;
            location = _openUsedNextPointInfo.Location - 1;
         }
         addTotemPointCartoon(_totemPointLocationList[page - 1][location - 1]);
      }
      
      private function addTotemPointCartoon(locationPoint:Object) : void
      {
         _pointBomb.gotoAndStop(1);
         _lightBomb.gotoAndStop(1);
         _pointBomb.x = locationPoint.x;
         _pointBomb.y = locationPoint.y - 25;
         _lightBomb.x = locationPoint.x;
         _lightBomb.y = locationPoint.y + 17;
         addChild(_lightBomb);
         addChild(_pointBomb);
         _addTxt.x = locationPoint.x - 26;
         _addTxt.y = locationPoint.y - 15;
         _bombCount = 0;
         _pointBomb.addEventListener("enterFrame",bombFrameHandler,false,0,true);
      }
      
      private function bombFrameHandler(event:Event) : void
      {
         _bombCount = Number(_bombCount) + 1;
         if(_bombCount == 8)
         {
            _lightBomb.gotoAndStop(2);
            removeChild(_lightBomb);
         }
         if(_bombCount == 24)
         {
            _pointBomb.removeEventListener("enterFrame",bombFrameHandler);
            _pointBomb.gotoAndStop(2);
            removeChild(_pointBomb);
            _moveTxtEndCallbackTag = 0;
            if(_openUsedNextPointInfo && _openUsedNextPointInfo.Location != 1)
            {
               __refreshGlowFilter(_openUsedNextPointInfo.Page,_openUsedNextPointInfo);
               showMoveLigthCartoon();
            }
            else if(_openUsedNextPointInfo && _openUsedNextPointInfo.Page != 1 && _openUsedNextPointInfo.Layers == 1 && _openUsedNextPointInfo.Location == 1)
            {
               _moveTxtEndCallbackTag = 1;
            }
            else
            {
               _moveTxtEndCallbackTag = 2;
            }
            showMoveTxt();
         }
      }
      
      private function showMoveTxt() : void
      {
         var tmp:int = 0;
         if(_openUsedNextPointInfo)
         {
            tmp = _openUsedNextPointInfo.Point - 1;
         }
         else
         {
            tmp = 350;
         }
         var tmpDataVo:TotemDataVo = TotemManager.instance.getCurInfoByLevel(tmp);
         _addTxt.text = _propertyTxtList[tmpDataVo.Location - 1] + " +" + tmpDataVo.addValue;
         _moveTxtCount = 0;
         _addTxt.addEventListener("enterFrame",moveTxtHandler,false,0,true);
         addChild(_addTxt);
      }
      
      private function moveTxtHandler(event:Event) : void
      {
         var page:int = 0;
         _moveTxtCount = Number(_moveTxtCount) + 1;
         if(_moveTxtCount >= 0 && _moveTxtCount <= 8)
         {
            _addTxt.y = _addTxt.y - 4;
            _addTxt.alpha = _addTxt.alpha + 0.125;
         }
         else if(_moveTxtCount > 8 && _moveTxtCount <= 16)
         {
            _addTxt.alpha = 1;
         }
         else if(_moveTxtCount > 16 && _moveTxtCount < 22)
         {
            _addTxt.y = _addTxt.y - 6;
            _addTxt.alpha = _addTxt.alpha - 0.2;
         }
         else if(_moveTxtCount >= 22)
         {
            _addTxt.removeEventListener("enterFrame",moveTxtHandler);
            _addTxt.alpha = 0;
            if(_moveTxtEndCallbackTag == 1)
            {
               _openUsedNextPointInfo = null;
               if(_openUsedCallback != null)
               {
                  _openUsedCallback.apply();
               }
               _openUsedCallback = null;
            }
            else if(_moveTxtEndCallbackTag == 2)
            {
               if(!_openUsedNextPointInfo)
               {
                  page = 5;
               }
               else
               {
                  page = _openUsedNextPointInfo.Page;
               }
               __refreshTotemPoint(page,_openUsedNextPointInfo,true);
               _openUsedNextPointInfo = null;
            }
         }
      }
      
      private function showMoveLigthCartoon() : void
      {
         var i:int = 0;
         var tmpArray:Array = _totemPointLocationList[_openUsedNextPointInfo.Page - 1];
         var forward:Object = tmpArray[_openUsedNextPointInfo.Location - 2];
         var next:Object = tmpArray[_openUsedNextPointInfo.Location - 1];
         var tmpY:Number = next.y - forward.y;
         var tmpX:Number = next.x - forward.x;
         var tmp:Number = tmpY / tmpX;
         var rotation:* = 0;
         var ligthMCWidth:* = 89.2;
         if(next.x == forward.x)
         {
            if(next.y > forward.y)
            {
               rotation = 90;
            }
            else
            {
               rotation = -90;
            }
         }
         else if(next.x < forward.x)
         {
            if(next.y > forward.y)
            {
               rotation = Number(Math.atan(tmp) * (180 / 3.14159265358979) + 180);
            }
            else
            {
               rotation = Number(Math.atan(tmp) * (180 / 3.14159265358979) - 180);
            }
         }
         else
         {
            rotation = Number(Math.atan(tmp) * (180 / 3.14159265358979));
         }
         var distance:Number = Math.pow(Math.pow(tmpY,2) + Math.pow(tmpX,2),0.5);
         var rest:Number = distance % ligthMCWidth;
         var count:int = distance / ligthMCWidth;
         if(rest > 10)
         {
            count = count + 1;
         }
         _moveLightList = new Vector.<MovieClip>();
         createMoveLight(forward.x,forward.y,rotation);
         if(count >= 2)
         {
            createMoveLight((distance - ligthMCWidth) / distance * tmpX + forward.x,(distance - ligthMCWidth) / distance * tmpY + forward.y,rotation);
         }
         i = 1;
         while(i < count - 1)
         {
            createMoveLight(ligthMCWidth * i / distance * tmpX + forward.x,ligthMCWidth * i / distance * tmpY + forward.y,rotation);
            i++;
         }
         _moveLightCount = 0;
         _moveLightList[0].addEventListener("enterFrame",moveLightFrameHandler,false,0,true);
      }
      
      private function createMoveLight(x:Number, y:Number, rotation:Number) : void
      {
         var mc:MovieClip = ClassUtils.CreatInstance("asset.totem.open.moveLight");
         mc.gotoAndStop(1);
         mc.x = x;
         mc.y = y;
         mc.rotation = rotation;
         addChild(mc);
         _moveLightList.push(mc);
      }
      
      private function moveLightFrameHandler(event:Event) : void
      {
         _moveLightCount = Number(_moveLightCount) + 1;
         if(_moveLightCount == 22)
         {
            _moveLightList[0].removeEventListener("enterFrame",moveLightFrameHandler);
            var _loc4_:int = 0;
            var _loc3_:* = _moveLightList;
            for each(var tmp in _moveLightList)
            {
               tmp.gotoAndStop(2);
               if(tmp.parent)
               {
                  tmp.parent.removeChild(tmp);
               }
            }
            _moveLightList = null;
            __refreshTotemPoint(_openUsedNextPointInfo.Page,_openUsedNextPointInfo,true);
            _openUsedNextPointInfo = null;
         }
      }
      
      public function dispose() : void
      {
         if(_moveLightList && _moveLightList.length > 0)
         {
            _moveLightList[0].removeEventListener("enterFrame",moveLightFrameHandler);
            var _loc3_:int = 0;
            var _loc2_:* = _moveLightList;
            for each(var tmp4 in _moveLightList)
            {
               tmp4.gotoAndStop(2);
               if(tmp4.parent)
               {
                  tmp4.parent.removeChild(tmp4);
               }
            }
         }
         _moveLightList = null;
         if(_pointBomb)
         {
            _pointBomb.removeEventListener("enterFrame",bombFrameHandler);
            _pointBomb.gotoAndStop(2);
         }
         _pointBomb = null;
         if(_lightBomb)
         {
            _lightBomb.removeEventListener("enterFrame",lightBombFrameHandler);
            _lightBomb.gotoAndStop(2);
         }
         _lightBomb = null;
         _openUsedNextPointInfo = null;
         _openUsedCallback = null;
         _totemPointLocationList = null;
         __refreshGlowFilter = null;
         __refreshTotemPoint = null;
         if(_addTxt)
         {
            _addTxt.removeEventListener("enterFrame",moveTxtHandler);
            ObjectUtils.disposeObject(_addTxt);
         }
         _addTxt = null;
         if(_failPointBomb)
         {
            _failPointBomb.removeEventListener("enterFrame",pointBombFrameHandler);
            _failPointBomb.gotoAndStop(2);
            if(_failPointBomb.parent)
            {
               _failPointBomb.parent.removeChild(_failPointBomb);
            }
         }
         _failPointBomb = null;
         if(_failTipTxtBitmap)
         {
            TweenLite.killTweensOf(_failTipTxtBitmap,true);
            if(_failTipTxtBitmap.parent)
            {
               _failTipTxtBitmap.parent.removeChild(_failTipTxtBitmap);
            }
         }
         _failTipTxtBitmap = null;
         _failOpenNextPointInfo = null;
         _failOpenCallback = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
