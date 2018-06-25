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
      
      public function ItemCellView(index:uint = 0, item:DisplayObject = null, isCount:Boolean = false, EffectType:String = "")
      {
         super();
         _effectType = EffectType;
         _container = new Sprite();
         addChild(_container);
         _index = index;
         initItemBg();
         _container.addChild(_asset);
         _asset.x = -_asset.width / 2;
         _asset.y = -_asset.height / 2;
         _container.x = _asset.width / 2;
         _container.y = _asset.height / 2;
         setItem(item,false);
         setEffectType(EffectType);
      }
      
      public function setClick(clickAble:Boolean, isGray:Boolean, isExist:Boolean) : void
      {
         _clickAble = clickAble;
         setGrayII(isGray,isExist);
      }
      
      protected function initItemBg() : void
      {
         _asset = ComponentFactory.Instance.creatBitmap("bagAndInfo.bag.propItemBgAssetAsset");
      }
      
      private function setEffectType(EffectType:String) : void
      {
         var _loc2_:* = EffectType;
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
      
      private function __click(event:MouseEvent) : void
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
      
      private function __over(event:Event) : void
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
      
      private function __out(event:Event) : void
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
      
      private function __move(event:MouseEvent) : void
      {
         dispatchEvent(new ItemEvent("itemMove",item,_index));
      }
      
      public function get item() : DisplayObject
      {
         return _item;
      }
      
      public function setItem(value:DisplayObject, isGray:Boolean) : void
      {
         var ps:* = null;
         if(_item)
         {
            removeEvent();
            ObjectUtils.disposeObject(_item);
         }
         _item = value;
         if(_item)
         {
            mouseEnabled = true;
            buttonMode = true;
            addEvent();
            ps = new Sprite();
            _container.addChild(ps);
            ps.addChild(_item);
            if(_letterTip)
            {
               _container.swapChildren(ps,_letterTip);
            }
            ps.x = -20;
            ps.y = -20;
            if(_item is PropItemView)
            {
               setGrayII(isGray,PropItemView(_item).isExist);
            }
            else
            {
               setGrayII(isGray,true);
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
      
      public function seleted(value:Boolean) : void
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
      
      public function setBackgroundVisible(value:Boolean) : void
      {
         _asset.alpha = !!value?1:0;
      }
      
      public function setGrayII(isGray:Boolean, isExist:Boolean) : void
      {
         if(item)
         {
            _isGray = isGray;
            if(!isGray && isExist)
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
