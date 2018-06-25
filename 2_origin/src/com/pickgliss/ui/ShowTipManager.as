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
      
      public function addTip(tipedDisplay:ITipedDisplay) : void
      {
         if(tipedDisplay == null)
         {
            return;
         }
         removeTipedObject(tipedDisplay);
         _tipedObjects.push(tipedDisplay);
         tipedDisplay.addEventListener("rollOver",__onOver);
         tipedDisplay.addEventListener("rollOut",__onOut);
         if(_currentTipObject == tipedDisplay)
         {
            showTip(_currentTipObject);
         }
      }
      
      public function getTipPosByDirction(tip:ITip, target:ITipedDisplay, direction:int) : Point
      {
         var resultPos:Point = new Point();
         if(direction == 0)
         {
            resultPos.y = -tip.height - target.tipGapV;
            resultPos.x = (target.width - tip.width) / 2;
         }
         else if(direction == 1)
         {
            resultPos.x = -tip.width - target.tipGapH;
            resultPos.y = (target.height - tip.height) / 2;
         }
         else if(direction == 2)
         {
            resultPos.x = target.width + target.tipGapH;
            resultPos.y = (target.height - tip.height) / 2;
         }
         else if(direction == 3)
         {
            resultPos.y = target.height + target.tipGapV;
            resultPos.x = (target.width - tip.width) / 2;
         }
         else if(direction == 4)
         {
            resultPos.y = -tip.height - target.tipGapV;
            resultPos.x = -tip.width - target.tipGapH;
         }
         else if(direction == 5)
         {
            resultPos.y = -tip.height - target.tipGapV;
            resultPos.x = target.width + target.tipGapH;
         }
         else if(direction == 6)
         {
            resultPos.y = target.height + target.tipGapV;
            resultPos.x = -tip.width - target.tipGapH;
         }
         else if(direction == 7)
         {
            resultPos.y = target.height + target.tipGapV;
            resultPos.x = target.width + target.tipGapH;
         }
         return resultPos;
      }
      
      public function hideTip(target:ITipedDisplay) : void
      {
         if(target == null)
         {
            return;
         }
         var tip:ITip = _tips[target.tipStyle];
         if(tip == null)
         {
            return;
         }
         if(_tipContainer.contains(tip.asDisplayObject()))
         {
            _tipContainer.removeChild(tip.asDisplayObject());
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
         for each(var tip in _tips)
         {
            if(tip.asDisplayObject().parent)
            {
               tip.asDisplayObject().parent.removeChild(tip.asDisplayObject());
            }
         }
      }
      
      public function removeTip(tipedDisplay:ITipedDisplay) : void
      {
         removeTipedObject(tipedDisplay);
         if(_currentTipObject == tipedDisplay)
         {
            hideTip(_currentTipObject);
         }
      }
      
      public function setSimpleTip(target:ITipedDisplay, tipMsg:String = "") : void
      {
         if(_simpleTipset == null)
         {
            return;
         }
         if(target is Component)
         {
            Component(target).beginChanges();
         }
         target.tipStyle = _simpleTipset.tipStyle;
         target.tipData = tipMsg;
         target.tipDirctions = _simpleTipset.tipDirctions;
         target.tipGapV = _simpleTipset.tipGapV;
         target.tipGapH = _simpleTipset.tipGapH;
         if(target is Component)
         {
            Component(target).commitChanges();
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
      
      public function showTip(target:*) : void
      {
         var tip:* = _tips[target.tipStyle];
         if(target is ITipedDisplay)
         {
            setCommonTip(target,tip);
            tip = _tips[target.tipStyle];
         }
         if(tip)
         {
            if(target is ITransformableTipedDisplay)
            {
               tip.tipWidth = target.tipWidth;
               tip.tipHeight = target.tipHeight;
            }
            configPosition(target,tip);
            _currentTipObject = target;
            _tipContainer.addChild(tip.asDisplayObject());
         }
      }
      
      public function getTipInstanceByStylename(stylename:String) : ITip
      {
         return _tips[stylename];
      }
      
      public function updatePos() : void
      {
         if(!_updateTempTarget)
         {
            return;
         }
         showTip(_updateTempTarget);
      }
      
      private function setCommonTip(target:*, tip:*) : void
      {
         if(tip == null)
         {
            if(target.tipStyle == null)
            {
               return;
            }
            tip = createTipByStyleName(target.tipStyle);
            if(tip == null)
            {
               return;
            }
         }
         tip.tipData = target.tipData;
      }
      
      public function createTipByStyleName(stylename:String) : *
      {
         var tipView:Object = null;
         try
         {
            tipView = ComponentFactory.Instance.creat(stylename);
            _tips[stylename] = tipView;
         }
         catch(e:Error)
         {
            trace("tipView创建失败！找不到:" + stylename + " 请检查快速解决!");
         }
         return tipView;
      }
      
      private function configPosition(target:*, tip:*) : void
      {
         var startPos:Point = _tipContainer.globalToLocal(target.localToGlobal(StartPoint));
         var resultPos:Point = new Point();
         var resultDirection:DirectionPos = getTipPriorityDirction(tip,target,target.tipDirctions);
         resultPos = getTipPosByDirction(tip,target,resultDirection.direction);
         if(resultDirection.offsetX < 2147483647 / 2)
         {
            tip.x = resultPos.x + startPos.x + resultDirection.offsetX;
         }
         else
         {
            tip.x = resultPos.x + startPos.x;
         }
         if(resultDirection.offsetY < 2147483647 / 2)
         {
            tip.y = resultPos.y + startPos.y + resultDirection.offsetY;
         }
         else
         {
            tip.y = resultPos.y + startPos.y;
         }
      }
      
      private function __onOut(event:MouseEvent) : void
      {
         var target:ITipedDisplay = event.currentTarget as ITipedDisplay;
         hideTip(target);
         _updateTempTarget = null;
      }
      
      private function __onOver(event:MouseEvent) : void
      {
         var target:ITipedDisplay = event.currentTarget as ITipedDisplay;
         if(target.tipStyle == null)
         {
            return;
         }
         showTip(target);
         _updateTempTarget = target;
      }
      
      private function getTipPriorityDirction(tip:ITip, target:ITipedDisplay, directions:String) : DirectionPos
      {
         var resultDirectionPos:* = null;
         var i:int = 0;
         var ordinaryPos:* = null;
         var resultStartPos:* = null;
         var resultEndPos:* = null;
         var directionPos:* = null;
         var dirs:Array = directions.split(",");
         var tempDirectionPos:Vector.<DirectionPos> = new Vector.<DirectionPos>();
         var startPos:Point = _tipContainer.globalToLocal(target.localToGlobal(StartPoint));
         for(i = 0; i < dirs.length; )
         {
            ordinaryPos = getTipPosByDirction(tip,target,dirs[i]);
            resultStartPos = new Point(ordinaryPos.x + startPos.x,ordinaryPos.y + startPos.y);
            resultEndPos = new Point(ordinaryPos.x + startPos.x + tip.width,ordinaryPos.y + startPos.y + tip.height);
            directionPos = creatDirectionPos(resultStartPos,resultEndPos,int(dirs[i]));
            if(directionPos.offsetX == 0 && directionPos.offsetY == 0)
            {
               resultDirectionPos = directionPos;
               break;
            }
            tempDirectionPos.push(directionPos);
            i++;
         }
         if(resultDirectionPos == null)
         {
            resultDirectionPos = searchFixedDirectionPos(tempDirectionPos);
         }
         return resultDirectionPos;
      }
      
      private function searchFixedDirectionPos(tempDirections:Vector.<DirectionPos>) : DirectionPos
      {
         var result:* = null;
         var i:int = 0;
         var current:int = 0;
         var last:int = 0;
         var reverDirections:Vector.<DirectionPos> = tempDirections.reverse();
         for(i = 0; i < reverDirections.length; )
         {
            if(result == null)
            {
               result = reverDirections[i];
            }
            else
            {
               current = Math.abs(reverDirections[i].offsetX) + Math.abs(reverDirections[i].offsetY);
               last = Math.abs(result.offsetX) + Math.abs(result.offsetY);
               if(current <= last)
               {
                  result = reverDirections[i];
               }
            }
            i++;
         }
         return result;
      }
      
      private function creatDirectionPos(startPos:Point, endPos:Point, direction:int) : DirectionPos
      {
         var directionPos:DirectionPos = new DirectionPos();
         directionPos.direction = direction;
         if(direction == 0)
         {
            if(startPos.y < 0)
            {
               directionPos.offsetY = 2147483647 / 2;
            }
            else
            {
               directionPos.offsetY = 0;
            }
            if(startPos.x < 0)
            {
               directionPos.offsetX = -startPos.x;
            }
            else if(endPos.x > StageReferance.stageWidth)
            {
               directionPos.offsetX = StageReferance.stageWidth - endPos.x;
            }
            else
            {
               directionPos.offsetX = 0;
            }
         }
         else if(direction == 1)
         {
            if(startPos.x < 0)
            {
               directionPos.offsetX = 2147483647 / 2;
            }
            else
            {
               directionPos.offsetX = 0;
            }
            if(startPos.y < 0)
            {
               directionPos.offsetY = -startPos.y;
            }
            else if(endPos.y > StageReferance.stageHeight)
            {
               directionPos.offsetY = StageReferance.stageHeight - endPos.y;
            }
            else
            {
               directionPos.offsetY = 0;
            }
         }
         else if(direction == 2)
         {
            if(endPos.x > StageReferance.stageWidth)
            {
               directionPos.offsetX = 2147483647 / 2;
            }
            else
            {
               directionPos.offsetX = 0;
            }
            if(startPos.y < 0)
            {
               directionPos.offsetY = -startPos.y;
            }
            else if(endPos.y > StageReferance.stageHeight)
            {
               directionPos.offsetY = StageReferance.stageHeight - endPos.y;
            }
            else
            {
               directionPos.offsetY = 0;
            }
         }
         else if(direction == 3)
         {
            if(endPos.y > StageReferance.stageHeight)
            {
               directionPos.offsetY = 2147483647 / 2;
            }
            else
            {
               directionPos.offsetY = 0;
            }
            if(startPos.x < 0)
            {
               directionPos.offsetX = -startPos.x;
            }
            else if(endPos.x > StageReferance.stageWidth)
            {
               directionPos.offsetX = StageReferance.stageWidth - endPos.x;
            }
            else
            {
               directionPos.offsetX = 0;
            }
         }
         else if(DisplayUtils.isInTheStage(startPos) && DisplayUtils.isInTheStage(endPos))
         {
            directionPos.offsetX = 0;
            directionPos.offsetY = 0;
         }
         else
         {
            directionPos.offsetY = 2147483647 / 2;
            directionPos.offsetX = 2147483647 / 2;
         }
         return directionPos;
      }
      
      private function removeTipedObject(tipedDisplay:ITipedDisplay) : void
      {
         var index:int = _tipedObjects.indexOf(tipedDisplay);
         tipedDisplay.removeEventListener("rollOver",__onOver);
         tipedDisplay.removeEventListener("rollOut",__onOut);
         if(index != -1)
         {
            _tipedObjects.splice(index,1);
         }
      }
   }
}
