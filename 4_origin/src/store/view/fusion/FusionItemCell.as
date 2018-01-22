package store.view.fusion
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import store.StoreCell;
   import store.StrengthDataManager;
   import store.view.StoneCellFrame;
   
   public class FusionItemCell extends StoreCell
   {
      
      public static const SHINE_XY:int = 8;
      
      public static const SHINE_SIZE:int = 76;
       
      
      private var bg:Sprite;
      
      private var canMouseEvt:Boolean;
      
      private var _cellBg:StoneCellFrame;
      
      private var _autoSplit:Boolean;
      
      public function FusionItemCell(param1:int)
      {
         bg = new Sprite();
         canMouseEvt = true;
         _cellBg = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIFusionBG.Material");
         _cellBg.label = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.MaterialCellText");
         bg.addChild(_cellBg);
         super(bg,param1);
         PicPos = new Point(10,10);
      }
      
      public function set bgVisible(param1:Boolean) : void
      {
         bg.alpha = int(param1);
      }
      
      override public function startShine() : void
      {
         _shiner.x = 8;
         _shiner.y = 8;
         var _loc1_:int = 76;
         _shiner.height = _loc1_;
         _shiner.width = _loc1_;
         super.startShine();
      }
      
      public function set mouseEvt(param1:Boolean) : void
      {
         canMouseEvt = param1;
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(!canMouseEvt)
         {
            return;
         }
         if(!DoubleClickEnabled)
         {
            return;
         }
         if(info == null)
         {
            return;
         }
         if((param1.currentTarget as BagCell).info != null)
         {
            if((param1.currentTarget as BagCell).info != null)
            {
               if(StrengthDataManager.instance.autoFusion)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
               }
               else
               {
                  SocketManager.Instance.out.sendMoveGoods(12,index,itemBagType,-1);
               }
               if(!mouseSilenced)
               {
                  SoundManager.instance.play("008");
               }
            }
         }
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
         if(!canMouseEvt)
         {
            return;
         }
         if(_info && !locked && stage && allowDrag)
         {
            SoundManager.instance.play("008");
         }
         dragStart();
      }
      
      override public function dragStart() : void
      {
         super.dragStart();
         StoreIIFusionBG.lastIndexFusion = index;
      }
      
      override public function dragStop(param1:DragEffect) : void
      {
         super.dragStop(param1);
         StoreIIFusionBG.lastIndexFusion = -1;
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            param1.width = _contentWidth - 18;
            param1.height = _contentHeight - 18;
            if(_picPos != null)
            {
               param1.x = _picPos.x;
            }
            else
            {
               param1.x = Math.abs(param1.width - _contentWidth) / 2;
            }
            if(_picPos != null)
            {
               param1.y = _picPos.y;
            }
            else
            {
               param1.y = Math.abs(param1.height - _contentHeight) / 2;
            }
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("ddtstore.StoreIIFusionBG.FunsionstoneCountTextII");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override public function dragDrop(param1:DragEffect) : void
      {
         var _loc2_:* = null;
         if(!canMouseEvt)
         {
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:InventoryItemInfo = param1.data as InventoryItemInfo;
         if(_loc3_.BagType == 12 && this.info != null)
         {
            return;
         }
         if(_loc3_ && param1.action != "split")
         {
            param1.action = "none";
            if(_loc3_.getRemainDate() <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.overdue"));
               return;
            }
            if(_loc3_.Property1 == "8")
            {
               return;
            }
            if(_loc3_.FusionType == 0 || _loc3_.FusionRate == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.fusion"));
               return;
            }
            if(StrengthDataManager.instance.autoFusion)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
               param1.action = "none";
               DragManager.acceptDrag(this);
               return;
            }
            if(_loc3_.Count > 1)
            {
               _autoSplit = (this.parent as StoreIIFusionBG).isAutoSplit;
               if(_autoSplit && StoreIIFusionBG.lastIndexFusion == -1)
               {
                  StoreIIFusionBG.autoSplitSend(_loc3_.BagType,_loc3_.Place,12,StoreIIFusionBG.getRemainIndexByEmpty(_loc3_.Count,this.parent as StoreIIFusionBG),_loc3_.Count,true,this.parent as StoreIIFusionBG);
               }
               else
               {
                  _loc2_ = ComponentFactory.Instance.creat("ddtstore.FusionSelectNumAlertFrame");
                  _loc2_.goodsinfo = _loc3_;
                  _loc2_.index = index;
                  _loc2_.show(_loc3_.Count);
                  _loc2_.addEventListener("sell",_alerSell);
                  _loc2_.addEventListener("notsell",_alerNotSell);
               }
            }
            else
            {
               SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,index,_loc3_.Count,true);
            }
            param1.action = "none";
            DragManager.acceptDrag(this);
         }
      }
      
      private function _alerSell(param1:FusionSelectEvent) : void
      {
         var _loc2_:FusionSelectNumAlertFrame = param1.currentTarget as FusionSelectNumAlertFrame;
         SocketManager.Instance.out.sendMoveGoods(param1.info.BagType,param1.info.Place,12,param1.index,param1.sellCount,true);
         _loc2_.removeEventListener("sell",_alerSell);
         _loc2_.removeEventListener("notsell",_alerNotSell);
         _loc2_.dispose();
         if(_loc2_ && _loc2_.parent)
         {
            removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      private function _alerNotSell(param1:FusionSelectEvent) : void
      {
         var _loc2_:FusionSelectNumAlertFrame = param1.currentTarget as FusionSelectNumAlertFrame;
         _loc2_.removeEventListener("sell",_alerSell);
         _loc2_.removeEventListener("notsell",_alerNotSell);
         _loc2_.dispose();
         if(_loc2_ && _loc2_.parent)
         {
            removeChild(_loc2_);
         }
         _loc2_ = null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_cellBg)
         {
            ObjectUtils.disposeObject(_cellBg);
         }
         _cellBg = null;
      }
   }
}
