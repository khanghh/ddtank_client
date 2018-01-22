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
         var _loc1_:int = 0;
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
         _loc1_ = 2;
         while(_loc1_ < 5)
         {
            _items[_loc1_] = new GodRefiningStoneCell(["3"],_loc1_);
            PositionUtils.setPos(_items[_loc1_],"ddtstore.godRefining.stoneCellPos" + (_loc1_ - 2));
            addChild(_items[_loc1_]);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         _startFineQuenchBtn.addEventListener("click",__startFineQuenchBtnHandler);
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].info = null;
            _loc1_++;
         }
      }
      
      public function refreshData(param1:Dictionary) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(_loc2_ in param1)
         {
            if(_loc2_ < _items.length)
            {
               _items[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            }
         }
      }
      
      public function quitStartDrag(param1:CEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BagCell = param1.data as BagCell;
         var _loc4_:Array = getAllCurCellIndex(_loc2_.info);
         if(_loc4_.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               startShine(_loc4_[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      private function getCurCellIndex(param1:ItemTemplateInfo) : int
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         if(EquipType.isArmShell(param1))
         {
            return 0;
         }
         if(EquipType.isArmShellClip(param1))
         {
            return 1;
         }
         if(EquipType.isArmShellStone(param1))
         {
            _loc2_ = 2;
            _loc3_ = 2;
            while(_loc3_ < _items.length)
            {
               if(_items[_loc3_].info == null)
               {
                  _loc2_ = _loc3_;
                  break;
               }
               _loc3_++;
            }
            return _loc2_;
         }
         return -1;
      }
      
      private function getAllCurCellIndex(param1:ItemTemplateInfo) : Array
      {
         if(EquipType.isArmShell(param1))
         {
            return [0];
         }
         if(EquipType.isArmShellClip(param1))
         {
            return [1];
         }
         if(EquipType.isArmShellStone(param1))
         {
            return [2,3,4];
         }
         return [];
      }
      
      public function quitStopDrag(param1:CEvent) : void
      {
         stopShine();
      }
      
      public function startShine(param1:int) : void
      {
         _items[param1].startShine();
      }
      
      public function stopShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].stopShine();
            _loc1_++;
         }
      }
      
      private function __startFineQuenchBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      public function equipDoubleClickMove(param1:CEvent) : void
      {
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,0,1);
      }
      
      public function propDoubleClickMove(param1:CEvent) : void
      {
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         SocketManager.Instance.out.sendMoveGoods(_loc2_.BagType,_loc2_.Place,12,getCurCellIndex(_loc2_),1);
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
