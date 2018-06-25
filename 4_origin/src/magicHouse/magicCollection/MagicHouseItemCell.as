package magicHouse.magicCollection
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import magicHouse.MagicHouseModel;
   import magicHouse.MagicHouseTipFrame;
   import shop.view.ShopItemCell;
   
   public class MagicHouseItemCell extends Sprite implements Disposeable
   {
       
      
      private var _type:int;
      
      private var _pos:int;
      
      private var _isOpen:Boolean = false;
      
      private var _info:ItemTemplateInfo;
      
      private var _cell:ShopItemCell;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _openEnable:Boolean;
      
      private var _frame:MagicHouseTipFrame;
      
      private var _alphaCell:Sprite;
      
      private var _itemContent:Component;
      
      public function MagicHouseItemCell()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _cell = createItemCell();
         addChild(_cell);
         _cell.x = -4;
         _cell.y = -3;
         _itemContent = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.itemTipContent");
         _alphaCell = ComponentFactory.Instance.creat("magichouse.collectionItem.alphaCell");
         _itemContent.addChild(_alphaCell);
         _itemContent.x = _cell.x;
         _itemContent.y = _cell.y;
         _alphaCell.width = 68;
         _alphaCell.height = 68;
         addChild(_itemContent);
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionView.itemCell.btn");
         addChild(_openBtn);
      }
      
      private function initEvent() : void
      {
         _openBtn.addEventListener("click",__openItem);
      }
      
      private function removeEvent() : void
      {
         _openBtn.removeEventListener("click",__openItem);
      }
      
      private function __openItem(e:MouseEvent) : void
      {
         if(_openEnable)
         {
            if(!_frame)
            {
               _frame = ComponentFactory.Instance.creatComponentByStylename("magichouse.tipFrame");
               _frame.titleText = LanguageMgr.GetTranslation("AlertDialog.Info");
               _frame.setTipText(LanguageMgr.GetTranslation("magichouse.collectionView.activateWeaponTip"));
               LayerManager.Instance.addToLayer(_frame,3,true,1);
               _frame.okBtn.addEventListener("click",__okBtnHandler);
               _frame.cancelBtn.addEventListener("click",__cancelBtnHandler);
               _frame.addEventListener("response",__confirmResponse);
            }
         }
      }
      
      private function __okBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _frame.removeEventListener("response",__okBtnHandler);
         ObjectUtils.disposeObject(_frame);
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
         _frame = null;
         _openEnable = false;
         SocketManager.Instance.out.openMagicLib(_type,_pos);
      }
      
      private function __cancelBtnHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _frame.removeEventListener("response",__okBtnHandler);
         ObjectUtils.disposeObject(_frame);
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
         _frame = null;
      }
      
      private function __confirmResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _frame.removeEventListener("response",__okBtnHandler);
         ObjectUtils.disposeObject(_frame);
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
         _frame = null;
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            _openEnable = false;
            SocketManager.Instance.out.openMagicLib(_type,_pos);
         }
      }
      
      public function setFilter() : void
      {
         var b:Boolean = MagicHouseModel.instance.equipOpenList[(_type - 1) * 3 + _pos];
         if(b)
         {
            if(_cell.getContent())
            {
               _cell.getContent().filters = [];
            }
         }
         else
         {
            _cell.getContent().filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
         _openBtn.visible = b;
         _openEnable = b;
      }
      
      public function setOpened($b:Boolean) : void
      {
         _isOpen = $b;
         _openBtn.visible = !$b;
      }
      
      public function set cellInfo($info:ItemTemplateInfo) : void
      {
         _info = $info;
         _cell.info = $info;
         var obj:Object = {};
         obj.titleName = _info.Name;
         obj.type = EquipType.PARTNAME[_info.CategoryID];
         obj.activate = _isOpen;
         obj.datail = LanguageMgr.GetTranslation("magichouse.collectionItem.itemTip.activateDetail");
         obj.placed = LanguageMgr.GetTranslation("avatarCollection.itemTip.placeTxt") + " " + LanguageMgr.GetTranslation("tank.view.movement.MovementLeftView.action");
         _itemContent.tipData = obj;
      }
      
      public function setTypeAndPos($type:int, $pos:int) : void
      {
         _type = $type;
         _pos = $pos;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      private function createItemCell() : ShopItemCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,46,46);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_cell)
         {
            _cell.dispose();
         }
         _cell = null;
         if(_openBtn)
         {
            _openBtn.dispose();
         }
         _openBtn = null;
      }
   }
}
