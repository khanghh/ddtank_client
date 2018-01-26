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
      
      public function StageResizeUtils(){super();}
      
      public static function get Instance() : StageResizeUtils{return null;}
      
      public function setup() : void{}
      
      private function __onResize(param1:Event) : void{}
      
      public function addAutoResize(param1:DisplayObject, param2:Boolean = true) : void{}
      
      public function addAutoResizeByStyle(param1:DisplayObject, param2:String, param3:Boolean = true) : void{}
      
      public function autoCenterResizeByStyle(param1:DisplayObject, param2:Boolean = true) : void{}
      
      private function removeAutoResize(param1:String) : void{}
      
      private function autoResize() : void{}
      
      private function resizeTarget(param1:ResizeObjInfo) : void{}
      
      private function convertPercent(param1:String, param2:Number) : Number{return 0;}
      
      private function autoResizeClear() : void{}
      
      private function addResizeObjInfo(param1:ResizeObjInfo) : void{}
      
      private function getIndex() : int{return 0;}
      
      private function targetKey(param1:DisplayObject) : String{return null;}
      
      public function removeResizeObj(param1:DisplayObject) : void{}
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
   
   function ResizeObjInfo(){super();}
}
