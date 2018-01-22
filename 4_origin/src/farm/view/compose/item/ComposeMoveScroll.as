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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.button.left");
         _leftBtn.transparentEnable = true;
         addChild(_leftBtn);
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.button.right");
         addChild(_rightBtn);
         _petsImgVec = new Vector.<FarmHouseItem>(5);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("farm.componsePnl.hbox");
         addChild(_hBox);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new FarmHouseItem();
            _petsImgVec[_loc2_] = _loc1_;
            _hBox.addChild(_loc1_);
            _loc2_++;
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
      
      private function __bagUpdate(param1:BagEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         clearItem();
         if(_bag.items.length > 0)
         {
            _loc1_ = _bag.items.length > _start + 5?_start + 5:_bag.items.length;
            _loc2_ = _start;
            while(_loc2_ < _loc1_)
            {
               _petsImgVec[_loc2_ - _start].info = _bag.items.list[_loc2_];
               _loc2_++;
            }
         }
      }
      
      private function clearItem() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _petsImgVec[_loc1_].info = null;
            _loc1_++;
         }
      }
      
      private function __ClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
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
         for each(var _loc1_ in _petsImgVec)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
               _loc1_ = null;
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
