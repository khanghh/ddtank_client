package com.pickgliss.layout
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class StageResizeUtils
   {
      
      private static var _instance:StageResizeUtils;
       
      
      private var _autoResizeDic:Array;
      
      private var isOpen:Boolean = true;
      
      private var stageWidth:Number;
      
      private var stageHeight:Number;
      
      public function StageResizeUtils()
      {
         _autoResizeDic = [];
         super();
      }
      
      public static function get Instance() : StageResizeUtils
      {
         if(_instance == null)
         {
            _instance = new StageResizeUtils();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(!isOpen)
         {
            return;
         }
         StageReferance.stage.scaleMode = "noScale";
         StageReferance.stage.align = "TL";
         StageReferance.stage.addEventListener("resize",__onResize);
         stageWidth = StageReferance.stageWidth;
         stageHeight = StageReferance.stageHeight;
      }
      
      private function __onResize(event:Event) : void
      {
         stageWidth = StageReferance.stage.stageWidth;
         stageHeight = StageReferance.stage.stageHeight;
         autoResizeClear();
         autoResize();
      }
      
      public function addAutoResize($target:DisplayObject, $isPStage:Boolean = true) : void
      {
         if(!isOpen)
         {
            return;
         }
         autoResizeClear();
         var objInfo:ResizeObjInfo = new ResizeObjInfo();
         objInfo.target = $target;
         objInfo.customStyleName = "";
         objInfo.isPercent = true;
         objInfo.isPStage = $isPStage;
         objInfo.targetWidth = $target.width;
         objInfo.targetHeight = $target.height;
         var parentWidth:* = 0;
         var parentHeight:* = 0;
         if($isPStage)
         {
            parentWidth = Number(StageReferance.defaultWidth);
            parentHeight = Number(StageReferance.defaultHeight);
         }
         else
         {
            parentWidth = Number($target.parent.width);
            parentHeight = Number($target.parent.height);
         }
         objInfo.xPercent = $target.x / ((parentWidth - objInfo.targetWidth) / 2);
         objInfo.yPercent = $target.y / ((parentHeight - objInfo.targetHeight) / 2);
         addResizeObjInfo(objInfo);
      }
      
      public function addAutoResizeByStyle($target:DisplayObject, $customStyleName:String, $isPStage:Boolean = true) : void
      {
         if(!isOpen)
         {
            return;
         }
         removeResizeObj($target);
         autoResizeClear();
         var objInfo:ResizeObjInfo = new ResizeObjInfo();
         objInfo.target = $target;
         objInfo.customStyleName = $customStyleName;
         objInfo.isPercent = false;
         objInfo.isPStage = $isPStage;
         objInfo.targetWidth = $target.width;
         objInfo.targetHeight = $target.height;
         addResizeObjInfo(objInfo);
      }
      
      public function autoCenterResizeByStyle($target:DisplayObject, $isPStage:Boolean = true) : void
      {
         if(!isOpen)
         {
            return;
         }
         addAutoResizeByStyle($target,"core.boxlayoutInfo.CMAlign",$isPStage);
      }
      
      private function removeAutoResize($key:String) : void
      {
         _autoResizeDic.splice($key,1);
      }
      
      private function autoResize() : void
      {
         var obj:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _autoResizeDic;
         for(var key in _autoResizeDic)
         {
            obj = _autoResizeDic[key] as ResizeObjInfo;
            if(obj.target == null || obj.target.parent == null)
            {
               removeAutoResize(key);
            }
            else
            {
               resizeTarget(obj);
            }
         }
      }
      
      private function resizeTarget(objInfo:ResizeObjInfo) : void
      {
         var layoutInfo:* = null;
         var horizontalX:Number = NaN;
         var verticalY:Number = NaN;
         var target:DisplayObject = objInfo.target;
         if(target.parent == null)
         {
            return;
         }
         var customStyleName:String = objInfo.customStyleName;
         var isPercent:Boolean = objInfo.isPercent;
         var isPStage:Boolean = objInfo.isPStage;
         var xPercent:Number = objInfo.xPercent;
         var yPercent:Number = objInfo.yPercent;
         var targetWidth:Number = objInfo.targetWidth;
         var targetHeight:Number = objInfo.targetHeight;
         var parentWidth:* = 0;
         var parentHeight:* = 0;
         if(isPStage)
         {
            parentWidth = Number(stageWidth);
            parentHeight = Number(stageHeight);
         }
         else
         {
            parentWidth = Number(target.parent.width);
            parentHeight = Number(target.parent.height);
         }
         var innerRectArr:Array = [];
         if(isPercent)
         {
            innerRectArr[0] = (parentWidth - targetWidth) / 2 * xPercent;
            innerRectArr[1] = (parentHeight - targetHeight) / 2 * yPercent;
         }
         else
         {
            layoutInfo = ComponentFactory.Instance.creatCustomObject(customStyleName);
            horizontalX = convertPercent(layoutInfo.horizontalX,targetWidth);
            verticalY = convertPercent(layoutInfo.verticalY,targetHeight);
            if(layoutInfo.horizontalAlign == "left")
            {
               innerRectArr[0] = horizontalX + 0;
            }
            else if(layoutInfo.horizontalAlign == "center")
            {
               innerRectArr[0] = horizontalX + (parentWidth - targetWidth) / 2;
            }
            else if(layoutInfo.horizontalAlign == "right")
            {
               innerRectArr[0] = horizontalX + (parentWidth - targetWidth);
            }
            if(layoutInfo.verticalAlign == "top")
            {
               innerRectArr[1] = verticalY + 0;
            }
            else if(layoutInfo.verticalAlign == "middle")
            {
               innerRectArr[1] = verticalY + (parentHeight - targetHeight) / 2;
            }
            else if(layoutInfo.verticalAlign == "bottom")
            {
               innerRectArr[1] = verticalY + (parentHeight - targetHeight);
            }
         }
         target.x = innerRectArr[0];
         target.y = innerRectArr[1];
      }
      
      private function convertPercent(numStr:String, parentNum:Number) : Number
      {
         var tempNum:Number = NaN;
         if(numStr == null || numStr == "")
         {
            return 0;
         }
         var index:int = numStr.indexOf("%");
         var num:* = 0;
         if(index == -1)
         {
            num = Number(numStr);
         }
         else
         {
            tempNum = numStr.substring(0,index);
            num = Number(parentNum * (tempNum / 100));
         }
         return num;
      }
      
      private function autoResizeClear() : void
      {
         var target:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _autoResizeDic;
         for(var key in _autoResizeDic)
         {
            target = _autoResizeDic[key]["target"];
            if(target == null || target.parent == null)
            {
               removeAutoResize(key);
            }
         }
      }
      
      private function addResizeObjInfo(objInfo:ResizeObjInfo) : void
      {
         var key:String = targetKey(objInfo.target);
         if(key == "")
         {
            key = "" + getIndex();
         }
         _autoResizeDic[key] = objInfo;
         if(StageReferance.isStageResize())
         {
            resizeTarget(objInfo);
         }
      }
      
      private function getIndex() : int
      {
         return _autoResizeDic.length;
      }
      
      private function targetKey($target:DisplayObject) : String
      {
         var target:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _autoResizeDic;
         for(var key in _autoResizeDic)
         {
            target = _autoResizeDic[key]["target"];
            if($target == target)
            {
               return key;
            }
         }
         return "";
      }
      
      public function removeResizeObj($target:DisplayObject) : void
      {
         if($target == null)
         {
            return;
         }
         var key:String = targetKey($target);
         if(key != "")
         {
            removeAutoResize(key);
         }
      }
   }
}

import flash.display.DisplayObject;

class ResizeObjInfo
{
    
   
   public var target:DisplayObject;
   
   public var customStyleName:String;
   
   public var isPercent:Boolean;
   
   public var xPercent:Number = 1;
   
   public var yPercent:Number = 1;
   
   public var isPStage:Boolean;
   
   public var targetWidth:Number = 0;
   
   public var targetHeight:Number = 0;
   
   function ResizeObjInfo()
   {
      super();
   }
}
