package cardSystem.view.cardCollect
{
   import cardSystem.CardManager;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CollectBagView extends Sprite implements Disposeable
   {
      
      public static const SELECT:String = "selected";
       
      
      private var _container:VBox;
      
      private var _collectItemVector:Vector.<CollectBagItem>;
      
      private var _turnPage:CollectTurnPage;
      
      private var _currentCollectItem:CollectBagItem;
      
      public function CollectBagView()
      {
         super();
         initView();
      }
      
      public function get currentItemSetsInfo() : SetsInfo
      {
         return _currentCollectItem.setsInfo;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         _container = ComponentFactory.Instance.creatComponentByStylename("CollectBagView.container");
         _turnPage = ComponentFactory.Instance.creatCustomObject("CollectTurnPage");
         addChild(_container);
         addChild(_turnPage);
         _collectItemVector = new Vector.<CollectBagItem>(3);
         for(i = 0; i < 3; )
         {
            _collectItemVector[i] = new CollectBagItem();
            _container.addChild(_collectItemVector[i]);
            i++;
         }
         _turnPage.addEventListener("change",__turnPage);
         _turnPage.maxPage = Math.ceil(CardManager.Instance.model.setsSortRuleVector.length / 3);
         _turnPage.page = 1;
      }
      
      private function __clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var item:CollectBagItem = event.currentTarget as CollectBagItem;
         seleted(item);
      }
      
      private function seleted(item:CollectBagItem) : void
      {
         var i:int = 0;
         _currentCollectItem = item;
         _currentCollectItem.seleted = true;
         for(i = 0; i < 3; )
         {
            if(_collectItemVector[i] != _currentCollectItem)
            {
               _collectItemVector[i].seleted = false;
            }
            i++;
         }
         dispatchEvent(new Event("selected"));
      }
      
      private function setPage(page:int) : void
      {
         var i:int = 0;
         var setsArr:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         var len:int = setsArr.length;
         for(i = 0; i < 3; )
         {
            if((page - 1) * 3 + i < len)
            {
               _collectItemVector[i].setsInfo = setsArr[(page - 1) * 3 + i];
               _collectItemVector[i].setSetsDate(CardManager.Instance.model.getSetsCardFromCardBag(setsArr[(page - 1) * 3 + i].ID));
               _collectItemVector[i].addEventListener("click",__clickHandler);
               _collectItemVector[i].addEventListener("mouseOver",__overHandler);
               _collectItemVector[i].addEventListener("mouseOut",__outHandler);
            }
            else
            {
               _collectItemVector[i].setsInfo = null;
               _collectItemVector[i].mouseEnabled = false;
               _collectItemVector[i].removeEventListener("click",__clickHandler);
               _collectItemVector[i].removeEventListener("mouseOver",__overHandler);
               _collectItemVector[i].removeEventListener("mouseOut",__outHandler);
            }
            i++;
         }
         seleted(_collectItemVector[0]);
      }
      
      private function __overHandler(event:MouseEvent) : void
      {
         (event.currentTarget as CollectBagItem).filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function __outHandler(event:MouseEvent) : void
      {
         (event.currentTarget as CollectBagItem).filters = null;
      }
      
      private function removeEvent() : void
      {
         _turnPage.removeEventListener("change",__turnPage);
      }
      
      protected function __turnPage(event:Event) : void
      {
         setPage(_turnPage.page);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         for(i = 0; i < 3; )
         {
            if(_collectItemVector[i])
            {
               _collectItemVector[i].removeEventListener("click",__clickHandler);
               _collectItemVector[i].removeEventListener("mouseOver",__overHandler);
               _collectItemVector[i].removeEventListener("mouseOut",__outHandler);
               _collectItemVector[i].dispose();
            }
            _collectItemVector[i] = null;
            i++;
         }
         _currentCollectItem = null;
         if(_turnPage)
         {
            _turnPage.dispose();
         }
         _turnPage = null;
         if(_container)
         {
            ObjectUtils.disposeObject(_container);
         }
         _container = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
