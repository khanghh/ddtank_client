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
         var _loc1_:AlertInfo = new AlertInfo();
         _loc1_.escEnable = true;
         _loc1_.title = LanguageMgr.GetTranslation("ddt.farm.beginFrame.title");
         _loc1_.bottomGap = 37;
         _loc1_.buttonGape = 65;
         _loc1_.customPos = ComponentFactory.Instance.creat("farm.confirmHelperBeginAlertBtnPos");
         this.info = _loc1_;
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
      
      protected function __framePesponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
         var _loc1_:Array = [];
         _loc1_.push(true);
         _loc1_.push(_seedID);
         _loc1_.push(_seedTime);
         _loc1_.push(_haveCount);
         _loc1_.push(_getCount);
         _loc1_.push(_moneyType);
         _loc1_.push(_needMoney);
         _loc1_.push(_isBand);
         SocketManager.Instance.out.sendBeginHelper(_loc1_);
         dispose();
      }
      
      private function __poorManResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",__poorManResponse);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(param1.responseCode == 3 || param1.responseCode == 2)
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
      
      public function set seedID(param1:int) : void
      {
         _seedID = param1;
      }
      
      public function get seedTime() : int
      {
         return _seedTime;
      }
      
      public function set seedTime(param1:int) : void
      {
         _seedTime = param1;
      }
      
      public function get needCount() : int
      {
         return _needCount;
      }
      
      public function set needCount(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _needCount = param1;
         var _loc2_:Vector.<ShopItemInfo> = ShopManager.Instance.getValidGoodByType(88);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_].TemplateID;
            if(_seedID == _loc3_)
            {
               _needMoney = _needCount * _loc2_[_loc4_].AValue1;
               _moneyType = _loc2_[_loc4_].APrice1;
               if(_needCount * _loc2_[_loc4_].getItemPrice(1).ddtMoneyValue > 0)
               {
                  _isDDTMoney = true;
                  _moneyTypeText = " " + LanguageMgr.GetTranslation("medalMoney");
               }
               if(_needCount * _loc2_[_loc4_].getItemPrice(1).bothMoneyValue > 0)
               {
                  _isDDTMoney = false;
                  _moneyTypeText = " " + LanguageMgr.GetTranslation("money");
               }
            }
            _loc4_++;
         }
      }
      
      public function get haveCount() : int
      {
         return _haveCount;
      }
      
      public function set haveCount(param1:int) : void
      {
         _haveCount = param1;
      }
      
      public function get getCount() : int
      {
         return _getCount;
      }
      
      public function set getCount(param1:int) : void
      {
         _getCount = param1;
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
