package ddt.view.caddyII.bead
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class QuickBuyItem extends Sprite implements Disposeable
   {
      
      private static const HammerJumpStep:int = 5;
      
      private static const PotJumpStep:int = 1;
      
      private static const HammerTemplateID:int = 11456;
      
      private static const PotTemplateID:int = 112047;
       
      
      private var _bg:ScaleFrameImage;
      
      private var _cell:BaseCell;
      
      private var _selectNumber:NumberSelecter;
      
      private var _count:int;
      
      private var _countField:FilterFrameText;
      
      private var _countPos:Point;
      
      private var _selsected:Boolean = false;
      
      private var _selectedBitmap:Scale9CornerImage;
      
      public function QuickBuyItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _countPos = ComponentFactory.Instance.creatCustomObject("caddyII.bead.QuickBuyItem.CountPos");
         _bg = ComponentFactory.Instance.creatComponentByStylename("caddy.QuickBuy.ItemCellBg");
         var size:Point = ComponentFactory.Instance.creatCustomObject("bead.quickCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,size.x,size.y);
         shape.graphics.endFill();
         _cell = ComponentFactory.Instance.creatCustomObject("bead.quickCell",[shape]);
         _selectNumber = ComponentFactory.Instance.creatCustomObject("bead.numberSelecter",[0]);
         _selectNumber.number = 0;
         _countField = ComponentFactory.Instance.creatComponentByStylename("caddy.QuickBuy.ItemCountField");
         _selectedBitmap = ComponentFactory.Instance.creatComponentByStylename("caddy.QuickBuy.ItemCellShin");
         addChild(_bg);
         addChild(_cell);
         addChild(_selectNumber);
         addChild(_countField);
         addChild(_selectedBitmap);
      }
      
      private function initEvents() : void
      {
         _selectNumber.addEventListener("change",_numberChange);
         _selectNumber.addEventListener("number_close",_numberClose);
      }
      
      private function removeEvents() : void
      {
         _selectNumber.removeEventListener("change",_numberChange);
         _selectNumber.removeEventListener("number_close",_numberClose);
      }
      
      private function _numberChange(e:Event) : void
      {
         if(_cell.info.TemplateID == 11456)
         {
            _countField.text = String(5 * _selectNumber.number);
            _countField.x = _countPos.x - _countField.width;
            _countField.y = _countPos.y - _countField.height;
         }
         else if(_cell.info.TemplateID == 112047)
         {
            _countField.text = String(1 * _selectNumber.number);
            _countField.x = _countPos.x - _countField.width;
            _countField.y = _countPos.y - _countField.height;
         }
         dispatchEvent(new Event("change"));
      }
      
      private function _numberClose(e:Event) : void
      {
         dispatchEvent(new Event("number_close"));
      }
      
      public function setFocus() : void
      {
         _selectNumber.setFocus();
      }
      
      public function set itemID(id:int) : void
      {
         _cell.info = ItemManager.Instance.getTemplateById(id);
         if(_cell.info.TemplateID == 11456)
         {
            _countField.text = String(5 * _selectNumber.number);
            _countField.x = _countPos.x - _countField.width;
            _countField.y = _countPos.y - _countField.height;
         }
         else if(_cell.info.TemplateID == 112047)
         {
            _countField.text = String(1 * _selectNumber.number);
            _countField.x = _countPos.x - _countField.width;
            _countField.y = _countPos.y - _countField.height;
         }
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _cell.info;
      }
      
      public function set count(value:int) : void
      {
         _selectNumber.number = value;
      }
      
      public function get count() : int
      {
         return _selectNumber.number;
      }
      
      public function get selected() : Boolean
      {
         return _selsected;
      }
      
      public function set selected(val:Boolean) : void
      {
         if(_selsected != val)
         {
            _selsected = val;
            _selectedBitmap.visible = _selsected;
         }
      }
      
      public function get selectNumber() : NumberSelecter
      {
         return _selectNumber;
      }
      
      public function set selectNumber(value:NumberSelecter) : void
      {
         _selectNumber = value;
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(_selectNumber)
         {
            ObjectUtils.disposeObject(_selectNumber);
         }
         _selectNumber = null;
         if(_selectedBitmap)
         {
            ObjectUtils.disposeObject(_selectedBitmap);
         }
         _selectedBitmap = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
