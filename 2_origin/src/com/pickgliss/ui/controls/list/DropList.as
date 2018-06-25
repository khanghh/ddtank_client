package com.pickgliss.ui.controls.list
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.cell.IDropListCell;
   import com.pickgliss.ui.controls.container.BoxContainer;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class DropList extends Component implements Disposeable
   {
      
      public static const SELECTED:String = "selected";
      
      public static const P_backgound:String = "backgound";
      
      public static const P_container:String = "container";
       
      
      private var _backStyle:String;
      
      private var _backGround:DisplayObject;
      
      private var _cellStyle:String;
      
      private var _containerStyle:String;
      
      private var _container:BoxContainer;
      
      private var _targetDisplay:IDropListTarget;
      
      private var _showLength:int;
      
      private var _dataList:Array;
      
      private var _items:Vector.<IDropListCell>;
      
      private var _currentSelectedIndex:int;
      
      private var _preItemIdx:int;
      
      private var _cellHeight:int;
      
      private var _cellWidth:int;
      
      private var _isListening:Boolean;
      
      private var _canUseEnter:Boolean = true;
      
      public function DropList()
      {
         super();
      }
      
      override protected function init() : void
      {
         _items = new Vector.<IDropListCell>();
      }
      
      public function set container(value:BoxContainer) : void
      {
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         _container = value;
         onPropertiesChanged("container");
      }
      
      public function set containerStyle(value:String) : void
      {
         if(_containerStyle == value)
         {
            return;
         }
         _containerStyle = value;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         container = ComponentFactory.Instance.creat(_containerStyle);
      }
      
      public function set cellStyle(value:String) : void
      {
         if(_cellStyle == value)
         {
            return;
         }
         _cellStyle = value;
      }
      
      public function set dataList(value:Array) : void
      {
         var i:* = 0;
         if(!value)
         {
            if(parent)
            {
               parent.removeChild(this);
            }
            return;
         }
         if(_targetDisplay.parent)
         {
            _targetDisplay.parent.addChild(this);
         }
         _dataList = value;
         var len:int = Math.min(_dataList.length,_showLength);
         for(i = 0; i < len; )
         {
            _items[i].setCellValue(_dataList[i]);
            if(!_container.contains(_items[i].asDisplayObject()))
            {
               _container.addChild(_items[i].asDisplayObject());
            }
            i++;
         }
         if(len == 0)
         {
            _items[0].setCellValue(null);
            if(!_container.contains(_items[i].asDisplayObject()))
            {
               _container.addChild(_items[i].asDisplayObject());
            }
            len = 1;
         }
         for(i = len; i < _showLength; )
         {
            if(_container.contains(_items[i].asDisplayObject()))
            {
               _container.removeChild(_items[i].asDisplayObject());
            }
            i++;
         }
         updateBg();
         unSelectedAllItems();
         _currentSelectedIndex = 0;
         _items[_currentSelectedIndex].selected = true;
      }
      
      private function updateBg() : void
      {
         if(_container.numChildren == 0)
         {
            if(contains(_backGround))
            {
               removeChild(_backGround);
            }
         }
         else
         {
            _backGround.width = _cellWidth + 2 * _container.x + 20;
            _backGround.height = _container.numChildren * (_cellHeight + _container.spacing) - _container.spacing + 2 * _container.y;
            addChildAt(_backGround,0);
         }
      }
      
      private function getHightLightItemIdx() : int
      {
         var i:int = 0;
         for(i = 0; i < _showLength; )
         {
            if(_items[i].selected)
            {
               return i;
            }
            i++;
         }
         return 0;
      }
      
      private function unSelectedAllItems() : int
      {
         var idx:* = 0;
         var i:int = 0;
         for(i = 0; i < _showLength; )
         {
            if(_items[i].selected)
            {
               idx = i;
            }
            _items[i].selected = false;
            i++;
         }
         return idx;
      }
      
      private function updateItemValue(isUpWard:Boolean = false) : void
      {
         var i:int = 0;
         for(i = 0; i < _showLength; )
         {
            _items[i].setCellValue(_dataList[_currentSelectedIndex - getHightLightItemIdx() + i]);
            i++;
         }
      }
      
      private function setHightLightItem(isUpWard:Boolean = false) : void
      {
         var idx:int = 0;
         if(_dataList.length > 0)
         {
            idx = getHightLightItemIdx();
            if(!isUpWard)
            {
               if(idx < _showLength - 1)
               {
                  unSelectedAllItems();
                  idx++;
               }
               else if(idx >= _showLength - 1)
               {
                  updateItemValue();
               }
            }
            if(isUpWard)
            {
               if(idx > 0)
               {
                  unSelectedAllItems();
                  idx--;
               }
               else if(idx == 0)
               {
                  updateItemValue(true);
               }
            }
            _items[idx].selected = true;
         }
         else
         {
            _currentSelectedIndex = 0;
         }
         setTargetValue();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_backGround)
         {
            addChild(_backGround);
         }
         if(_container)
         {
            addChild(_container);
         }
      }
      
      public function set targetDisplay(target:IDropListTarget) : void
      {
         if(target == _targetDisplay)
         {
            return;
         }
         _targetDisplay = target;
         _targetDisplay.addEventListener("keyDown",__onKeyDown);
         _targetDisplay.addEventListener("removedFromStage",__onRemoveFromStage);
      }
      
      private function __onRemoveFromStage(event:Event) : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set showLength(value:int) : void
      {
         var cell:* = undefined;
         if(_showLength == value)
         {
            return;
         }
         _showLength = value;
         while(_container.numChildren > _showLength)
         {
            _container.removeChild(_items.pop() as DisplayObject);
         }
         while(_container.numChildren < _showLength)
         {
            if(_items.length > _container.numChildren)
            {
               _container.addChild(_items[_container.numChildren].asDisplayObject());
            }
            else
            {
               cell = ComponentFactory.Instance.creat(_cellStyle);
               cell.addEventListener("mouseOver",__onCellMouseOver);
               cell.addEventListener("click",__onCellMouseClick);
               _items.push(cell);
               _container.addChild(cell);
            }
         }
         _cellHeight = cell.height;
         _cellWidth = cell.width;
         updateBg();
      }
      
      private function __onCellMouseClick(event:MouseEvent) : void
      {
         ComponentSetting.PLAY_SOUND_FUNC("008");
         setTargetValue();
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("selected"));
      }
      
      private function __onCellMouseOver(event:MouseEvent) : void
      {
         var preIdx:int = unSelectedAllItems();
         var newIdx:int = _items.indexOf(event.currentTarget as IDropListCell);
         _currentSelectedIndex = _currentSelectedIndex + (newIdx - preIdx);
         event.currentTarget.selected = true;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backgound"] || _changedPropeties["container"])
         {
            addChildren();
         }
      }
      
      private function __onKeyDown(event:KeyboardEvent) : void
      {
         if(_dataList == null)
         {
            return;
         }
         event.stopImmediatePropagation();
         event.stopPropagation();
         if(!_isListening && event.keyCode == 13)
         {
            _isListening = true;
            StageReferance.stage.addEventListener("enterFrame",__setSelection);
         }
         var _loc2_:* = event.keyCode;
         if(38 !== _loc2_)
         {
            if(40 !== _loc2_)
            {
               if(13 === _loc2_)
               {
                  if(_canUseEnter == false)
                  {
                     return;
                  }
                  ComponentSetting.PLAY_SOUND_FUNC("008");
                  if(parent)
                  {
                     parent.removeChild(this);
                  }
                  _targetDisplay.setValue(_dataList[_currentSelectedIndex]);
                  dispatchEvent(new Event("selected"));
               }
            }
            else
            {
               ComponentSetting.PLAY_SOUND_FUNC("008");
               if(_currentSelectedIndex == _dataList.length - 1)
               {
                  return;
               }
               _currentSelectedIndex = Number(_currentSelectedIndex) + 1;
               setHightLightItem();
            }
         }
         else
         {
            ComponentSetting.PLAY_SOUND_FUNC("008");
            if(_currentSelectedIndex == 0)
            {
               return;
            }
            _currentSelectedIndex = Number(_currentSelectedIndex) - 1;
            setHightLightItem(true);
         }
      }
      
      public function set canUseEnter(boo:Boolean) : void
      {
         _canUseEnter = boo;
      }
      
      public function get canUseEnter() : Boolean
      {
         return _canUseEnter;
      }
      
      public function set currentSelectedIndex(idx:int) : void
      {
         if(_dataList == null)
         {
            return;
         }
         ComponentSetting.PLAY_SOUND_FUNC("008");
         if(_currentSelectedIndex == _dataList.length - 1 || _currentSelectedIndex == 0)
         {
            return;
         }
         _currentSelectedIndex = _currentSelectedIndex + idx;
         setHightLightItem();
      }
      
      private function setTargetValue() : void
      {
         if(!_targetDisplay.parent)
         {
            _targetDisplay.parent.addChild(this);
         }
         if(_dataList)
         {
            _targetDisplay.setValue(_dataList[_currentSelectedIndex]);
         }
      }
      
      private function __setSelection(event:Event) : void
      {
         if(_targetDisplay.caretIndex == _targetDisplay.getValueLength())
         {
            _isListening = false;
            StageReferance.stage.removeEventListener("enterFrame",__setSelection);
         }
         else
         {
            _targetDisplay.setCursor(_targetDisplay.getValueLength());
         }
      }
      
      public function set backStyle(stylename:String) : void
      {
         if(_backStyle == stylename)
         {
            return;
         }
         _backStyle = stylename;
         backgound = ComponentFactory.Instance.creat(_backStyle);
      }
      
      public function set backgound(image:DisplayObject) : void
      {
         if(_backGround == image)
         {
            return;
         }
         ObjectUtils.disposeObject(_backGround);
         _backGround = image;
         if(_backGround is InteractiveObject)
         {
            InteractiveObject(_backGround).mouseEnabled = true;
         }
         onPropertiesChanged("backgound");
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         if(parent)
         {
            parent.removeChild(this);
         }
         StageReferance.stage.removeEventListener("keyDown",__onKeyDown);
         StageReferance.stage.removeEventListener("enterFrame",__setSelection);
         _targetDisplay.removeEventListener("keyDown",__onKeyDown);
         if(_backGround)
         {
            ObjectUtils.disposeObject(_backGround);
         }
         _backGround = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         if(_targetDisplay)
         {
            ObjectUtils.disposeObject(_targetDisplay);
         }
         _targetDisplay = null;
         for(i = 0; i < _items.length; )
         {
            if(_items[i])
            {
               ObjectUtils.disposeObject(_items[i]);
            }
            _items[i] = null;
            i++;
         }
         _dataList = null;
         super.dispose();
      }
   }
}
