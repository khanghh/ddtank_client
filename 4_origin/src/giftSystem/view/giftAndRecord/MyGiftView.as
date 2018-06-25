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
      
      public function setList(list:Vector.<MyGiftCellInfo>) : void
      {
         var i:int = 0;
         clearList();
         var len:int = list.length;
         for(i = 0; i < len; )
         {
            addItem(list[i]);
            i++;
         }
      }
      
      public function addItem(info:MyGiftCellInfo) : void
      {
         if(_count % 3 == 0)
         {
            _line = _count / 3;
            _myGiftItemContainers[_line] = ComponentFactory.Instance.creatComponentByStylename("MyGiftView.myGiftItemContainer");
            _myGiftItemContainerAll.addChild(_myGiftItemContainers[_line]);
         }
         var myGiftItem:MyGiftItem = new MyGiftItem();
         myGiftItem.info = info;
         _myGiftItemContainers[_line].addChild(myGiftItem);
         _itemArr.push(myGiftItem);
         _count = Number(_count) + 1;
         _myGiftItemContainerAll.height = myGiftItem.height * (_line + 1);
         _panel.invalidateViewport();
      }
      
      public function upItem(info:MyGiftCellInfo) : void
      {
         var i:int = 0;
         var len:int = _itemArr.length;
         for(i = 0; i < len; )
         {
            if(_itemArr[i].info.TemplateID == info.TemplateID)
            {
               _itemArr[i].info = info;
               break;
            }
            i++;
         }
      }
      
      private function clearList() : void
      {
         var i:int = 0;
         ObjectUtils.disposeAllChildren(_myGiftItemContainerAll);
         for(i = 0; i < _line + 1; )
         {
            _myGiftItemContainers[i] = null;
            i++;
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
         var i:int = 0;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         for(i = 0; i < _line + 1; )
         {
            _myGiftItemContainers[i] = null;
            i++;
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
