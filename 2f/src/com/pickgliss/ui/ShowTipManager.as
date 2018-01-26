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
      
      public function ShowTipManager(){super();}
      
      public static function get Instance() : ShowTipManager{return null;}
      
      public function addTip(param1:ITipedDisplay) : void{}
      
      public function getTipPosByDirction(param1:ITip, param2:ITipedDisplay, param3:int) : Point{return null;}
      
      public function hideTip(param1:ITipedDisplay) : void{}
      
      public function removeCurrentTip() : void{}
      
      public function removeAllTip() : void{}
      
      public function removeTip(param1:ITipedDisplay) : void{}
      
      public function setSimpleTip(param1:ITipedDisplay, param2:String = "") : void{}
      
      public function setup() : void{}
      
      public function tempChangeTipContainer() : void{}
      
      public function showTip(param1:*) : void{}
      
      public function getTipInstanceByStylename(param1:String) : ITip{return null;}
      
      public function updatePos() : void{}
      
      private function setCommonTip(param1:*, param2:*) : void{}
      
      public function createTipByStyleName(param1:String) : *{return null;}
      
      private function configPosition(param1:*, param2:*) : void{}
      
      private function __onOut(param1:MouseEvent) : void{}
      
      private function __onOver(param1:MouseEvent) : void{}
      
      private function getTipPriorityDirction(param1:ITip, param2:ITipedDisplay, param3:String) : DirectionPos{return null;}
      
      private function searchFixedDirectionPos(param1:Vector.<DirectionPos>) : DirectionPos{return null;}
      
      private function creatDirectionPos(param1:Point, param2:Point, param3:int) : DirectionPos{return null;}
      
      private function removeTipedObject(param1:ITipedDisplay) : void{}
   }
}
