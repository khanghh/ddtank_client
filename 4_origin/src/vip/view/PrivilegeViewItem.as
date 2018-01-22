package vip.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class PrivilegeViewItem extends Sprite implements Disposeable
   {
      
      public static const TRUE_FLASE_TYPE:int = 0;
      
      public static const UNIT_TYPE:int = 1;
      
      public static const GRAPHICS_TYPE:int = 2;
      
      public static const NORMAL_TYPE:int = 3;
      
      public static const ICON_TYPE:int = 4;
      
      public static const GOODS_TYPE:int = 5;
       
      
      private var _bg:Image;
      
      private var _seperators:Image;
      
      private var _titleTxt:FilterFrameText;
      
      private var _content:Vector.<String>;
      
      private var _displayContent:Vector.<DisplayObject>;
      
      private var _itemType:int;
      
      private var _extraDisplayObject;
      
      private var _extraDisplayObjectList:Vector.<DisplayObject>;
      
      private var _interceptor:Function;
      
      private var _analyzeFunction:Function;
      
      private var _crossFilter:String = "0";
      
      public function PrivilegeViewItem(param1:int = 3, param2:* = null)
      {
         super();
         _itemType = param1;
         _extraDisplayObject = param2;
         _extraDisplayObjectList = new Vector.<DisplayObject>();
         _analyzeFunction = analyzeContent;
         if(_itemType == 4)
         {
            _analyzeFunction = analyzeContentForTypeIcon;
         }
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItemBg");
         _seperators = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItemSeperators");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItemTitleTxt");
         addChild(_bg);
         addChild(_seperators);
         addChild(_titleTxt);
      }
      
      protected function analyzeContentForTypeIcon(param1:Array) : Vector.<DisplayObject>
      {
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject("vip.levelPrivilegeItemTxtStartPos2");
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc8_ = param1[_loc7_] as ItemTemplateInfo;
            _loc5_ = _loc7_ + 1;
            _loc6_ = ComponentFactory.Instance.creat("vip.reward.lv" + _loc5_);
            _loc2_ = new BaseCell(_loc6_);
            _loc2_.info = _loc8_;
            _loc2_.getContent().visible = false;
            PositionUtils.setPos(_loc2_,_loc4_);
            _loc4_.x = _loc4_.x + (_loc2_.width + 7);
            _loc3_.push(_loc2_);
            _loc7_++;
         }
         return _loc3_;
      }
      
      protected function analyzeContent(param1:Vector.<String>) : Vector.<DisplayObject>
      {
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc11_:* = null;
         var _loc9_:* = null;
         var _loc3_:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var _loc5_:Point = ComponentFactory.Instance.creatCustomObject("vip.levelPrivilegeItemTxtStartPos");
         var _loc14_:int = 0;
         var _loc13_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc10_ = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItemTxt");
            _loc10_.text = _interceptor == null?_loc2_:_interceptor(_loc2_);
            PositionUtils.setPos(_loc10_,_loc5_);
            _loc5_.x = _loc5_.x + (_loc10_.width + 5);
            if(_loc2_ == _crossFilter)
            {
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.cross");
               _loc4_.x = _loc10_.width - _loc4_.width + _loc10_.x;
               _loc4_.y = _loc10_.y;
               _loc3_.push(_loc4_);
               continue;
            }
            switch(int(_itemType))
            {
               case 0:
                  _loc8_ = _loc2_ == "1"?ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.Tick"):ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.cross");
                  _loc8_.x = _loc10_.width - _loc8_.width + _loc10_.x;
                  _loc8_.y = _loc10_.y;
                  _loc3_.push(_loc8_);
                  continue;
               case 1:
                  _loc10_.text = _loc10_.text + String(_extraDisplayObject);
               case 2:
                  _loc7_ = new Sprite();
                  _loc6_ = ComponentFactory.Instance.creatBitmap(_extraDisplayObject);
                  _extraDisplayObjectList.push(_loc6_);
                  _extraDisplayObjectList.push(_loc10_);
                  _loc10_.width = _loc10_.width - _loc6_.width;
                  _loc6_.x = _loc10_.width + _loc10_.x;
                  _loc6_.y = _loc10_.y;
                  _loc7_.addChild(_loc10_);
                  _loc7_.addChild(_loc6_);
                  _loc3_.push(_loc7_);
                  continue;
               default:
               default:
                  _loc3_.push(_loc10_);
                  continue;
               case 5:
                  _loc11_ = ItemManager.fillByID(int(_loc2_));
                  _loc11_.IsBinds = true;
                  _loc9_ = new BagCell(0);
                  _loc9_.info = _loc11_;
                  _loc9_.setCountNotVisible();
                  var _loc12_:int = 30;
                  _loc9_.height = _loc12_;
                  _loc9_.width = _loc12_;
                  _loc9_.x = _loc10_.width - 32 + _loc10_.x;
                  _loc9_.y = 2;
                  _loc3_.push(_loc9_);
                  continue;
            }
         }
         return _loc3_;
      }
      
      public function set crossFilter(param1:String) : void
      {
         _crossFilter = param1;
      }
      
      public function set contentInterceptor(param1:Function) : void
      {
         _interceptor = param1;
      }
      
      public function set itemTitleText(param1:String) : void
      {
         _titleTxt.text = param1;
         if(_titleTxt.textHeight > 20)
         {
            _titleTxt.y = 2;
         }
      }
      
      public function set analyzeFunction(param1:Function) : void
      {
         _analyzeFunction = param1;
      }
      
      public function set itemContent(param1:Vector.<String>) : void
      {
         _content = param1;
         _displayContent = _analyzeFunction(_content);
         updateView();
      }
      
      public function set itemContentForIcontype(param1:Array) : void
      {
         _displayContent = _analyzeFunction(param1);
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _displayContent;
         for each(var _loc1_ in _displayContent)
         {
            addChild(_loc1_);
         }
      }
      
      public function dispose() : void
      {
         if(_displayContent != null)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _displayContent;
            for each(var _loc2_ in _displayContent)
            {
               ObjectUtils.disposeObject(_loc2_);
            }
         }
         _displayContent = null;
         var _loc6_:int = 0;
         var _loc5_:* = _extraDisplayObjectList;
         for each(var _loc1_ in _extraDisplayObjectList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _extraDisplayObjectList = null;
         ObjectUtils.disposeObject(_bg);
         ObjectUtils.disposeObject(_seperators);
         ObjectUtils.disposeObject(_titleTxt);
         _bg = null;
         _seperators = null;
         _titleTxt = null;
      }
   }
}
