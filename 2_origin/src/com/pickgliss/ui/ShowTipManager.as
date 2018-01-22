package com.pickgliss.ui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.core.ITransformableTipedDisplay;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.ui.vo.DirectionPos;
   import com.pickgliss.utils.DisplayUtils;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public final class ShowTipManager
   {
      
      public static const StartPoint:Point = new Point(0,0);
      
      private static var _instance:ShowTipManager;
       
      
      private var _currentTipObject:ITipedDisplay;
      
      private var _simpleTipset:Object;
      
      private var _tipContainer:DisplayObjectContainer;
      
      private var _tipedObjects:Vector.<ITipedDisplay>;
      
      private var _tips:Dictionary;
      
      private var _updateTempTarget:ITipedDisplay;
      
      public function ShowTipManager()
      {
         super();
         _tips = new Dictionary();
         _tipedObjects = new Vector.<ITipedDisplay>();
      }
      
      public static function get Instance() : ShowTipManager
      {
         if(_instance == null)
         {
            _instance = new ShowTipManager();
         }
         return _instance;
      }
      
      public function addTip(param1:ITipedDisplay) : void
      {
         if(param1 == null)
         {
            return;
         }
         removeTipedObject(param1);
         _tipedObjects.push(param1);
         param1.addEventListener("rollOver",__onOver);
         param1.addEventListener("rollOut",__onOut);
         if(_currentTipObject == param1)
         {
            showTip(_currentTipObject);
         }
      }
      
      public function getTipPosByDirction(param1:ITip, param2:ITipedDisplay, param3:int) : Point
      {
         var _loc4_:Point = new Point();
         if(param3 == 0)
         {
            _loc4_.y = -param1.height - param2.tipGapV;
            _loc4_.x = (param2.width - param1.width) / 2;
         }
         else if(param3 == 1)
         {
            _loc4_.x = -param1.width - param2.tipGapH;
            _loc4_.y = (param2.height - param1.height) / 2;
         }
         else if(param3 == 2)
         {
            _loc4_.x = param2.width + param2.tipGapH;
            _loc4_.y = (param2.height - param1.height) / 2;
         }
         else if(param3 == 3)
         {
            _loc4_.y = param2.height + param2.tipGapV;
            _loc4_.x = (param2.width - param1.width) / 2;
         }
         else if(param3 == 4)
         {
            _loc4_.y = -param1.height - param2.tipGapV;
            _loc4_.x = -param1.width - param2.tipGapH;
         }
         else if(param3 == 5)
         {
            _loc4_.y = -param1.height - param2.tipGapV;
            _loc4_.x = param2.width + param2.tipGapH;
         }
         else if(param3 == 6)
         {
            _loc4_.y = param2.height + param2.tipGapV;
            _loc4_.x = -param1.width - param2.tipGapH;
         }
         else if(param3 == 7)
         {
            _loc4_.y = param2.height + param2.tipGapV;
            _loc4_.x = param2.width + param2.tipGapH;
         }
         return _loc4_;
      }
      
      public function hideTip(param1:ITipedDisplay) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ITip = _tips[param1.tipStyle];
         if(_loc2_ == null)
         {
            return;
         }
         if(_tipContainer.contains(_loc2_.asDisplayObject()))
         {
            _tipContainer.removeChild(_loc2_.asDisplayObject());
         }
         _currentTipObject = null;
      }
      
      public function removeCurrentTip() : void
      {
         hideTip(_currentTipObject);
      }
      
      public function removeAllTip() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _tips;
         for each(var _loc1_ in _tips)
         {
            if(_loc1_.asDisplayObject().parent)
            {
               _loc1_.asDisplayObject().parent.removeChild(_loc1_.asDisplayObject());
            }
         }
      }
      
      public function removeTip(param1:ITipedDisplay) : void
      {
         removeTipedObject(param1);
         if(_currentTipObject == param1)
         {
            hideTip(_currentTipObject);
         }
      }
      
      public function setSimpleTip(param1:ITipedDisplay, param2:String = "") : void
      {
         if(_simpleTipset == null)
         {
            return;
         }
         if(param1 is Component)
         {
            Component(param1).beginChanges();
         }
         param1.tipStyle = _simpleTipset.tipStyle;
         param1.tipData = param2;
         param1.tipDirctions = _simpleTipset.tipDirctions;
         param1.tipGapV = _simpleTipset.tipGapV;
         param1.tipGapH = _simpleTipset.tipGapH;
         if(param1 is Component)
         {
            Component(param1).commitChanges();
         }
      }
      
      public function setup() : void
      {
         _tipContainer = LayerManager.Instance.getLayerByType(2);
      }
      
      public function tempChangeTipContainer() : void
      {
         _tipContainer = LayerManager.Instance.getLayerByType(0);
      }
      
      public function showTip(param1:*) : void
      {
         var _loc2_:* = _tips[param1.tipStyle];
         if(param1 is ITipedDisplay)
         {
            setCommonTip(param1,_loc2_);
            _loc2_ = _tips[param1.tipStyle];
         }
         if(_loc2_)
         {
            if(param1 is ITransformableTipedDisplay)
            {
               _loc2_.tipWidth = param1.tipWidth;
               _loc2_.tipHeight = param1.tipHeight;
            }
            configPosition(param1,_loc2_);
            _currentTipObject = param1;
            _tipContainer.addChild(_loc2_.asDisplayObject());
         }
      }
      
      public function getTipInstanceByStylename(param1:String) : ITip
      {
         return _tips[param1];
      }
      
      public function updatePos() : void
      {
         if(!_updateTempTarget)
         {
            return;
         }
         showTip(_updateTempTarget);
      }
      
      private function setCommonTip(param1:*, param2:*) : void
      {
         if(param2 == null)
         {
            if(param1.tipStyle == null)
            {
               return;
            }
            param2 = createTipByStyleName(param1.tipStyle);
            if(param2 == null)
            {
               return;
            }
         }
         param2.tipData = param1.tipData;
      }
      
      public function createTipByStyleName(param1:String) : *
      {
         var _loc2_:Object = null;
         try
         {
            _loc2_ = ComponentFactory.Instance.creat(param1);
            _tips[param1] = _loc2_;
         }
         catch(e:Error)
         {
            trace("tipView创建失败！找不到:" + param1 + " 请检查快速解决!");
         }
         return _loc2_;
      }
      
      private function configPosition(param1:*, param2:*) : void
      {
         var _loc4_:Point = _tipContainer.globalToLocal(param1.localToGlobal(StartPoint));
         var _loc3_:Point = new Point();
         var _loc5_:DirectionPos = getTipPriorityDirction(param2,param1,param1.tipDirctions);
         _loc3_ = getTipPosByDirction(param2,param1,_loc5_.direction);
         if(_loc5_.offsetX < 2147483647 / 2)
         {
            param2.x = _loc3_.x + _loc4_.x + _loc5_.offsetX;
         }
         else
         {
            param2.x = _loc3_.x + _loc4_.x;
         }
         if(_loc5_.offsetY < 2147483647 / 2)
         {
            param2.y = _loc3_.y + _loc4_.y + _loc5_.offsetY;
         }
         else
         {
            param2.y = _loc3_.y + _loc4_.y;
         }
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         var _loc2_:ITipedDisplay = param1.currentTarget as ITipedDisplay;
         hideTip(_loc2_);
         _updateTempTarget = null;
      }
      
      private function __onOver(param1:MouseEvent) : void
      {
         var _loc2_:ITipedDisplay = param1.currentTarget as ITipedDisplay;
         if(_loc2_.tipStyle == null)
         {
            return;
         }
         showTip(_loc2_);
         _updateTempTarget = _loc2_;
      }
      
      private function getTipPriorityDirction(param1:ITip, param2:ITipedDisplay, param3:String) : DirectionPos
      {
         var _loc8_:* = null;
         var _loc12_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc9_:* = null;
         var _loc11_:Array = param3.split(",");
         var _loc5_:Vector.<DirectionPos> = new Vector.<DirectionPos>();
         var _loc7_:Point = _tipContainer.globalToLocal(param2.localToGlobal(StartPoint));
         _loc12_ = 0;
         while(_loc12_ < _loc11_.length)
         {
            _loc4_ = getTipPosByDirction(param1,param2,_loc11_[_loc12_]);
            _loc6_ = new Point(_loc4_.x + _loc7_.x,_loc4_.y + _loc7_.y);
            _loc10_ = new Point(_loc4_.x + _loc7_.x + param1.width,_loc4_.y + _loc7_.y + param1.height);
            _loc9_ = creatDirectionPos(_loc6_,_loc10_,int(_loc11_[_loc12_]));
            if(_loc9_.offsetX == 0 && _loc9_.offsetY == 0)
            {
               _loc8_ = _loc9_;
               break;
            }
            _loc5_.push(_loc9_);
            _loc12_++;
         }
         if(_loc8_ == null)
         {
            _loc8_ = searchFixedDirectionPos(_loc5_);
         }
         return _loc8_;
      }
      
      private function searchFixedDirectionPos(param1:Vector.<DirectionPos>) : DirectionPos
      {
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Vector.<DirectionPos> = param1.reverse();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc2_ == null)
            {
               _loc2_ = _loc5_[_loc6_];
            }
            else
            {
               _loc4_ = Math.abs(_loc5_[_loc6_].offsetX) + Math.abs(_loc5_[_loc6_].offsetY);
               _loc3_ = Math.abs(_loc2_.offsetX) + Math.abs(_loc2_.offsetY);
               if(_loc4_ <= _loc3_)
               {
                  _loc2_ = _loc5_[_loc6_];
               }
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      private function creatDirectionPos(param1:Point, param2:Point, param3:int) : DirectionPos
      {
         var _loc4_:DirectionPos = new DirectionPos();
         _loc4_.direction = param3;
         if(param3 == 0)
         {
            if(param1.y < 0)
            {
               _loc4_.offsetY = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
            if(param1.x < 0)
            {
               _loc4_.offsetX = -param1.x;
            }
            else if(param2.x > StageReferance.stageWidth)
            {
               _loc4_.offsetX = StageReferance.stageWidth - param2.x;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
         }
         else if(param3 == 1)
         {
            if(param1.x < 0)
            {
               _loc4_.offsetX = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
            if(param1.y < 0)
            {
               _loc4_.offsetY = -param1.y;
            }
            else if(param2.y > StageReferance.stageHeight)
            {
               _loc4_.offsetY = StageReferance.stageHeight - param2.y;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
         }
         else if(param3 == 2)
         {
            if(param2.x > StageReferance.stageWidth)
            {
               _loc4_.offsetX = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
            if(param1.y < 0)
            {
               _loc4_.offsetY = -param1.y;
            }
            else if(param2.y > StageReferance.stageHeight)
            {
               _loc4_.offsetY = StageReferance.stageHeight - param2.y;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
         }
         else if(param3 == 3)
         {
            if(param2.y > StageReferance.stageHeight)
            {
               _loc4_.offsetY = 2147483647 / 2;
            }
            else
            {
               _loc4_.offsetY = 0;
            }
            if(param1.x < 0)
            {
               _loc4_.offsetX = -param1.x;
            }
            else if(param2.x > StageReferance.stageWidth)
            {
               _loc4_.offsetX = StageReferance.stageWidth - param2.x;
            }
            else
            {
               _loc4_.offsetX = 0;
            }
         }
         else if(DisplayUtils.isInTheStage(param1) && DisplayUtils.isInTheStage(param2))
         {
            _loc4_.offsetX = 0;
            _loc4_.offsetY = 0;
         }
         else
         {
            _loc4_.offsetY = 2147483647 / 2;
            _loc4_.offsetX = 2147483647 / 2;
         }
         return _loc4_;
      }
      
      private function removeTipedObject(param1:ITipedDisplay) : void
      {
         var _loc2_:int = _tipedObjects.indexOf(param1);
         param1.removeEventListener("rollOver",__onOver);
         param1.removeEventListener("rollOut",__onOut);
         if(_loc2_ != -1)
         {
            _tipedObjects.splice(_loc2_,1);
         }
      }
   }
}
