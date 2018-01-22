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
      
      public function set container(param1:BoxContainer) : void
      {
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         _container = param1;
         onPropertiesChanged("container");
      }
      
      public function set containerStyle(param1:String) : void
      {
         if(_containerStyle == param1)
         {
            return;
         }
         _containerStyle = param1;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
            _container = null;
         }
         container = ComponentFactory.Instance.creat(_containerStyle);
      }
      
      public function set cellStyle(param1:String) : void
      {
         if(_cellStyle == param1)
         {
            return;
         }
         _cellStyle = param1;
      }
      
      public function set dataList(param1:Array) : void
      {
         var _loc3_:* = 0;
         if(!param1)
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
         _dataList = param1;
         var _loc2_:int = Math.min(_dataList.length,_showLength);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _items[_loc3_].setCellValue(_dataList[_loc3_]);
            if(!_container.contains(_items[_loc3_].asDisplayObject()))
            {
               _container.addChild(_items[_loc3_].asDisplayObject());
            }
            _loc3_++;
         }
         if(_loc2_ == 0)
         {
            _items[0].setCellValue(null);
            if(!_container.contains(_items[_loc3_].asDisplayObject()))
            {
               _container.addChild(_items[_loc3_].asDisplayObject());
            }
            _loc2_ = 1;
         }
         _loc3_ = _loc2_;
         while(_loc3_ < _showLength)
         {
            if(_container.contains(_items[_loc3_].asDisplayObject()))
            {
               _container.removeChild(_items[_loc3_].asDisplayObject());
            }
            _loc3_++;
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _showLength)
         {
            if(_items[_loc1_].selected)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      private function unSelectedAllItems() : int
      {
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _showLength)
         {
            if(_items[_loc2_].selected)
            {
               _loc1_ = _loc2_;
            }
            _items[_loc2_].selected = false;
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function updateItemValue(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _showLength)
         {
            _items[_loc2_].setCellValue(_dataList[_currentSelectedIndex - getHightLightItemIdx() + _loc2_]);
            _loc2_++;
         }
      }
      
      private function setHightLightItem(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         if(_dataList.length > 0)
         {
            _loc2_ = getHightLightItemIdx();
            if(!param1)
            {
               if(_loc2_ < _showLength - 1)
               {
                  unSelectedAllItems();
                  _loc2_++;
               }
               else if(_loc2_ >= _showLength - 1)
               {
                  updateItemValue();
               }
            }
            if(param1)
            {
               if(_loc2_ > 0)
               {
                  unSelectedAllItems();
                  _loc2_--;
               }
               else if(_loc2_ == 0)
               {
                  updateItemValue(true);
               }
            }
            _items[_loc2_].selected = true;
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
      
      public function set targetDisplay(param1:IDropListTarget) : void
      {
         if(param1 == _targetDisplay)
         {
            return;
         }
         _targetDisplay = param1;
         _targetDisplay.addEventListener("keyDown",__onKeyDown);
         _targetDisplay.addEventListener("removedFromStage",__onRemoveFromStage);
      }
      
      private function __onRemoveFromStage(param1:Event) : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set showLength(param1:int) : void
      {
         var _loc2_:* = undefined;
         if(_showLength == param1)
         {
            return;
         }
         _showLength = param1;
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
               _loc2_ = ComponentFactory.Instance.creat(_cellStyle);
               _loc2_.addEventListener("mouseOver",__onCellMouseOver);
               _loc2_.addEventListener("click",__onCellMouseClick);
               _items.push(_loc2_);
               _container.addChild(_loc2_);
            }
         }
         _cellHeight = _loc2_.height;
         _cellWidth = _loc2_.width;
         updateBg();
      }
      
      private function __onCellMouseClick(param1:MouseEvent) : void
      {
         ComponentSetting.PLAY_SOUND_FUNC("008");
         setTargetValue();
         if(parent)
         {
            parent.removeChild(this);
         }
         dispatchEvent(new Event("selected"));
      }
      
      private function __onCellMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:int = unSelectedAllItems();
         var _loc2_:int = _items.indexOf(param1.currentTarget as IDropListCell);
         _currentSelectedIndex = _currentSelectedIndex + (_loc2_ - _loc3_);
         param1.currentTarget.selected = true;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backgound"] || _changedPropeties["container"])
         {
            addChildren();
         }
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(_dataList == null)
         {
            return;
         }
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         if(!_isListening && param1.keyCode == 13)
         {
            _isListening = true;
            StageReferance.stage.addEventListener("enterFrame",__setSelection);
         }
         var _loc2_:* = param1.keyCode;
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
      
      public function set canUseEnter(param1:Boolean) : void
      {
         _canUseEnter = param1;
      }
      
      public function get canUseEnter() : Boolean
      {
         return _canUseEnter;
      }
      
      public function set currentSelectedIndex(param1:int) : void
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
         _currentSelectedIndex = _currentSelectedIndex + param1;
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
      
      private function __setSelection(param1:Event) : void
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
      
      public function set backStyle(param1:String) : void
      {
         if(_backStyle == param1)
         {
            return;
         }
         _backStyle = param1;
         backgound = ComponentFactory.Instance.creat(_backStyle);
      }
      
      public function set backgound(param1:DisplayObject) : void
      {
         if(_backGround == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_backGround);
         _backGround = param1;
         if(_backGround is InteractiveObject)
         {
            InteractiveObject(_backGround).mouseEnabled = true;
         }
         onPropertiesChanged("backgound");
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            if(_items[_loc1_])
            {
               ObjectUtils.disposeObject(_items[_loc1_]);
            }
            _items[_loc1_] = null;
            _loc1_++;
         }
         _dataList = null;
         super.dispose();
      }
   }
}
