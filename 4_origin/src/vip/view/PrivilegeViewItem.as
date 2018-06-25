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
      
      public function PrivilegeViewItem(type:int = 3, object:* = null)
      {
         super();
         _itemType = type;
         _extraDisplayObject = object;
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
      
      protected function analyzeContentForTypeIcon(content:Array) : Vector.<DisplayObject>
      {
         var info:* = null;
         var bg:* = null;
         var i:int = 0;
         var lv:int = 0;
         var icon:* = null;
         var result:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var startPos:Point = ComponentFactory.Instance.creatCustomObject("vip.levelPrivilegeItemTxtStartPos2");
         for(i = 0; i < content.length; )
         {
            info = content[i] as ItemTemplateInfo;
            lv = i + 1;
            bg = ComponentFactory.Instance.creat("vip.reward.lv" + lv);
            icon = new BaseCell(bg);
            icon.info = info;
            icon.getContent().visible = false;
            PositionUtils.setPos(icon,startPos);
            startPos.x = startPos.x + (icon.width + 7);
            result.push(icon);
            i++;
         }
         return result;
      }
      
      protected function analyzeContent(content:Vector.<String>) : Vector.<DisplayObject>
      {
         var txt:* = null;
         var crossImg:* = null;
         var img:* = null;
         var sprite:* = null;
         var dis:* = null;
         var info:* = null;
         var _itemCell:* = null;
         var result:Vector.<DisplayObject> = new Vector.<DisplayObject>();
         var startPos:Point = ComponentFactory.Instance.creatCustomObject("vip.levelPrivilegeItemTxtStartPos");
         var _loc14_:int = 0;
         var _loc13_:* = content;
         for each(var con in content)
         {
            txt = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItemTxt");
            txt.text = _interceptor == null?con:_interceptor(con);
            PositionUtils.setPos(txt,startPos);
            startPos.x = startPos.x + (txt.width + 5);
            if(con == _crossFilter)
            {
               crossImg = ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.cross");
               crossImg.x = txt.width - crossImg.width + txt.x;
               crossImg.y = txt.y;
               result.push(crossImg);
               continue;
            }
            switch(int(_itemType))
            {
               case 0:
                  img = con == "1"?ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.Tick"):ComponentFactory.Instance.creatComponentByStylename("vip.PrivilegeViewItem.cross");
                  img.x = txt.width - img.width + txt.x;
                  img.y = txt.y;
                  result.push(img);
                  continue;
               case 1:
                  txt.text = txt.text + String(_extraDisplayObject);
               case 2:
                  sprite = new Sprite();
                  dis = ComponentFactory.Instance.creatBitmap(_extraDisplayObject);
                  _extraDisplayObjectList.push(dis);
                  _extraDisplayObjectList.push(txt);
                  txt.width = txt.width - dis.width;
                  dis.x = txt.width + txt.x;
                  dis.y = txt.y;
                  sprite.addChild(txt);
                  sprite.addChild(dis);
                  result.push(sprite);
                  continue;
               default:
               default:
                  result.push(txt);
                  continue;
               case 5:
                  info = ItemManager.fillByID(int(con));
                  info.IsBinds = true;
                  _itemCell = new BagCell(0);
                  _itemCell.info = info;
                  _itemCell.setCountNotVisible();
                  var _loc12_:int = 30;
                  _itemCell.height = _loc12_;
                  _itemCell.width = _loc12_;
                  _itemCell.x = txt.width - 32 + txt.x;
                  _itemCell.y = 2;
                  result.push(_itemCell);
                  continue;
            }
         }
         return result;
      }
      
      public function set crossFilter(value:String) : void
      {
         _crossFilter = value;
      }
      
      public function set contentInterceptor(value:Function) : void
      {
         _interceptor = value;
      }
      
      public function set itemTitleText(value:String) : void
      {
         _titleTxt.text = value;
         if(_titleTxt.textHeight > 20)
         {
            _titleTxt.y = 2;
         }
      }
      
      public function set analyzeFunction(val:Function) : void
      {
         _analyzeFunction = val;
      }
      
      public function set itemContent(contents:Vector.<String>) : void
      {
         _content = contents;
         _displayContent = _analyzeFunction(_content);
         updateView();
      }
      
      public function set itemContentForIcontype(contents:Array) : void
      {
         _displayContent = _analyzeFunction(contents);
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _displayContent;
         for each(var dis in _displayContent)
         {
            addChild(dis);
         }
      }
      
      public function dispose() : void
      {
         if(_displayContent != null)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _displayContent;
            for each(var o in _displayContent)
            {
               ObjectUtils.disposeObject(o);
            }
         }
         _displayContent = null;
         var _loc6_:int = 0;
         var _loc5_:* = _extraDisplayObjectList;
         for each(var dis in _extraDisplayObjectList)
         {
            ObjectUtils.disposeObject(dis);
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
