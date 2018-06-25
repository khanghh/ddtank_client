package cardSystem.view
{
   import cardSystem.CardManager;
   import cardSystem.CardSocketEvent;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import cardSystem.view.cardCollect.CardSelectItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.chat.ChatBasePanel;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class CardSelect extends ChatBasePanel implements Disposeable
   {
       
      
      private var _list:VBox;
      
      private var _bg:ScaleBitmapImage;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<CardSelectItem>;
      
      private var _cardinfo:Vector.<CardInfo>;
      
      private var _cardIdVec:Vector.<int>;
      
      private var _bagCard:Vector.<CardInfo>;
      
      private var _equipArr:Array;
      
      public function CardSelect()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _itemList = new Vector.<CardSelectItem>();
         _cardinfo = new Vector.<CardInfo>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("chat.CardListBg");
         _list = new VBox();
         _panel = ComponentFactory.Instance.creatComponentByStylename("CardBagView.cardselect");
         _panel.setView(_list);
         addChild(_bg);
         addChild(_panel);
         setList();
      }
      
      private function setList() : void
      {
         var i:int = 0;
         var item:* = null;
         var infoList:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         for(i = 0; i < infoList.length; )
         {
            item = new CardSelectItem();
            item.info = infoList[i];
            item.addEventListener("select_cards",__itemClick);
            _itemList.push(item);
            _list.addChild(item);
            i++;
         }
         _panel.invalidateViewport();
      }
      
      private function __itemClick(e:CardSocketEvent) : void
      {
         SoundManager.instance.play("008");
         var id:int = e.data.id;
         var infoList:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         var _loc6_:int = 0;
         var _loc5_:* = infoList;
         for each(var info in infoList)
         {
            if(int(info.ID) == id)
            {
               _cardIdVec = info.cardIdVec;
               break;
            }
         }
         if(_cardIdVec != null)
         {
            moveAllCard();
         }
      }
      
      private function getbagCard() : Vector.<CardInfo>
      {
         var i:int = 0;
         var bagCardDic:* = null;
         var cInfo:* = null;
         var temp:Vector.<CardInfo> = new Vector.<CardInfo>();
         for(i = 0; i < _cardIdVec.length; )
         {
            bagCardDic = PlayerManager.Instance.Self.cardBagDic;
            cInfo = null;
            var _loc7_:int = 0;
            var _loc6_:* = bagCardDic;
            for each(var cardInfo in bagCardDic)
            {
               if(cardInfo.TemplateID == _cardIdVec[i])
               {
                  temp.push(cardInfo);
                  break;
               }
            }
            i++;
         }
         return temp;
      }
      
      private function dealNeedEquip() : void
      {
         var i:int = 0;
         var index:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = PlayerManager.Instance.Self.cardEquipDic;
         for(var place in PlayerManager.Instance.Self.cardEquipDic)
         {
            if(PlayerManager.Instance.Self.cardEquipDic == null)
            {
               break;
            }
            i = 0;
            while(i < _bagCard.length)
            {
               if(PlayerManager.Instance.Self.cardEquipDic[place].TemplateID == _bagCard[i].TemplateID)
               {
                  _bagCard.splice(i,1);
                  index = _equipArr.indexOf(int(place));
                  if(index > -1)
                  {
                     _equipArr.splice(index,1);
                  }
                  break;
               }
               i++;
            }
         }
      }
      
      private function moveAllCard() : void
      {
         var i:int = 0;
         var j:int = 0;
         var n:int = 0;
         var mplace:int = 0;
         var sendCardObj:DictionaryData = new DictionaryData();
         _bagCard = getbagCard();
         if(_bagCard.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.noHaveCard"));
            return;
         }
         _equipArr = [1,2,3,4];
         dealNeedEquip();
         for(i = 0; i < _bagCard.length; )
         {
            if(_bagCard[i].templateInfo.Property8 == "1")
            {
               sendCardObj.add(0,_bagCard[i].Place);
            }
            else
            {
               j = 1;
               while(j < 5)
               {
                  if(PlayerManager.Instance.Self.cardEquipDic[j] == null)
                  {
                     if(sendCardObj[j] == null)
                     {
                        sendCardObj.add(j,_bagCard[i].Place);
                        break;
                     }
                  }
                  if(j == 4)
                  {
                     for(n = 0; n < _equipArr.length; )
                     {
                        mplace = _equipArr[n];
                        if(sendCardObj[mplace] == null)
                        {
                           _equipArr.splice(n,1);
                           sendCardObj.add(mplace,_bagCard[i].Place);
                           break;
                        }
                        n++;
                     }
                  }
                  j++;
               }
            }
            i++;
         }
         var _loc8_:int = 0;
         var _loc7_:* = sendCardObj;
         for(var place in sendCardObj)
         {
            SocketManager.Instance.out.sendMoveCards(sendCardObj[place],int(place));
         }
         if(sendCardObj.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.text"));
         }
         if(sendCardObj.length > 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.HaveCard"));
         }
      }
      
      override protected function __hideThis(event:MouseEvent) : void
      {
         var target:DisplayObject = event.target as DisplayObject;
         if(DisplayUtils.isTargetOrContain(target,_panel.vScrollbar))
         {
            return;
         }
         SoundManager.instance.play("008");
         setVisible = false;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         while(i < _itemList.length)
         {
            _itemList[i].removeEventListener("select_cards",__itemClick);
            ObjectUtils.disposeObject(_itemList[i]);
            _itemList[i] = null;
            i++;
         }
         _itemList = null;
      }
   }
}
