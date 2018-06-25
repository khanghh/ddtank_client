package farm.viewx.helper
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.DoubleSelectedItem;
   import ddtBuried.BuriedManager;
   import flash.display.DisplayObject;
   
   public class HelperBeginFrame extends BaseAlerFrame
   {
       
      
      private var _explainText:FilterFrameText;
      
      private var _explainText2:FilterFrameText;
      
      private var _explainText3:FilterFrameText;
      
      private var _bgTitle:DisplayObject;
      
      public var modelType:int;
      
      private var _seedID:int;
      
      private var _seedTime:int;
      
      private var _needCount:int;
      
      private var _haveCount:int;
      
      private var _getCount:int;
      
      private var _needMoney:int;
      
      private var _moneyType:int;
      
      private var _moneyTypeText:String;
      
      private var _ifNeed:Boolean;
      
      private var _isDDTMoney:Boolean = false;
      
      private var _showPayMoneyBG:Image;
      
      private var _selectItem:DoubleSelectedItem;
      
      public function HelperBeginFrame()
      {
         super();
         var alertInfo:AlertInfo = new AlertInfo();
         alertInfo.escEnable = true;
         alertInfo.title = LanguageMgr.GetTranslation("ddt.farm.beginFrame.title");
         alertInfo.bottomGap = 37;
         alertInfo.buttonGape = 65;
         alertInfo.customPos = ComponentFactory.Instance.creat("farm.confirmHelperBeginAlertBtnPos");
         this.info = alertInfo;
         height = 250;
         _needCount = 0;
         _ifNeed = false;
         intView();
         intEvent();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         if(modelType == -1)
         {
            if(_needCount > 0)
            {
               _explainText.text = LanguageMgr.GetTranslation("ddt.farm.beginFrame.expText1",_needCount,_needMoney);
               _explainText.text = _explainText.text + _moneyTypeText;
               _explainText3.x = 57;
               _explainText3.y = 75;
               _explainText2.x = 105;
               _explainText2.y = 50;
               PositionUtils.setPos(_explainText,"farm.helperBeginExplainPos2");
               _submitButton.y = 133;
               _cancelButton.y = 133;
               addToContent(_explainText2);
               _selectItem = new DoubleSelectedItem();
               _selectItem.x = 159;
               _selectItem.y = 110;
               addToContent(_selectItem);
            }
            else
            {
               _explainText3.x = 57;
               _explainText3.y = 75;
               _submitButton.y = 133;
               _cancelButton.y = 133;
            }
            return;
         }
         if(_needCount > 0)
         {
            _explainText.text = LanguageMgr.GetTranslation("ddt.farm.beginFrame.expText1",_needCount,_needMoney);
            _explainText.text = _explainText.text + _moneyTypeText;
            _explainText2.x = 106;
            _explainText2.y = 69;
            _explainText3.x = 55;
            _explainText3.y = 99;
            PositionUtils.setPos(_explainText,"farm.helperBeginExplainPos2");
            _submitButton.y = 133;
            _cancelButton.y = 133;
            addToContent(_explainText2);
         }
         else
         {
            _submitButton.y = 133;
            _cancelButton.y = 133;
         }
      }
      
      private function intView() : void
      {
         _bgTitle = ComponentFactory.Instance.creat("assets.farm.titleSmall");
         PositionUtils.setPos(_bgTitle,"farm.HelperBeginTitlePos");
         addChild(_bgTitle);
         _explainText = ComponentFactory.Instance.creatComponentByStylename("assets.farm.beginFrame.explainText");
         _explainText.text = LanguageMgr.GetTranslation("ddt.farm.beginFrame.expText");
         PositionUtils.setPos(_explainText,"farm.helperBeginExplainPos1");
         addToContent(_explainText);
         _explainText2 = ComponentFactory.Instance.creatComponentByStylename("assets.farm.beginFrame.explainText2");
         _explainText2.text = LanguageMgr.GetTranslation("ddt.farm.beginFrame.expText2");
         _explainText3 = ComponentFactory.Instance.creatComponentByStylename("assets.farm.beginFrame.explainText3");
         _explainText3.text = LanguageMgr.GetTranslation("ddt.farm.beginFrame.expText3");
         addToContent(_explainText3);
      }
      
      private function intEvent() : void
      {
         addEventListener("response",__framePesponse);
      }
      
      protected function __framePesponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               removeEventListener("response",__framePesponse);
               dispose();
               break;
            case 2:
            case 3:
               submit();
               break;
            case 4:
               removeEventListener("response",__framePesponse);
               dispose();
         }
      }
      
      private function submit() : void
      {
         if(_needCount > 0)
         {
            switch(int(modelType) - -9)
            {
               case 0:
                  if(PlayerManager.Instance.Self.BandMoney < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
                     return;
                  }
                  break;
               case 1:
                  if(PlayerManager.Instance.Self.Money < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
                     return;
                  }
                  break;
               default:
                  if(PlayerManager.Instance.Self.Money < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
                     return;
                  }
                  break;
               default:
                  if(PlayerManager.Instance.Self.Money < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
                     return;
                  }
                  break;
               default:
                  if(PlayerManager.Instance.Self.Money < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
                     return;
                  }
                  break;
               default:
                  if(PlayerManager.Instance.Self.Money < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
                     return;
                  }
                  break;
               default:
                  if(PlayerManager.Instance.Self.Money < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("treasureHunting.tip1"));
                     return;
                  }
                  break;
               case 7:
                  if(PlayerManager.Instance.Self.DDTMoney < _needMoney)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.madelLack"));
                     return;
                  }
                  break;
               case 8:
                  if(BuriedManager.Instance.checkMoney(_selectItem.isBind,_needMoney))
                  {
                     return;
                  }
                  _isBand = _selectItem.isBind;
                  break;
            }
         }
         var array:Array = [];
         array.push(true);
         array.push(_seedID);
         array.push(_seedTime);
         array.push(_haveCount);
         array.push(_getCount);
         array.push(_moneyType);
         array.push(_needMoney);
         array.push(_isBand);
         SocketManager.Instance.out.sendBeginHelper(array);
         dispose();
      }
      
      private function __poorManResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         event.currentTarget.removeEventListener("response",__poorManResponse);
         ObjectUtils.disposeObject(event.currentTarget);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function removeEvent() : void
      {
         addEventListener("response",__framePesponse);
      }
      
      private function removeView() : void
      {
         if(_explainText)
         {
            ObjectUtils.disposeObject(_explainText);
         }
         _explainText = null;
      }
      
      public function get seedID() : int
      {
         return _seedID;
      }
      
      public function set seedID(value:int) : void
      {
         _seedID = value;
      }
      
      public function get seedTime() : int
      {
         return _seedTime;
      }
      
      public function set seedTime(value:int) : void
      {
         _seedTime = value;
      }
      
      public function get needCount() : int
      {
         return _needCount;
      }
      
      public function set needCount(value:int) : void
      {
         var i:int = 0;
         var ID:int = 0;
         _needCount = value;
         var infoList:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         for(i = 0; i < infoList.length; )
         {
            ID = infoList[i].TemplateID;
            if(_seedID == ID)
            {
               _needMoney = _needCount * infoList[i].AValue1;
               _moneyType = infoList[i].APrice1;
               if(_needCount * infoList[i].getItemPrice(1).ddtMoneyValue > 0)
               {
                  _isDDTMoney = true;
                  _moneyTypeText = " " + LanguageMgr.GetTranslation("medalMoney");
               }
               if(_needCount * infoList[i].getItemPrice(1).bothMoneyValue > 0)
               {
                  _isDDTMoney = false;
                  _moneyTypeText = " " + LanguageMgr.GetTranslation("money");
               }
            }
            i++;
         }
      }
      
      public function get haveCount() : int
      {
         return _haveCount;
      }
      
      public function set haveCount(value:int) : void
      {
         _haveCount = value;
      }
      
      public function get getCount() : int
      {
         return _getCount;
      }
      
      public function set getCount(value:int) : void
      {
         _getCount = value;
      }
      
      override public function dispose() : void
      {
         removeView();
         removeEvent();
         if(_selectItem)
         {
            ObjectUtils.disposeObject(_selectItem);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
