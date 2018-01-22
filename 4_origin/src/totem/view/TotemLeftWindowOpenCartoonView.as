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
      
      public function TotemLeftWindowOpenCartoonView(param1:Array, param2:Function, param3:Function)
      {
         super();
         _totemPointLocationList = param1;
         __refreshGlowFilter = param2;
         __refreshTotemPoint = param3;
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
      
      public function failRefreshView(param1:TotemDataVo, param2:Function = null) : void
      {
         _failOpenNextPointInfo = param1;
         _failOpenCallback = param2;
         showFailOpenCartoon();
      }
      
      private function showFailOpenCartoon() : void
      {
         var _loc1_:Object = _totemPointLocationList[_failOpenNextPointInfo.Page - 1][_failOpenNextPointInfo.Location - 1];
         _lightBomb.gotoAndStop(1);
         _failPointBomb.x = _loc1_.x;
         _failPointBomb.y = _loc1_.y - 25;
         _lightBomb.x = _loc1_.x;
         _lightBomb.y = _loc1_.y + 17;
         addChild(_lightBomb);
         _failTipTxtBitmap.x = _loc1_.x - 26;
         _failTipTxtBitmap.y = _loc1_.y - 15;
         _failBombCount = 0;
         _lightBomb.addEventListener("enterFrame",lightBombFrameHandler,false,0,true);
      }
      
      private function lightBombFrameHandler(param1:Event) : void
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
      
      private function pointBombFrameHandler(param1:Event) : void
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
      
      public function refreshView(param1:TotemDataVo, param2:Function = null) : void
      {
         _openUsedNextPointInfo = param1;
         _openUsedCallback = param2;
         showOpenCartoon();
      }
      
      private function showOpenCartoon() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(!_openUsedNextPointInfo)
         {
            _loc2_ = 5;
            _loc1_ = 7;
         }
         else if(_openUsedNextPointInfo.Location == 1)
         {
            if(_openUsedNextPointInfo.Layers == 1)
            {
               _loc2_ = _openUsedNextPointInfo.Page - 1;
            }
            else
            {
               _loc2_ = _openUsedNextPointInfo.Page;
            }
            _loc1_ = 7;
         }
         else
         {
            _loc2_ = _openUsedNextPointInfo.Page;
            _loc1_ = _openUsedNextPointInfo.Location - 1;
         }
         addTotemPointCartoon(_totemPointLocationList[_loc2_ - 1][_loc1_ - 1]);
      }
      
      private function addTotemPointCartoon(param1:Object) : void
      {
         _pointBomb.gotoAndStop(1);
         _lightBomb.gotoAndStop(1);
         _pointBomb.x = param1.x;
         _pointBomb.y = param1.y - 25;
         _lightBomb.x = param1.x;
         _lightBomb.y = param1.y + 17;
         addChild(_lightBomb);
         addChild(_pointBomb);
         _addTxt.x = param1.x - 26;
         _addTxt.y = param1.y - 15;
         _bombCount = 0;
         _pointBomb.addEventListener("enterFrame",bombFrameHandler,false,0,true);
      }
      
      private function bombFrameHandler(param1:Event) : void
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
         var _loc1_:int = 0;
         if(_openUsedNextPointInfo)
         {
            _loc1_ = _openUsedNextPointInfo.Point - 1;
         }
         else
         {
            _loc1_ = 350;
         }
         var _loc2_:TotemDataVo = TotemManager.instance.getCurInfoByLevel(_loc1_);
         _addTxt.text = _propertyTxtList[_loc2_.Location - 1] + " +" + _loc2_.addValue;
         _moveTxtCount = 0;
         _addTxt.addEventListener("enterFrame",moveTxtHandler,false,0,true);
         addChild(_addTxt);
      }
      
      private function moveTxtHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
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
                  _loc2_ = 5;
               }
               else
               {
                  _loc2_ = _openUsedNextPointInfo.Page;
               }
               __refreshTotemPoint(_loc2_,_openUsedNextPointInfo,true);
               _openUsedNextPointInfo = null;
            }
         }
      }
      
      private function showMoveLigthCartoon() : void
      {
         var _loc11_:int = 0;
         var _loc12_:Array = _totemPointLocationList[_openUsedNextPointInfo.Page - 1];
         var _loc5_:Object = _loc12_[_openUsedNextPointInfo.Location - 2];
         var _loc7_:Object = _loc12_[_openUsedNextPointInfo.Location - 1];
         var _loc1_:Number = _loc7_.y - _loc5_.y;
         var _loc3_:Number = _loc7_.x - _loc5_.x;
         var _loc9_:Number = _loc1_ / _loc3_;
         var _loc6_:* = 0;
         var _loc8_:* = 89.2;
         if(_loc7_.x == _loc5_.x)
         {
            if(_loc7_.y > _loc5_.y)
            {
               _loc6_ = 90;
            }
            else
            {
               _loc6_ = -90;
            }
         }
         else if(_loc7_.x < _loc5_.x)
         {
            if(_loc7_.y > _loc5_.y)
            {
               _loc6_ = Number(Math.atan(_loc9_) * (180 / 3.14159265358979) + 180);
            }
            else
            {
               _loc6_ = Number(Math.atan(_loc9_) * (180 / 3.14159265358979) - 180);
            }
         }
         else
         {
            _loc6_ = Number(Math.atan(_loc9_) * (180 / 3.14159265358979));
         }
         var _loc2_:Number = Math.pow(Math.pow(_loc1_,2) + Math.pow(_loc3_,2),0.5);
         var _loc10_:Number = _loc2_ % _loc8_;
         var _loc4_:int = _loc2_ / _loc8_;
         if(_loc10_ > 10)
         {
            _loc4_ = _loc4_ + 1;
         }
         _moveLightList = new Vector.<MovieClip>();
         createMoveLight(_loc5_.x,_loc5_.y,_loc6_);
         if(_loc4_ >= 2)
         {
            createMoveLight((_loc2_ - _loc8_) / _loc2_ * _loc3_ + _loc5_.x,(_loc2_ - _loc8_) / _loc2_ * _loc1_ + _loc5_.y,_loc6_);
         }
         _loc11_ = 1;
         while(_loc11_ < _loc4_ - 1)
         {
            createMoveLight(_loc8_ * _loc11_ / _loc2_ * _loc3_ + _loc5_.x,_loc8_ * _loc11_ / _loc2_ * _loc1_ + _loc5_.y,_loc6_);
            _loc11_++;
         }
         _moveLightCount = 0;
         _moveLightList[0].addEventListener("enterFrame",moveLightFrameHandler,false,0,true);
      }
      
      private function createMoveLight(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:MovieClip = ClassUtils.CreatInstance("asset.totem.open.moveLight");
         _loc4_.gotoAndStop(1);
         _loc4_.x = param1;
         _loc4_.y = param2;
         _loc4_.rotation = param3;
         addChild(_loc4_);
         _moveLightList.push(_loc4_);
      }
      
      private function moveLightFrameHandler(param1:Event) : void
      {
         _moveLightCount = Number(_moveLightCount) + 1;
         if(_moveLightCount == 22)
         {
            _moveLightList[0].removeEventListener("enterFrame",moveLightFrameHandler);
            var _loc4_:int = 0;
            var _loc3_:* = _moveLightList;
            for each(var _loc2_ in _moveLightList)
            {
               _loc2_.gotoAndStop(2);
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
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
            for each(var _loc1_ in _moveLightList)
            {
               _loc1_.gotoAndStop(2);
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
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
