package com.pickgliss.ui.core
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SpriteLayer extends Sprite
   {
       
      
      private var _blackGoundList:Vector.<DisplayObject>;
      
      private var _alphaGoundList:Vector.<DisplayObject>;
      
      private var _blackGound:Sprite;
      
      private var _alphaGound:Sprite;
      
      private var _autoClickTotop:Boolean;
      
      public function SpriteLayer(param1:Boolean = false)
      {
         init();
         super();
         mouseEnabled = param1;
      }
      
      private function init() : void
      {
         _blackGoundList = new Vector.<DisplayObject>();
         _alphaGoundList = new Vector.<DisplayObject>();
      }
      
      public function addTolayer(param1:DisplayObject, param2:int, param3:Boolean) : void
      {
         if(param2 == 1)
         {
            if(_blackGoundList.indexOf(param1) != -1)
            {
               _blackGoundList.splice(_blackGoundList.indexOf(param1),1);
            }
            _blackGoundList.push(param1);
         }
         else if(param2 == 2)
         {
            if(_alphaGoundList.indexOf(param1) != -1)
            {
               _alphaGoundList.splice(_alphaGoundList.indexOf(param1),1);
            }
            _alphaGoundList.push(param1);
         }
         param1.addEventListener("removedFromStage",__onChildRemoveFromStage);
         if(param3)
         {
            param1.addEventListener("removedFromStage",__onFocusChange);
         }
         if(_autoClickTotop)
         {
            param1.addEventListener("mouseDown",__onClickToTop);
         }
         addChild(param1);
         arrangeBlockGound();
         if(param3)
         {
            focusTopLayerDisplay();
         }
      }
      
      private function __onClickToTop(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         addChild(_loc2_);
         focusTopLayerDisplay();
      }
      
      private function __onFocusChange(param1:Event) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         _loc2_.removeEventListener("removedFromStage",__onFocusChange);
         focusTopLayerDisplay(_loc2_);
      }
      
      private function __onChildRemoveFromStage(param1:Event) : void
      {
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         _loc2_.removeEventListener("removedFromStage",__onChildRemoveFromStage);
         _loc2_.removeEventListener("mouseDown",__onClickToTop);
         if(_blackGoundList.indexOf(_loc2_) != -1)
         {
            _blackGoundList.splice(_blackGoundList.indexOf(_loc2_),1);
         }
         if(_alphaGoundList.indexOf(_loc2_) != -1)
         {
            _alphaGoundList.splice(_alphaGoundList.indexOf(_loc2_),1);
         }
         arrangeBlockGound();
      }
      
      private function arrangeBlockGound() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(blackGound.parent)
         {
            blackGound.parent.removeChild(blackGound);
         }
         if(alphaGound.parent)
         {
            alphaGound.parent.removeChild(alphaGound);
         }
         if(_blackGoundList.length > 0)
         {
            _loc1_ = _blackGoundList[_blackGoundList.length - 1];
            _loc2_ = getChildIndex(_loc1_);
            addChildAt(blackGound,_loc2_);
         }
         if(_alphaGoundList.length > 0)
         {
            _loc1_ = _alphaGoundList[_alphaGoundList.length - 1];
            _loc2_ = getChildIndex(_loc1_);
            addChildAt(alphaGound,_loc2_);
         }
      }
      
      private function focusTopLayerDisplay(param1:DisplayObject = null) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _loc4_ = 0;
         while(_loc4_ < numChildren)
         {
            _loc2_ = getChildAt(_loc4_);
            if(_loc2_ != param1)
            {
               _loc3_ = _loc2_ as InteractiveObject;
            }
            _loc4_++;
         }
         if(!DisplayUtils.isTargetOrContain(StageReferance.stage.focus,_loc3_))
         {
            StageReferance.stage.focus = _loc3_;
         }
      }
      
      public function get backGroundInParent() : Boolean
      {
         if(_blackGoundList.length > 0 || _alphaGoundList.length > 0)
         {
            return true;
         }
         return false;
      }
      
      private function get blackGound() : Sprite
      {
         if(_blackGound == null)
         {
            _blackGound = new Sprite();
            _blackGound.graphics.beginFill(0,0.4);
            _blackGound.graphics.drawRect(-500,-200,2000,1000);
            _blackGound.graphics.endFill();
            _blackGound.addEventListener("mouseDown",__onBlackGoundMouseDown);
         }
         return _blackGound;
      }
      
      private function __onBlackGoundMouseDown(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         StageReferance.stage.focus = _blackGoundList[_blackGoundList.length - 1] as InteractiveObject;
      }
      
      private function get alphaGound() : Sprite
      {
         if(_alphaGound == null)
         {
            _alphaGound = new Sprite();
            _alphaGound.graphics.beginFill(0,0.001);
            _alphaGound.graphics.drawRect(-500,-200,2000,1000);
            _alphaGound.graphics.endFill();
            _alphaGound.addEventListener("mouseDown",__onAlphaGoundDownClicked);
            _alphaGound.addEventListener("mouseUp",__onAlphaGoundUpClicked);
         }
         return _alphaGound;
      }
      
      private function __onAlphaGoundDownClicked(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = _alphaGoundList[_alphaGoundList.length - 1];
         _loc2_.filters = ComponentFactory.Instance.creatFilters("alphaLayerGilter");
         StageReferance.stage.focus = _loc2_ as InteractiveObject;
      }
      
      private function __onAlphaGoundUpClicked(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = _alphaGoundList[_alphaGoundList.length - 1];
         _loc2_.filters = null;
      }
      
      public function set autoClickTotop(param1:Boolean) : void
      {
         if(_autoClickTotop == param1)
         {
            return;
         }
         _autoClickTotop = param1;
      }
   }
}
