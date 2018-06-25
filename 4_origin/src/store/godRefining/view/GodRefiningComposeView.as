package store.godRefining.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import store.StoreCell;
   
   public class GodRefiningComposeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _cellBg:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _tipText:FilterFrameText;
      
      private var _needNumText:FilterFrameText;
      
      private var _startComposeBtn:BaseButton;
      
      private var _items:Vector.<BagCell>;
      
      public function GodRefiningComposeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.composeViewBg");
         addChild(_bg);
         _cellBg = ComponentFactory.Instance.creatBitmap("asset.godRefining.composeViewCellBg");
         addChild(_cellBg);
         _titleBmp = ComponentFactory.Instance.creatBitmap("asset.godRefining.composeTitleBmp");
         addChild(_titleBmp);
         _tipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.tipText");
         PositionUtils.setPos(_tipText,"ddtstore.godRefiningComposeView.tipTextPos");
         _tipText.text = LanguageMgr.GetTranslation("store.godRefining.tipTextMsg2");
         addChild(_tipText);
         _needNumText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.needNumText");
         PositionUtils.setPos(_needNumText,"ddtstore.godRefiningComposeView.needNumTextPos");
         _needNumText.text = "(20/5)";
         addChild(_needNumText);
         _startComposeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.startComposeBtn");
         addChild(_startComposeBtn);
         _items = new Vector.<BagCell>();
         _items[0] = new GodRefiningChipCell(["3"],0);
         PositionUtils.setPos(_items[0],"ddtstore.godRefining.composeClipCellPos");
         addChild(_items[0]);
         _items[1] = new GodRefiningPreItemCell();
         PositionUtils.setPos(_items[1],"ddtstore.godRefining.composeItemCellPos");
         addChild(_items[1]);
      }
      
      private function initEvent() : void
      {
         _startComposeBtn.addEventListener("click",__startComposeBtnHandler);
      }
      
      public function updateView() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _items[i].info = null;
            i++;
         }
      }
      
      private function getCurCellIndex(itemInfo:ItemTemplateInfo) : int
      {
         if(EquipType.isArmShellClip(itemInfo))
         {
            return 0;
         }
         return -1;
      }
      
      public function refreshData(items:Dictionary) : void
      {
         var itemPlace:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for(itemPlace in items)
         {
            if(itemPlace < _items.length)
            {
               _items[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[itemPlace];
            }
         }
      }
      
      public function quitStartDrag(evt:CEvent) : void
      {
         var cell:BagCell = evt.data as BagCell;
         var index:int = getCurCellIndex(cell.info);
         if(index != -1)
         {
            startShine(index);
         }
      }
      
      public function quitStopDrag(evt:CEvent) : void
      {
         stopShine();
      }
      
      public function startShine(cellId:int) : void
      {
         var storeCell:StoreCell = _items[cellId] as StoreCell;
         if(storeCell)
         {
            storeCell.startShine();
         }
      }
      
      public function stopShine() : void
      {
         var i:int = 0;
         var storeCell:* = null;
         for(i = 0; i < _items.length; )
         {
            storeCell = _items[i] as StoreCell;
            if(storeCell)
            {
               storeCell.stopShine();
            }
            i++;
         }
      }
      
      public function equipDoubleClickMove(event:CEvent) : void
      {
      }
      
      public function propDoubleClickMove(event:CEvent) : void
      {
         var info:InventoryItemInfo = event.data as InventoryItemInfo;
         var index:int = getCurCellIndex(info);
         if(index != -1)
         {
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,index,1);
         }
      }
      
      private function __startComposeBtnHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function removeEvent() : void
      {
         _startComposeBtn.removeEventListener("click",__startComposeBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _cellBg = null;
         _titleBmp = null;
         _tipText = null;
         _needNumText = null;
         _startComposeBtn = null;
         _items = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
