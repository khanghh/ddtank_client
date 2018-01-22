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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _dataVec = [];
         _cellVec = new Vector.<CardCell>(4);
         _container = ComponentFactory.Instance.creatComponentByStylename("cardBagListItem.container");
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new CardBagCell(ComponentFactory.Instance.creatBitmap("asset.cardBag.cardBG"));
            _loc1_.setContentSize(71,96);
            _loc1_.canShine = true;
            _loc1_.addEventListener("interactive_click",__clickHandler);
            _loc1_.addEventListener("interactive_double_click",__doubleClickHandler);
            _loc1_.addEventListener("mouseOver",__overHandler);
            DoubleClickManager.Instance.enableDoubleClick(_loc1_);
            _container.addChild(_loc1_);
            _cellVec[_loc2_] = _loc1_;
            _loc2_++;
         }
         addChild(_container);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         var _loc2_:CardBagCell = param1.currentTarget as CardBagCell;
         if(_loc2_.cardInfo)
         {
            this.parent.setChildIndex(this,this.parent.numChildren - 1);
         }
      }
      
      protected function __clickHandler(param1:InteractiveEvent) : void
      {
         var _loc3_:* = null;
         param1.stopImmediatePropagation();
         var _loc2_:CardBagCell = param1.currentTarget as CardBagCell;
         if(_loc2_)
         {
            _loc3_ = _loc2_.info as ItemTemplateInfo;
         }
         if(_loc3_ == null)
         {
            return;
         }
         if(!_loc2_.locked)
         {
            SoundManager.instance.play("008");
            _loc2_.dragStart();
         }
      }
      
      protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         var _loc3_:CardBagCell = param1.currentTarget as CardBagCell;
         if(_loc3_.cardInfo)
         {
            if(_loc3_ && !_loc3_.locked)
            {
               if(_loc3_.cardInfo.templateInfo.Property8 == "1")
               {
                  SocketManager.Instance.out.sendMoveCards(_loc3_.cardInfo.Place,0);
                  return;
               }
               _loc2_ = true;
               _loc4_ = 1;
               while(_loc4_ < 5)
               {
                  if(PlayerManager.Instance.Self.cardEquipDic[_loc4_] == null || PlayerManager.Instance.Self.cardEquipDic[_loc4_].Count < 0)
                  {
                     SocketManager.Instance.out.sendMoveCards(_loc3_.cardInfo.Place,_loc4_);
                     _loc2_ = false;
                     break;
                  }
                  _loc4_++;
               }
               if(_loc2_)
               {
                  SocketManager.Instance.out.sendMoveCards(_loc3_.cardInfo.Place,1);
               }
            }
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _dataVec;
      }
      
      public function setCellValue(param1:*) : void
      {
         _dataVec = param1;
         upView();
      }
      
      override public function get height() : Number
      {
         return _container.height;
      }
      
      private function upView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _cellVec[_loc1_].place = _dataVec[0] * 4 + _loc1_ + 1;
            if(_dataVec[_loc1_ + 1])
            {
               _cellVec[_loc1_].cardInfo = _dataVec[_loc1_ + 1] as CardInfo;
            }
            else
            {
               _cellVec[_loc1_].cardInfo = null;
            }
            _loc1_++;
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
         var _loc1_:int = 0;
         _dataVec = null;
         _loc1_ = 0;
         while(_loc1_ < _cellVec.length)
         {
            _cellVec[_loc1_].removeEventListener("interactive_click",__clickHandler);
            _cellVec[_loc1_].removeEventListener("interactive_double_click",__doubleClickHandler);
            _cellVec[_loc1_].removeEventListener("mouseOver",__overHandler);
            DoubleClickManager.Instance.disableDoubleClick(_cellVec[_loc1_]);
            _cellVec[_loc1_].dispose();
            _cellVec[_loc1_] = null;
            _loc1_++;
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
