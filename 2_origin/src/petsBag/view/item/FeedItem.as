package petsBag.view.item
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.BagInfo;
   import ddt.data.analyze.PetconfigAnalyzer;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import farm.viewx.FarmFieldBlock;
   import flash.events.MouseEvent;
   import petsBag.cmd.CmdShowPetFoodNumberSelectFrame;
   import petsBag.view.PetFoodNumberSelectFrame;
   
   public class FeedItem extends BaseCell
   {
       
      
      protected var _tbxCount:FilterFrameText;
      
      private var _shiner:ShineObject;
      
      public function FeedItem()
      {
         _bg = ComponentFactory.Instance.creatBitmap("assets.petsBag.petFeedPnlBg");
         initView();
         super(_bg,null,false);
      }
      
      private function initView() : void
      {
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("BagCellCountText");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.petBagSystem.cellShine"));
         addChild(_shiner);
         var _loc1_:Boolean = false;
         _shiner.mouseEnabled = _loc1_;
         _shiner.mouseChildren = _loc1_;
      }
      
      public function startShine() : void
      {
         _shiner.shine();
      }
      
      public function stopShine() : void
      {
         _shiner.stopShine();
      }
      
      public function updateCount() : void
      {
         if(_tbxCount)
         {
            if(_info && itemInfo && itemInfo.MaxCount > 1)
            {
               _tbxCount.text = String(itemInfo.Count);
               _tbxCount.visible = true;
               addChild(_tbxCount);
            }
            else
            {
               _tbxCount.visible = false;
            }
         }
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
      }
      
      private function __updateStoreBag(param1:BagEvent) : void
      {
         var _loc2_:BagInfo = PlayerManager.Instance.Self.StoreBag;
         if(_loc2_.items[0] == null || _loc2_.items[0].CategoryID != 34)
         {
            this.info = null;
            return;
         }
         this.info = _loc2_.items[0];
      }
      
      override protected function onMouseClick(param1:MouseEvent) : void
      {
         if(_info && allowDrag)
         {
            SoundManager.instance.play("008");
            dragStart();
         }
      }
      
      override protected function removeEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
         super.removeEvent();
      }
      
      public function get itemInfo() : InventoryItemInfo
      {
         return _info as InventoryItemInfo;
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         updateCount();
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         if(!this.mouseEnabled)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc2_ && _loc2_.CategoryID == 34)
         {
            new CmdShowPetFoodNumberSelectFrame().excute(_loc2_);
            param1.action = "none";
            DragManager.acceptDrag(this);
         }
         else
         {
            param1.action = "none";
            DragManager.acceptDrag(this);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.current"));
         }
      }
      
      private function needMaxFood(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = PetconfigAnalyzer.PetCofnig.MaxHunger - param1;
         _loc3_ = Math.ceil(_loc4_ / param2);
         return _loc3_;
      }
      
      protected function __onFoodAmountResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:PetFoodNumberSelectFrame = PetFoodNumberSelectFrame(param1.currentTarget);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc2_.dispose();
               break;
            case 2:
            case 3:
            case 4:
               _loc3_ = _loc2_.foodInfo;
               if(info)
               {
                  SocketManager.Instance.out.sendClearStoreBag();
               }
               SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,0,_loc2_.amount,true);
               _loc2_.dispose();
         }
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new CellEvent("dragStop",null,true));
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(param1.action == "move" && param1.target == null)
         {
            if(_loc2_ && _loc2_.BagType == 11)
            {
               param1.action = "none";
               super.dragStop(param1);
            }
            else if(_loc2_ && _loc2_.BagType == 12)
            {
               locked = false;
            }
            else
            {
               locked = false;
            }
         }
         else if(param1.action == "split" && param1.target == null)
         {
            locked = false;
         }
         else if(param1.target is FarmFieldBlock)
         {
            locked = false;
         }
         else
         {
            super.dragStop(param1);
         }
      }
      
      override public function dispose() : void
      {
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
            _tbxCount = null;
         }
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
