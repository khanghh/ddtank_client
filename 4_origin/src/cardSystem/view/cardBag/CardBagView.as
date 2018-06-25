package cardSystem.view.cardBag
{
   import cardSystem.CardControl;
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.OutMainListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.DragManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   
   public class CardBagView extends Sprite implements Disposeable
   {
       
      
      private var _sortBtn:BaseButton;
      
      private var _collectBtn:BaseButton;
      
      private var _BG:Bitmap;
      
      private var _title:Bitmap;
      
      private var _bagList:OutMainListPanel;
      
      public function CardBagView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _BG = ComponentFactory.Instance.creatBitmap("asset.cardBag.BG");
         _title = ComponentFactory.Instance.creatBitmap("asset.cardBag.word");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagView.sortbtn");
         _collectBtn = ComponentFactory.Instance.creatComponentByStylename("CardBagView.collectBtn");
         _bagList = ComponentFactory.Instance.creatComponentByStylename("cardSyste.cardBagList");
         addChild(_BG);
         addChild(_title);
         addChild(_sortBtn);
         addChild(_collectBtn);
         addChild(_bagList);
         _bagList.vectorListModel.appendAll(CardManager.Instance.model.getBagListData());
         DragManager.ListenWheelEvent(_bagList.onMouseWheel);
         DragManager.changeCardState(CardManager.Instance.setSignLockedCardNone);
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.cardBagDic.addEventListener("add",__upData);
         PlayerManager.Instance.Self.cardBagDic.addEventListener("update",__upData);
         PlayerManager.Instance.Self.cardBagDic.addEventListener("remove",__remove);
         _collectBtn.addEventListener("click",__collectHandler);
         _sortBtn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("add",__upData);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("update",__upData);
         PlayerManager.Instance.Self.cardBagDic.removeEventListener("remove",__remove);
         _collectBtn.removeEventListener("click",__collectHandler);
         _sortBtn.removeEventListener("click",__clickHandler);
      }
      
      private function __collectHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CardControl.Instance.showCollectView();
      }
      
      private function __upData(event:DictionaryEvent) : void
      {
         var itemDate:* = null;
         var newArr:* = null;
         var info:CardInfo = event.data as CardInfo;
         var m:int = info.Place % 4 == 0?info.Place / 4 - 2:Number(info.Place / 4 - 1);
         var n:int = info.Place % 4 == 0?4:Number(info.Place % 4);
         if(_bagList.vectorListModel.elements[m] == null)
         {
            itemDate = [];
            itemDate[0] = m + 1;
            itemDate[n] = info;
            _bagList.vectorListModel.append(itemDate);
         }
         else
         {
            newArr = _bagList.vectorListModel.elements[m] as Array;
            newArr[n] = info;
            _bagList.vectorListModel.replaceAt(m,newArr);
         }
      }
      
      private function __remove(event:DictionaryEvent) : void
      {
         var info:CardInfo = event.data as CardInfo;
         var m:int = info.Place % 4 == 0?info.Place / 4 - 2:Number(info.Place / 4 - 1);
         var n:int = info.Place % 4 == 0?4:Number(info.Place % 4);
         var newArr:Array = _bagList.vectorListModel.elements[m] as Array;
         newArr[n] = null;
         _bagList.vectorListModel.replaceAt(m,newArr);
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         var m:int = 0;
         var idVec:* = undefined;
         var j:int = 0;
         var data:* = null;
         SoundManager.instance.play("008");
         var sortData:Vector.<int> = new Vector.<int>();
         var sortArr:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         for(m = 0; m < sortArr.length; )
         {
            idVec = sortArr[m].cardIdVec;
            for(j = 0; j < idVec.length; )
            {
               data = PlayerManager.Instance.Self.cardBagDic;
               var _loc10_:int = 0;
               var _loc9_:* = data;
               for each(var info in data)
               {
                  if(info.TemplateID == idVec[j])
                  {
                     sortData.push(info.Place);
                     break;
                  }
               }
               j++;
            }
            m++;
         }
         SocketManager.Instance.out.sendSortCards(sortData);
      }
      
      public function dispose() : void
      {
         removeEvent();
         DragManager.removeListenWheelEvent();
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_sortBtn)
         {
            ObjectUtils.disposeObject(_sortBtn);
         }
         _sortBtn = null;
         if(_collectBtn)
         {
            ObjectUtils.disposeObject(_collectBtn);
         }
         _collectBtn = null;
         if(_bagList)
         {
            _bagList.dispose();
         }
         _bagList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
