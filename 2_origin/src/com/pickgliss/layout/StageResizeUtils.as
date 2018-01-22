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
      
      private function __onResize(param1:Event) : void
      {
         stageWidth = StageReferance.stage.stageWidth;
         stageHeight = StageReferance.stage.stageHeight;
         autoResizeClear();
         autoResize();
      }
      
      public function addAutoResize(param1:DisplayObject, param2:Boolean = true) : void
      {
         if(!isOpen)
         {
            return;
         }
         autoResizeClear();
         var _loc5_:ResizeObjInfo = new ResizeObjInfo();
         _loc5_.target = param1;
         _loc5_.customStyleName = "";
         _loc5_.isPercent = true;
         _loc5_.isPStage = param2;
         _loc5_.targetWidth = param1.width;
         _loc5_.targetHeight = param1.height;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(param2)
         {
            _loc3_ = Number(StageReferance.defaultWidth);
            _loc4_ = Number(StageReferance.defaultHeight);
         }
         else
         {
            _loc3_ = Number(param1.parent.width);
            _loc4_ = Number(param1.parent.height);
         }
         _loc5_.xPercent = param1.x / ((_loc3_ - _loc5_.targetWidth) / 2);
         _loc5_.yPercent = param1.y / ((_loc4_ - _loc5_.targetHeight) / 2);
         addResizeObjInfo(_loc5_);
      }
      
      public function addAutoResizeByStyle(param1:DisplayObject, param2:String, param3:Boolean = true) : void
      {
         if(!isOpen)
         {
            return;
         }
         removeResizeObj(param1);
         autoResizeClear();
         var _loc4_:ResizeObjInfo = new ResizeObjInfo();
         _loc4_.target = param1;
         _loc4_.customStyleName = param2;
         _loc4_.isPercent = false;
         _loc4_.isPStage = param3;
         _loc4_.targetWidth = param1.width;
         _loc4_.targetHeight = param1.height;
         addResizeObjInfo(_loc4_);
      }
      
      public function autoCenterResizeByStyle(param1:DisplayObject, param2:Boolean = true) : void
      {
         if(!isOpen)
         {
            return;
         }
         addAutoResizeByStyle(param1,"core.boxlayoutInfo.CMAlign",param2);
      }
      
      private function removeAutoResize(param1:String) : void
      {
         _autoResizeDic.splice(param1,1);
      }
      
      private function autoResize() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _autoResizeDic;
         for(var _loc2_ in _autoResizeDic)
         {
            _loc1_ = _autoResizeDic[_loc2_] as ResizeObjInfo;
            if(_loc1_.target == null || _loc1_.target.parent == null)
            {
               removeAutoResize(_loc2_);
            }
            else
            {
               resizeTarget(_loc1_);
            }
         }
      }
      
      private function resizeTarget(param1:ResizeObjInfo) : void
      {
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc13_:DisplayObject = param1.target;
         if(_loc13_.parent == null)
         {
            return;
         }
         var _loc2_:String = param1.customStyleName;
         var _loc3_:Boolean = param1.isPercent;
         var _loc9_:Boolean = param1.isPStage;
         var _loc15_:Number = param1.xPercent;
         var _loc8_:Number = param1.yPercent;
         var _loc4_:Number = param1.targetWidth;
         var _loc10_:Number = param1.targetHeight;
         var _loc11_:* = 0;
         var _loc14_:* = 0;
         if(_loc9_)
         {
            _loc11_ = Number(stageWidth);
            _loc14_ = Number(stageHeight);
         }
         else
         {
            _loc11_ = Number(_loc13_.parent.width);
            _loc14_ = Number(_loc13_.parent.height);
         }
         var _loc12_:Array = [];
         if(_loc3_)
         {
            _loc12_[0] = (_loc11_ - _loc4_) / 2 * _loc15_;
            _loc12_[1] = (_loc14_ - _loc10_) / 2 * _loc8_;
         }
         else
         {
            _loc5_ = ComponentFactory.Instance.creatCustomObject(_loc2_);
            _loc6_ = convertPercent(_loc5_.horizontalX,_loc4_);
            _loc7_ = convertPercent(_loc5_.verticalY,_loc10_);
            if(_loc5_.horizontalAlign == "left")
            {
               _loc12_[0] = _loc6_ + 0;
            }
            else if(_loc5_.horizontalAlign == "center")
            {
               _loc12_[0] = _loc6_ + (_loc11_ - _loc4_) / 2;
            }
            else if(_loc5_.horizontalAlign == "right")
            {
               _loc12_[0] = _loc6_ + (_loc11_ - _loc4_);
            }
            if(_loc5_.verticalAlign == "top")
            {
               _loc12_[1] = _loc7_ + 0;
            }
            else if(_loc5_.verticalAlign == "middle")
            {
               _loc12_[1] = _loc7_ + (_loc14_ - _loc10_) / 2;
            }
            else if(_loc5_.verticalAlign == "bottom")
            {
               _loc12_[1] = _loc7_ + (_loc14_ - _loc10_);
            }
         }
         _loc13_.x = _loc12_[0];
         _loc13_.y = _loc12_[1];
      }
      
      private function convertPercent(param1:String, param2:Number) : Number
      {
         var _loc5_:Number = NaN;
         if(param1 == null || param1 == "")
         {
            return 0;
         }
         var _loc4_:int = param1.indexOf("%");
         var _loc3_:* = 0;
         if(_loc4_ == -1)
         {
            _loc3_ = Number(param1);
         }
         else
         {
            _loc5_ = param1.substring(0,_loc4_);
            _loc3_ = Number(param2 * (_loc5_ / 100));
         }
         return _loc3_;
      }
      
      private function autoResizeClear() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _autoResizeDic;
         for(var _loc2_ in _autoResizeDic)
         {
            _loc1_ = _autoResizeDic[_loc2_]["target"];
            if(_loc1_ == null || _loc1_.parent == null)
            {
               removeAutoResize(_loc2_);
            }
         }
      }
      
      private function addResizeObjInfo(param1:ResizeObjInfo) : void
      {
         var _loc2_:String = targetKey(param1.target);
         if(_loc2_ == "")
         {
            _loc2_ = "" + getIndex();
         }
         _autoResizeDic[_loc2_] = param1;
         if(StageReferance.isStageResize())
         {
            resizeTarget(param1);
         }
      }
      
      private function getIndex() : int
      {
         return _autoResizeDic.length;
      }
      
      private function targetKey(param1:DisplayObject) : String
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = _autoResizeDic;
         for(var _loc3_ in _autoResizeDic)
         {
            _loc2_ = _autoResizeDic[_loc3_]["target"];
            if(param1 == _loc2_)
            {
               return _loc3_;
            }
         }
         return "";
      }
      
      public function removeResizeObj(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = targetKey(param1);
         if(_loc2_ != "")
         {
            removeAutoResize(_loc2_);
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
