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
         var _loc1_:int = 0;
         _container = ComponentFactory.Instance.creatComponentByStylename("CollectBagView.container");
         _turnPage = ComponentFactory.Instance.creatCustomObject("CollectTurnPage");
         addChild(_container);
         addChild(_turnPage);
         _collectItemVector = new Vector.<CollectBagItem>(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _collectItemVector[_loc1_] = new CollectBagItem();
            _container.addChild(_collectItemVector[_loc1_]);
            _loc1_++;
         }
         _turnPage.addEventListener("change",__turnPage);
         _turnPage.maxPage = Math.ceil(CardManager.Instance.model.setsSortRuleVector.length / 3);
         _turnPage.page = 1;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:CollectBagItem = param1.currentTarget as CollectBagItem;
         seleted(_loc2_);
      }
      
      private function seleted(param1:CollectBagItem) : void
      {
         var _loc2_:int = 0;
         _currentCollectItem = param1;
         _currentCollectItem.seleted = true;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            if(_collectItemVector[_loc2_] != _currentCollectItem)
            {
               _collectItemVector[_loc2_].seleted = false;
            }
            _loc2_++;
         }
         dispatchEvent(new Event("selected"));
      }
      
      private function setPage(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if((param1 - 1) * 3 + _loc4_ < _loc3_)
            {
               _collectItemVector[_loc4_].setsInfo = _loc2_[(param1 - 1) * 3 + _loc4_];
               _collectItemVector[_loc4_].setSetsDate(CardManager.Instance.model.getSetsCardFromCardBag(_loc2_[(param1 - 1) * 3 + _loc4_].ID));
               _collectItemVector[_loc4_].addEventListener("click",__clickHandler);
               _collectItemVector[_loc4_].addEventListener("mouseOver",__overHandler);
               _collectItemVector[_loc4_].addEventListener("mouseOut",__outHandler);
            }
            else
            {
               _collectItemVector[_loc4_].setsInfo = null;
               _collectItemVector[_loc4_].mouseEnabled = false;
               _collectItemVector[_loc4_].removeEventListener("click",__clickHandler);
               _collectItemVector[_loc4_].removeEventListener("mouseOver",__overHandler);
               _collectItemVector[_loc4_].removeEventListener("mouseOut",__outHandler);
            }
            _loc4_++;
         }
         seleted(_collectItemVector[0]);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as CollectBagItem).filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as CollectBagItem).filters = null;
      }
      
      private function removeEvent() : void
      {
         _turnPage.removeEventListener("change",__turnPage);
      }
      
      protected function __turnPage(param1:Event) : void
      {
         setPage(_turnPage.page);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            if(_collectItemVector[_loc1_])
            {
               _collectItemVector[_loc1_].removeEventListener("click",__clickHandler);
               _collectItemVector[_loc1_].removeEventListener("mouseOver",__overHandler);
               _collectItemVector[_loc1_].removeEventListener("mouseOut",__outHandler);
               _collectItemVector[_loc1_].dispose();
            }
            _collectItemVector[_loc1_] = null;
            _loc1_++;
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
