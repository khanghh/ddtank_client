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
      
      private function __collectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CardControl.Instance.showCollectView();
      }
      
      private function __upData(param1:DictionaryEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:CardInfo = param1.data as CardInfo;
         var _loc3_:int = _loc6_.Place % 4 == 0?_loc6_.Place / 4 - 2:Number(_loc6_.Place / 4 - 1);
         var _loc2_:int = _loc6_.Place % 4 == 0?4:Number(_loc6_.Place % 4);
         if(_bagList.vectorListModel.elements[_loc3_] == null)
         {
            _loc4_ = [];
            _loc4_[0] = _loc3_ + 1;
            _loc4_[_loc2_] = _loc6_;
            _bagList.vectorListModel.append(_loc4_);
         }
         else
         {
            _loc5_ = _bagList.vectorListModel.elements[_loc3_] as Array;
            _loc5_[_loc2_] = _loc6_;
            _bagList.vectorListModel.replaceAt(_loc3_,_loc5_);
         }
      }
      
      private function __remove(param1:DictionaryEvent) : void
      {
         var _loc5_:CardInfo = param1.data as CardInfo;
         var _loc3_:int = _loc5_.Place % 4 == 0?_loc5_.Place / 4 - 2:Number(_loc5_.Place / 4 - 1);
         var _loc2_:int = _loc5_.Place % 4 == 0?4:Number(_loc5_.Place % 4);
         var _loc4_:Array = _bagList.vectorListModel.elements[_loc3_] as Array;
         _loc4_[_loc2_] = null;
         _bagList.vectorListModel.replaceAt(_loc3_,_loc4_);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = undefined;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         SoundManager.instance.play("008");
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc2_:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         _loc6_ = 0;
         while(_loc6_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc6_].cardIdVec;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc4_ = PlayerManager.Instance.Self.cardBagDic;
               var _loc10_:int = 0;
               var _loc9_:* = _loc4_;
               for each(var _loc8_ in _loc4_)
               {
                  if(_loc8_.TemplateID == _loc5_[_loc7_])
                  {
                     _loc3_.push(_loc8_.Place);
                     break;
                  }
               }
               _loc7_++;
            }
            _loc6_++;
         }
         SocketManager.Instance.out.sendSortCards(_loc3_);
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
