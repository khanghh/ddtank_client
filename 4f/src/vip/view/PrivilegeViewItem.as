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
      
      public function PrivilegeViewItem(param1:int = 3, param2:* = null){super();}
      
      private function initView() : void{}
      
      protected function analyzeContentForTypeIcon(param1:Array) : Vector.<DisplayObject>{return null;}
      
      protected function analyzeContent(param1:Vector.<String>) : Vector.<DisplayObject>{return null;}
      
      public function set crossFilter(param1:String) : void{}
      
      public function set contentInterceptor(param1:Function) : void{}
      
      public function set itemTitleText(param1:String) : void{}
      
      public function set analyzeFunction(param1:Function) : void{}
      
      public function set itemContent(param1:Vector.<String>) : void{}
      
      public function set itemContentForIcontype(param1:Array) : void{}
      
      private function updateView() : void{}
      
      public function dispose() : void{}
   }
}
