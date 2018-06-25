package farm.view.compose.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ComposeMoveScroll extends Sprite implements Disposeable
   {
       
      
      private const SHOW_HOUSEITEM_COUNT:int = 5;
      
      private var _currentShowIndex:int = 0;
      
      private var _petsImgVec:Vector.<FarmHouseItem>;
      
      private var _leftBtn:SimpleBitmapButton;
      
      private var _rightBtn:SimpleBitmapButton;
      
      private var _bag:BagInfo;
      
      private var _hBox:HBox;
      
      private var _start:int;
      
      public function ComposeMoveScroll()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.button.left");
         _leftBtn.transparentEnable = true;
         addChild(_leftBtn);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.button.right");
         addChild(_rightBtn);
         _petsImgVec = new Vector.<FarmHouseItem>(5);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("farm.componsePnl.hbox");
         addChild(_hBox);
         for(i = 0; i < 5; )
         {
            item = new FarmHouseItem();
            _petsImgVec[i] = item;
            _hBox.addChild(item);
            i++;
         }
         _bag = PlayerManager.Instance.Self.getBag(14);
         _start = 0;
         update();
      }
      
      private function initEvent() : void
      {
         _leftBtn.addEventListener("click",__ClickHandler);
         _rightBtn.addEventListener("click",__ClickHandler);
         _bag.addEventListener("update",__bagUpdate);
      }
      
      private function removeEvent() : void
      {
         _leftBtn.removeEventListener("click",__ClickHandler);
         _rightBtn.removeEventListener("click",__ClickHandler);
         _bag.removeEventListener("update",__bagUpdate);
      }
      
      private function __bagUpdate(event:BagEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         var end:int = 0;
         var i:int = 0;
         clearItem();
         if(_bag.items.length > 0)
         {
            end = _bag.items.length > _start + 5?_start + 5:_bag.items.length;
            for(i = _start; i < end; )
            {
               _petsImgVec[i - _start].info = _bag.items.list[i];
               i++;
            }
         }
      }
      
      private function clearItem() : void
      {
         var i:int = 0;
         for(i = 0; i < 5; )
         {
            _petsImgVec[i].info = null;
            i++;
         }
      }
      
      private function __ClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = event.currentTarget;
         if(_leftBtn !== _loc2_)
         {
            if(_rightBtn === _loc2_)
            {
               if(_start + 1 <= _bag.items.length - 5)
               {
                  _start = _start + 1;
               }
            }
         }
         else if(_start - 1 >= 0)
         {
            _start = _start - 1;
         }
         update();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _bag = null;
         _start = 0;
         var _loc3_:int = 0;
         var _loc2_:* = _petsImgVec;
         for each(var item in _petsImgVec)
         {
            if(item)
            {
               item.dispose();
               item = null;
            }
         }
         _petsImgVec.splice(0,_petsImgVec.length);
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
            _hBox = null;
         }
         if(_leftBtn)
         {
            ObjectUtils.disposeObject(_leftBtn);
            _leftBtn = null;
         }
         if(_rightBtn)
         {
            ObjectUtils.disposeObject(_rightBtn);
            _rightBtn = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
