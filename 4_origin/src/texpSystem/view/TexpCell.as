package texpSystem.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.DragEffect;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.DragManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   
   public class TexpCell extends BagCell
   {
       
      
      private var _texpInfo:TexpInfo;
      
      private var _shiner:ShineObject;
      
      private var _texpCountSelectFrame:TexpCountSelectFrame;
      
      public function TexpCell()
      {
         var s:Sprite = new Sprite();
         var bg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.texpSystem.itemBg1");
         s.addChild(bg);
         super(0,null,true,s);
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.texpSystem.cellShine"));
         addChild(_shiner);
         var _loc4_:Boolean = false;
         _shiner.mouseEnabled = _loc4_;
         _shiner.mouseChildren = _loc4_;
         var rect:Rectangle = ComponentFactory.Instance.creatCustomObject("texpSystem.texpCell.content");
         setContentSize(rect.width,rect.height);
         PicPos = new Point(rect.x,rect.y);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         addEventListener("interactive_click",__clickHandler);
         addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         removeEventListener("interactive_click",__clickHandler);
         removeEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
      }
      
      private function getNeedCount(sigExp:int) : int
      {
         var count:int = (_texpInfo.upExp - _texpInfo.currExp) / sigExp;
         if((_texpInfo.upExp - _texpInfo.currExp) % sigExp > 0)
         {
            count = int(count) + 1;
         }
         return count;
      }
      
      override public function dragDrop(effect:DragEffect) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var info:InventoryItemInfo = effect.data as InventoryItemInfo;
         if(info && effect.action != "split")
         {
            effect.action = "none";
            if(TexpManager.Instance.texpType != info.CategoryID)
            {
               if(TexpManager.Instance.texpType == 53)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.magicTexpTips"));
                  return;
               }
               if(TexpManager.Instance.texpType == 20)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.texpTips"));
                  return;
               }
               if(TexpManager.Instance.texpType == 78)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.nsTexpTips"));
                  return;
               }
            }
            if(this.info)
            {
               SocketManager.Instance.out.sendClearStoreBag();
            }
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,0,info.Count,true);
            DragManager.acceptDrag(this);
         }
      }
      
      private function __ontexpCountResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var texpInfo:InventoryItemInfo = _texpCountSelectFrame.texpInfo;
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               _texpCountSelectFrame.dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(info)
               {
                  SocketManager.Instance.out.sendClearStoreBag();
               }
               SocketManager.Instance.out.sendMoveGoods(texpInfo.BagType,texpInfo.Place,12,0,_texpCountSelectFrame.count,true);
               _texpCountSelectFrame.dispose();
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = ComponentFactory.Instance.creat("texpSystem.txtCount");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
      }
      
      override protected function onMouseOver(evt:MouseEvent) : void
      {
      }
      
      override protected function onMouseOut(evt:MouseEvent) : void
      {
      }
      
      public function startShine() : void
      {
         _shiner.shine();
      }
      
      public function stopShine() : void
      {
         _shiner.stopShine();
      }
      
      private function __clickHandler(evt:InteractiveEvent) : void
      {
         if(_info && !locked && stage && allowDrag)
         {
            SoundManager.instance.playButtonSound();
         }
         dragStart();
      }
      
      protected function __doubleClickHandler(event:InteractiveEvent) : void
      {
         var itemInfo:* = null;
         if(_info && !locked)
         {
            SoundManager.instance.playButtonSound();
            itemInfo = _info as InventoryItemInfo;
            SocketManager.Instance.out.sendMoveGoods(itemInfo.BagType,itemInfo.Place,1,0,itemInfo.Count,true);
            SocketManager.Instance.out.sendClearStoreBag();
            info = null;
         }
      }
      
      override public function dispose() : void
      {
         if(_shiner)
         {
            ObjectUtils.disposeObject(_shiner);
            _shiner = null;
         }
         if(_texpCountSelectFrame)
         {
            ObjectUtils.disposeObject(_texpCountSelectFrame);
            _texpCountSelectFrame = null;
         }
         super.dispose();
      }
      
      public function get texpInfo() : TexpInfo
      {
         return _texpInfo;
      }
      
      public function set texpInfo(value:TexpInfo) : void
      {
         _texpInfo = value;
      }
   }
}
