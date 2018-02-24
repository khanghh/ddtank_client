package ddt.manager
{
   import bagAndInfo.cell.BaseCell;
   import com.greensock.TimelineLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Sine;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.TweenVars;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.utils.MovieClipWrapper;
   
   public class DropGoodsManager implements Disposeable
   {
      
      private static var _isEmailAniam:Boolean = true;
       
      
      public var parentContainer:DisplayObjectContainer;
      
      public var beginPoint:Point;
      
      public var endPoint:Point;
      
      private var goodsList:Vector.<ItemTemplateInfo>;
      
      private var timeOutIdArr:Array;
      
      private var tweenArr:Array;
      
      private var intervalId:uint;
      
      private var goodsTipList:Vector.<ItemTemplateInfo>;
      
      private var _info:InventoryItemInfo;
      
      public function DropGoodsManager(param1:Point, param2:Point){super();}
      
      public static function play(param1:Array, param2:Point = null, param3:Point = null, param4:Boolean = false) : void{}
      
      private function onPetCompletePackUp(param1:DisplayObject) : void{}
      
      private function packUp(param1:DisplayObject, param2:Function) : void{}
      
      private function onCompletePackUp(param1:DisplayObject) : void{}
      
      private function getBagAniam() : MovieClipWrapper{return null;}
      
      private function getEmailAniam() : MovieClipWrapper{return null;}
      
      private function setGoodsList(param1:Array) : void{}
      
      public function dispose() : void{}
   }
}
