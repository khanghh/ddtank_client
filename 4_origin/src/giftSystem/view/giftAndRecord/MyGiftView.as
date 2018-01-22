package giftSystem.view.giftAndRecord
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import giftSystem.MyGiftCellInfo;
   import giftSystem.element.MyGiftItem;
   
   public class MyGiftView extends Sprite implements Disposeable
   {
       
      
      private var _myGiftItemContainerAll:VBox;
      
      private var _myGiftItemContainers:Vector.<HBox>;
      
      private var _panel:ScrollPanel;
      
      private var _count:int = 0;
      
      private var _line:int = 0;
      
      private var _itemArr:Vector.<MyGiftItem>;
      
      public function MyGiftView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _myGiftItemContainers = new Vector.<HBox>();
         _itemArr = new Vector.<MyGiftItem>();
         _panel = ComponentFactory.Instance.creatComponentByStylename("MyGiftView.myGiftItemPanel");
         _myGiftItemContainerAll = ComponentFactory.Instance.creatComponentByStylename("MyGiftView.myGiftItemContainerAll");
         _panel.setView(_myGiftItemContainerAll);
         addChild(_panel);
      }
      
      public function setList(param1:Vector.<MyGiftCellInfo>) : void
      {
         var _loc3_:int = 0;
         clearList();
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            addItem(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public function addItem(param1:MyGiftCellInfo) : void
      {
         if(_count % 3 == 0)
         {
            _line = _count / 3;
            _myGiftItemContainers[_line] = ComponentFactory.Instance.creatComponentByStylename("MyGiftView.myGiftItemContainer");
            _myGiftItemContainerAll.addChild(_myGiftItemContainers[_line]);
         }
         var _loc2_:MyGiftItem = new MyGiftItem();
         _loc2_.info = param1;
         _myGiftItemContainers[_line].addChild(_loc2_);
         _itemArr.push(_loc2_);
         _count = Number(_count) + 1;
         _myGiftItemContainerAll.height = _loc2_.height * (_line + 1);
         _panel.invalidateViewport();
      }
      
      public function upItem(param1:MyGiftCellInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _itemArr.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_itemArr[_loc3_].info.TemplateID == param1.TemplateID)
            {
               _itemArr[_loc3_].info = param1;
               break;
            }
            _loc3_++;
         }
      }
      
      private function clearList() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeAllChildren(_myGiftItemContainerAll);
         _loc1_ = 0;
         while(_loc1_ < _line + 1)
         {
            _myGiftItemContainers[_loc1_] = null;
            _loc1_++;
         }
         _myGiftItemContainers = new Vector.<HBox>();
         _itemArr = null;
         _itemArr = new Vector.<MyGiftItem>();
         _count = 0;
         _line = 0;
         _panel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _loc1_ = 0;
         while(_loc1_ < _line + 1)
         {
            _myGiftItemContainers[_loc1_] = null;
            _loc1_++;
         }
         _myGiftItemContainerAll = null;
         _panel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
