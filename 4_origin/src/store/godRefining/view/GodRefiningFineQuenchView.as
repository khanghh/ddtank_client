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
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import store.StoreCell;
   
   public class GodRefiningFineQuenchView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _cellBg:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _cBuyluckyBtn:BuyItemButton;
      
      private var _successTipText:FilterFrameText;
      
      private var _successNumText:FilterFrameText;
      
      private var _tipText:FilterFrameText;
      
      private var _needNumText:FilterFrameText;
      
      private var _startFineQuenchBtn:BaseButton;
      
      private var _items:Vector.<StoreCell>;
      
      public function GodRefiningFineQuenchView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.fineQuenchViewBg");
         addChild(_bg);
         _cellBg = ComponentFactory.Instance.creatBitmap("asset.godRefining.fineQuenchCellBg");
         addChild(_cellBg);
         _titleBmp = ComponentFactory.Instance.creatBitmap("asset.godRefining.fineQuenchTitleBmp");
         addChild(_titleBmp);
         _cBuyluckyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.BuyLuckyComposeBtn");
         _cBuyluckyBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _cBuyluckyBtn.setup(11018,2,true);
         addChild(_cBuyluckyBtn);
         _successTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.successTipText");
         _successTipText.text = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.PreviewRateLabelText");
         addChild(_successTipText);
         _successNumText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.successNumText");
         _successNumText.text = "0%";
         addChild(_successNumText);
         _tipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.tipText");
         _tipText.text = LanguageMgr.GetTranslation("store.godRefining.tipTextMsg");
         addChild(_tipText);
         _needNumText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.needNumText");
         _needNumText.text = "(20/5)";
         addChild(_needNumText);
         _startFineQuenchBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.godRefining.startFineQuenchBtn");
         addChild(_startFineQuenchBtn);
         _items = new Vector.<StoreCell>();
         _items[0] = new GodRefiningItemCell(0);
         PositionUtils.setPos(_items[0],"ddtstore.godRefining.itemCellPos");
         addChild(_items[0]);
         _items[1] = new GodRefiningChipCell(["3"],1);
         PositionUtils.setPos(_items[1],"ddtstore.godRefining.clipCellPos");
         addChild(_items[1]);
         for(i = 2; i < 5; )
         {
            _items[i] = new GodRefiningStoneCell(["3"],i);
            PositionUtils.setPos(_items[i],"ddtstore.godRefining.stoneCellPos" + (i - 2));
            addChild(_items[i]);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _startFineQuenchBtn.addEventListener("click",__startFineQuenchBtnHandler);
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
         var i:int = 0;
         var cell:BagCell = evt.data as BagCell;
         var indexs:Array = getAllCurCellIndex(cell.info);
         if(indexs.length > 0)
         {
            for(i = 0; i < indexs.length; )
            {
               startShine(indexs[i]);
               i++;
            }
         }
      }
      
      private function getCurCellIndex(itemInfo:ItemTemplateInfo) : int
      {
         var index:* = 0;
         var i:int = 0;
         if(EquipType.isArmShell(itemInfo))
         {
            return 0;
         }
         if(EquipType.isArmShellClip(itemInfo))
         {
            return 1;
         }
         if(EquipType.isArmShellStone(itemInfo))
         {
            index = 2;
            for(i = 2; i < _items.length; )
            {
               if(_items[i].info == null)
               {
                  index = i;
                  break;
               }
               i++;
            }
            return index;
         }
         return -1;
      }
      
      private function getAllCurCellIndex(itemInfo:ItemTemplateInfo) : Array
      {
         if(EquipType.isArmShell(itemInfo))
         {
            return [0];
         }
         if(EquipType.isArmShellClip(itemInfo))
         {
            return [1];
         }
         if(EquipType.isArmShellStone(itemInfo))
         {
            return [2,3,4];
         }
         return [];
      }
      
      public function quitStopDrag(evt:CEvent) : void
      {
         stopShine();
      }
      
      public function startShine(cellId:int) : void
      {
         _items[cellId].startShine();
      }
      
      public function stopShine() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _items[i].stopShine();
            i++;
         }
      }
      
      private function __startFineQuenchBtnHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      public function equipDoubleClickMove(event:CEvent) : void
      {
         var info:InventoryItemInfo = event.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,0,1);
      }
      
      public function propDoubleClickMove(event:CEvent) : void
      {
         var info:InventoryItemInfo = event.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,getCurCellIndex(info),1);
      }
      
      private function removeEvent() : void
      {
         _startFineQuenchBtn.removeEventListener("click",__startFineQuenchBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _cellBg = null;
         _titleBmp = null;
         _cBuyluckyBtn = null;
         _successTipText = null;
         _successNumText = null;
         _tipText = null;
         _needNumText = null;
         _startFineQuenchBtn = null;
         _items = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
