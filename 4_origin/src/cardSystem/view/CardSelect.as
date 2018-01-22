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
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = new CardSelectItem();
            _loc2_.info = _loc1_[_loc3_];
            _loc2_.addEventListener("select_cards",__itemClick);
            _itemList.push(_loc2_);
            _list.addChild(_loc2_);
            _loc3_++;
         }
         _panel.invalidateViewport();
      }
      
      private function __itemClick(param1:CardSocketEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = param1.data.id;
         var _loc3_:Vector.<SetsInfo> = CardManager.Instance.model.setsSortRuleVector;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(int(_loc4_.ID) == _loc2_)
            {
               _cardIdVec = _loc4_.cardIdVec;
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
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:Vector.<CardInfo> = new Vector.<CardInfo>();
         _loc5_ = 0;
         while(_loc5_ < _cardIdVec.length)
         {
            _loc4_ = PlayerManager.Instance.Self.cardBagDic;
            _loc1_ = null;
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for each(var _loc2_ in _loc4_)
            {
               if(_loc2_.TemplateID == _cardIdVec[_loc5_])
               {
                  _loc3_.push(_loc2_);
                  break;
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function dealNeedEquip() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = PlayerManager.Instance.Self.cardEquipDic;
         for(var _loc2_ in PlayerManager.Instance.Self.cardEquipDic)
         {
            if(PlayerManager.Instance.Self.cardEquipDic != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _bagCard.length)
               {
                  if(PlayerManager.Instance.Self.cardEquipDic[_loc2_].TemplateID == _bagCard[_loc3_].TemplateID)
                  {
                     _bagCard.splice(_loc3_,1);
                     _loc1_ = _equipArr.indexOf(int(_loc2_));
                     if(_loc1_ > -1)
                     {
                        _equipArr.splice(_loc1_,1);
                     }
                     break;
                  }
                  _loc3_++;
               }
               continue;
            }
            break;
         }
      }
      
      private function moveAllCard() : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:DictionaryData = new DictionaryData();
         _bagCard = getbagCard();
         if(_bagCard.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.noHaveCard"));
            return;
         }
         _equipArr = [1,2,3,4];
         dealNeedEquip();
         _loc6_ = 0;
         while(_loc6_ < _bagCard.length)
         {
            if(_bagCard[_loc6_].templateInfo.Property8 == "1")
            {
               _loc5_.add(0,_bagCard[_loc6_].Place);
            }
            else
            {
               _loc4_ = 1;
               while(_loc4_ < 5)
               {
                  if(PlayerManager.Instance.Self.cardEquipDic[_loc4_] == null)
                  {
                     if(_loc5_[_loc4_] == null)
                     {
                        _loc5_.add(_loc4_,_bagCard[_loc6_].Place);
                        break;
                     }
                  }
                  if(_loc4_ == 4)
                  {
                     _loc2_ = 0;
                     while(_loc2_ < _equipArr.length)
                     {
                        _loc1_ = _equipArr[_loc2_];
                        if(_loc5_[_loc1_] == null)
                        {
                           _equipArr.splice(_loc2_,1);
                           _loc5_.add(_loc1_,_bagCard[_loc6_].Place);
                           break;
                        }
                        _loc2_++;
                     }
                  }
                  _loc4_++;
               }
            }
            _loc6_++;
         }
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_;
         for(var _loc3_ in _loc5_)
         {
            SocketManager.Instance.out.sendMoveCards(_loc5_[_loc3_],int(_loc3_));
         }
         if(_loc5_.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.text"));
         }
         if(_loc5_.length > 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.card.HaveCard"));
         }
      }
      
      override protected function __hideThis(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(DisplayUtils.isTargetOrContain(_loc2_,_panel.vScrollbar))
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
         var _loc1_:int = 0;
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
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].removeEventListener("select_cards",__itemClick);
            ObjectUtils.disposeObject(_itemList[_loc1_]);
            _itemList[_loc1_] = null;
            _loc1_++;
         }
         _itemList = null;
      }
   }
}
