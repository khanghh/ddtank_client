package cardSystem.view.cardBag
{
   import cardSystem.data.CardInfo;
   import cardSystem.elements.CardBagCell;
   import cardSystem.elements.CardCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardBagListItem extends Sprite implements Disposeable, IListCell
   {
      
      public static const CELL_NUM:int = 4;
       
      
      private var _dataVec:Array;
      
      private var _cellVec:Vector.<CardCell>;
      
      private var _container:HBox;
      
      public function CardBagListItem()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get cellVec() : Vector.<CardCell>
      {
         return _cellVec;
      }
      
      private function initEvent() : void
      {
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
         _dataVec = [];
         _cellVec = new Vector.<CardCell>(4);
         _container = ComponentFactory.Instance.creatComponentByStylename("cardBagListItem.container");
         for(i = 0; i < 4; )
         {
            cell = new CardBagCell(ComponentFactory.Instance.creatBitmap("asset.cardBag.cardBG"));
            cell.setContentSize(71,96);
            cell.canShine = true;
            cell.addEventListener("interactive_click",__clickHandler);
            cell.addEventListener("interactive_double_click",__doubleClickHandler);
            cell.addEventListener("mouseOver",__overHandler);
            DoubleClickManager.Instance.enableDoubleClick(cell);
            _container.addChild(cell);
            _cellVec[i] = cell;
            i++;
         }
         addChild(_container);
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         var cell:CardBagCell = event.currentTarget as CardBagCell;
         if(cell.cardInfo)
         {
            this.parent.setChildIndex(this,this.parent.numChildren - 1);
         }
      }
      
      protected function __clickHandler(event:InteractiveEvent) : void
      {
         var info:* = null;
         event.stopImmediatePropagation();
         var cell:CardBagCell = event.currentTarget as CardBagCell;
         if(cell)
         {
            info = cell.info as ItemTemplateInfo;
         }
         if(info == null)
         {
            return;
         }
         if(!cell.locked)
         {
            SoundManager.instance.play("008");
            cell.dragStart();
         }
      }
      
      protected function __doubleClickHandler(event:InteractiveEvent) : void
      {
         var ref:Boolean = false;
         var i:int = 0;
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
         var cell:CardBagCell = event.currentTarget as CardBagCell;
         if(cell.cardInfo)
         {
            if(cell && !cell.locked)
            {
               if(cell.cardInfo.templateInfo.Property8 == "1")
               {
                  SocketManager.Instance.out.sendMoveCards(cell.cardInfo.Place,0);
                  return;
               }
               ref = true;
               for(i = 1; i < 5; )
               {
                  if(PlayerManager.Instance.Self.cardEquipDic[i] == null || PlayerManager.Instance.Self.cardEquipDic[i].Count < 0)
                  {
                     SocketManager.Instance.out.sendMoveCards(cell.cardInfo.Place,i);
                     ref = false;
                     break;
                  }
                  i++;
               }
               if(ref)
               {
                  SocketManager.Instance.out.sendMoveCards(cell.cardInfo.Place,1);
               }
            }
         }
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _dataVec;
      }
      
      public function setCellValue(value:*) : void
      {
         _dataVec = value;
         upView();
      }
      
      override public function get height() : Number
      {
         return _container.height;
      }
      
      private function upView() : void
      {
         var i:int = 0;
         for(i = 0; i < 4; )
         {
            _cellVec[i].place = _dataVec[0] * 4 + i + 1;
            if(_dataVec[i + 1])
            {
               _cellVec[i].cardInfo = _dataVec[i + 1] as CardInfo;
            }
            else
            {
               _cellVec[i].cardInfo = null;
            }
            i++;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         _dataVec = null;
         for(i = 0; i < _cellVec.length; )
         {
            _cellVec[i].removeEventListener("interactive_click",__clickHandler);
            _cellVec[i].removeEventListener("interactive_double_click",__doubleClickHandler);
            _cellVec[i].removeEventListener("mouseOver",__overHandler);
            DoubleClickManager.Instance.disableDoubleClick(_cellVec[i]);
            _cellVec[i].dispose();
            _cellVec[i] = null;
            i++;
         }
         _cellVec = null;
         DoubleClickManager.Instance.clearTarget();
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
