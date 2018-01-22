package gameCommon.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.ItemEvent;
   import ddt.view.PropItemView;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import gameCommon.GameControl;
   
   [Event(name="itemClick",type="tank.view.items.ItemEvent")]
   [Event(name="itemOver",type="tank.view.items.ItemEvent")]
   [Event(name="itemOut",type="tank.view.items.ItemEvent")]
   [Event(name="itemMove",type="tank.view.items.ItemEvent")]
   public class ItemCellView extends Sprite implements Disposeable
   {
      
      public static const RIGHT_PROP:String = "rightPropView";
      
      public static const PROP_SHORT:String = "propShortCutView";
       
      
      protected var _item:DisplayObject;
      
      protected var _asset:Bitmap;
      
      private var _index:uint;
      
      private var _clickAble:Boolean;
      
      private var _isDisable:Boolean;
      
      private var _isGray:Boolean;
      
      private var _container:Sprite;
      
      private var _letterTip:Bitmap;
      
      private var _effectType:String;
      
      public function ItemCellView(param1:uint = 0, param2:DisplayObject = null, param3:Boolean = false, param4:String = "")
      {
         super();
         _effectType = param4;
         _container = new Sprite();
         addChild(_container);
         _index = param1;
         initItemBg();
         _container.addChild(_asset);
         _asset.x = -_asset.width / 2;
         _asset.y = -_asset.height / 2;
         _container.x = _asset.width / 2;
         _container.y = _asset.height / 2;
         setItem(param2,false);
         setEffectType(param4);
      }
      
      public function setClick(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         _clickAble = param1;
         setGrayII(param2,param3);
      }
      
      protected function initItemBg() : void
      {
         _asset = ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.propItemBgAssetAsset");
      }
      
      private function setEffectType(param1:String) : void
      {
         var _loc2_:* = param1;
         if("rightPropView" !== _loc2_)
         {
            if("propShortCutView" === _loc2_)
            {
               _letterTip = ComponentFactory.Instance.creatBitmap("asset.game.itemCell.letter" + (index + 1));
            }
         }
         else
         {
            _letterTip = ComponentFactory.Instance.creatBitmap("asset.game.itemCell.tip" + (index + 1));
         }
         if(_letterTip)
         {
            _container.addChild(_letterTip);
            _letterTip.x = _asset.x + _asset.width - _letterTip.width;
            _letterTip.y = _asset.y;
         }
      }
      
      override public function get height() : Number
      {
         return _asset.height;
      }
      
      private function __click(param1:MouseEvent) : void
      {
         stage.focus = this;
         if(_clickAble && _item)
         {
            dispatchEvent(new ItemEvent("itemClick",item,_index));
         }
      }
      
      public function mouseClick() : void
      {
         if(_isDisable || !visible)
         {
            return;
         }
         __click(null);
      }
      
      private function __over(param1:Event) : void
      {
         if(!_isGray && _item && _effectType != "")
         {
            showEffect();
         }
         if(!_isGray && _item)
         {
            dispatchEvent(new ItemEvent("itemOver",item,_index));
         }
      }
      
      private function __out(param1:Event) : void
      {
         hideEffect();
         dispatchEvent(new ItemEvent("itemOut",item,_index));
      }
      
      private function showEffect() : void
      {
         TweenMax.to(this,0.5,{
            "repeat":-1,
            "yoyo":true,
            "glowFilter":{
               "color":16777011,
               "alpha":1,
               "blurX":8,
               "blurY":8,
               "strength":3
            }
         });
         TweenMax.to(_container,0.1,{
            "scaleX":1.2,
            "scaleY":1.2
         });
      }
      
      private function hideEffect() : void
      {
         TweenMax.killChildTweensOf(this.parent);
         this.filters = null;
         _container.scaleX = 1;
         _container.scaleY = 1;
      }
      
      private function __effectEnd() : void
      {
      }
      
      private function __move(param1:MouseEvent) : void
      {
         dispatchEvent(new ItemEvent("itemMove",item,_index));
      }
      
      public function get item() : DisplayObject
      {
         return _item;
      }
      
      public function setItem(param1:DisplayObject, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(_item)
         {
            removeEvent();
            ObjectUtils.disposeObject(_item);
         }
         _item = param1;
         if(_item)
         {
            mouseEnabled = true;
            buttonMode = true;
            addEvent();
            _loc3_ = new Sprite();
            _container.addChild(_loc3_);
            _loc3_.addChild(_item);
            if(_letterTip)
            {
               _container.swapChildren(_loc3_,_letterTip);
            }
            _loc3_.x = -20;
            _loc3_.y = -20;
            if(_item is PropItemView)
            {
               setGrayII(param2,PropItemView(_item).isExist);
            }
            else
            {
               setGrayII(param2,true);
            }
         }
         else
         {
            buttonMode = false;
            mouseEnabled = false;
         }
         setItemWidthAndHeight();
      }
      
      protected function setItemWidthAndHeight() : void
      {
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__click);
         item.addEventListener("over",__over);
         item.addEventListener("out",__out);
         addEventListener("mouseMove",__move);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__click);
         if(item)
         {
            item.removeEventListener("over",__over);
            item.removeEventListener("out",__out);
         }
         removeEventListener("mouseMove",__move);
      }
      
      public function seleted(param1:Boolean) : void
      {
      }
      
      public function disable() : void
      {
         if(GameControl.Instance.Current.selfGamePlayer.isAttacking)
         {
            removeEvent();
            _isDisable = true;
            setGrayII(false,false);
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function setBackgroundVisible(param1:Boolean) : void
      {
         _asset.alpha = !!param1?1:0;
      }
      
      public function setGrayII(param1:Boolean, param2:Boolean) : void
      {
         if(item)
         {
            _isGray = param1;
            if(!param1 && param2)
            {
               if(_isDisable)
               {
                  addEvent();
                  _isDisable = false;
               }
               item.filters = null;
            }
            else
            {
               hideEffect();
               item.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_asset)
         {
            if(_asset.parent)
            {
               _asset.parent.removeChild(_asset);
            }
            if(_asset.bitmapData)
            {
               _asset.bitmapData.dispose();
            }
         }
         if(_letterTip)
         {
            ObjectUtils.disposeObject(_letterTip);
         }
         _letterTip = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         _asset = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
