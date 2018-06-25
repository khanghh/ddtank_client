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
      
      public function SpriteLayer(enableMouse:Boolean = false)
      {
         init();
         super();
         mouseEnabled = enableMouse;
      }
      
      private function init() : void
      {
         _blackGoundList = new Vector.<DisplayObject>();
         _alphaGoundList = new Vector.<DisplayObject>();
      }
      
      public function addTolayer(child:DisplayObject, blockGound:int, focusTop:Boolean) : void
      {
         if(blockGound == 1)
         {
            if(_blackGoundList.indexOf(child) != -1)
            {
               _blackGoundList.splice(_blackGoundList.indexOf(child),1);
            }
            _blackGoundList.push(child);
         }
         else if(blockGound == 2)
         {
            if(_alphaGoundList.indexOf(child) != -1)
            {
               _alphaGoundList.splice(_alphaGoundList.indexOf(child),1);
            }
            _alphaGoundList.push(child);
         }
         child.addEventListener("removedFromStage",__onChildRemoveFromStage);
         if(focusTop)
         {
            child.addEventListener("removedFromStage",__onFocusChange);
         }
         if(_autoClickTotop)
         {
            child.addEventListener("mouseDown",__onClickToTop);
         }
         addChild(child);
         arrangeBlockGound();
         if(focusTop)
         {
            focusTopLayerDisplay();
         }
      }
      
      private function __onClickToTop(event:MouseEvent) : void
      {
         var child:DisplayObject = event.currentTarget as DisplayObject;
         addChild(child);
         focusTopLayerDisplay();
      }
      
      private function __onFocusChange(event:Event) : void
      {
         var child:DisplayObject = event.currentTarget as DisplayObject;
         child.removeEventListener("removedFromStage",__onFocusChange);
         focusTopLayerDisplay(child);
      }
      
      private function __onChildRemoveFromStage(event:Event) : void
      {
         var child:DisplayObject = event.currentTarget as DisplayObject;
         child.removeEventListener("removedFromStage",__onChildRemoveFromStage);
         child.removeEventListener("mouseDown",__onClickToTop);
         if(_blackGoundList.indexOf(child) != -1)
         {
            _blackGoundList.splice(_blackGoundList.indexOf(child),1);
         }
         if(_alphaGoundList.indexOf(child) != -1)
         {
            _alphaGoundList.splice(_alphaGoundList.indexOf(child),1);
         }
         arrangeBlockGound();
      }
      
      private function arrangeBlockGound() : void
      {
         var child:* = null;
         var childIndex:int = 0;
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
            child = _blackGoundList[_blackGoundList.length - 1];
            childIndex = getChildIndex(child);
            addChildAt(blackGound,childIndex);
         }
         if(_alphaGoundList.length > 0)
         {
            child = _alphaGoundList[_alphaGoundList.length - 1];
            childIndex = getChildIndex(child);
            addChildAt(alphaGound,childIndex);
         }
      }
      
      private function focusTopLayerDisplay(exclude:DisplayObject = null) : void
      {
         var lastFocus:* = null;
         var i:int = 0;
         var child:* = null;
         for(i = 0; i < numChildren; )
         {
            child = getChildAt(i);
            if(child != exclude)
            {
               lastFocus = child as InteractiveObject;
            }
            i++;
         }
         if(!DisplayUtils.isTargetOrContain(StageReferance.stage.focus,lastFocus))
         {
            StageReferance.stage.focus = lastFocus;
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
      
      private function __onBlackGoundMouseDown(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
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
      
      private function __onAlphaGoundDownClicked(event:MouseEvent) : void
      {
         var target:DisplayObject = _alphaGoundList[_alphaGoundList.length - 1];
         target.filters = ComponentFactory.Instance.creatFilters("alphaLayerGilter");
         StageReferance.stage.focus = target as InteractiveObject;
      }
      
      private function __onAlphaGoundUpClicked(event:MouseEvent) : void
      {
         var target:DisplayObject = _alphaGoundList[_alphaGoundList.length - 1];
         target.filters = null;
      }
      
      public function set autoClickTotop(value:Boolean) : void
      {
         if(_autoClickTotop == value)
         {
            return;
         }
         _autoClickTotop = value;
      }
   }
}
