package dragonBoat.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class KingStatueNormalBuildView extends BaseAlerFrame
   {
       
      
      private var _item:InventoryItemInfo;
      
      private var _item2:InventoryItemInfo;
      
      private var _itemMax:int;
      
      private var _itemMax2:int;
      
      private var _checkBtn1:SelectedCheckButton;
      
      private var _checkBtn2:SelectedCheckButton;
      
      private var _selectedGroup:SelectedButtonGroup;
      
      private var _sprite1:Sprite;
      
      private var _inputBg:Bitmap;
      
      private var _inputText:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _sprite2:Sprite;
      
      private var _inputBg2:Bitmap;
      
      private var _inputText2:FilterFrameText;
      
      private var _maxBtn2:SimpleBitmapButton;
      
      private var _bottomPromptTxt:FilterFrameText;
      
      private var _type:int;
      
      public function KingStatueNormalBuildView()
      {
         super();
      }
      
      public function init2(type:int) : void
      {
         _type = type;
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         var title:* = null;
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         escEnable = true;
         _checkBtn1 = ComponentFactory.Instance.creatComponentByStylename("KingStatue.checkBtn1");
         addToContent(_checkBtn1);
         _checkBtn2 = ComponentFactory.Instance.creatComponentByStylename("KingStatue.checkBtn2");
         addToContent(_checkBtn2);
         _selectedGroup = new SelectedButtonGroup();
         _selectedGroup.addSelectItem(_checkBtn1);
         _selectedGroup.addSelectItem(_checkBtn2);
         _selectedGroup.selectIndex = 0;
         _sprite1 = new Sprite();
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.normal.inputBg");
         _inputBg.x = 0;
         _inputBg.y = 0;
         _sprite1.addChild(_inputBg);
         _inputText = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalInputTxt");
         _inputText.text = "1";
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normal.maxBtn");
         _sprite2 = new Sprite();
         _inputBg2 = ComponentFactory.Instance.creatBitmap("asset.dragonBoat.mainFrame.normal.inputBg");
         _inputBg2.x = 0;
         _inputBg2.y = 0;
         _sprite2.addChild(_inputBg2);
         _inputText2 = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normalInputTxt");
         _inputText2.text = "1";
         _maxBtn2 = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.normal.maxBtn");
         _sprite2.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _inputText2.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _inputText2.mouseEnabled = false;
         _maxBtn2.enable = false;
         _bottomPromptTxt = ComponentFactory.Instance.creatComponentByStylename("dragonBoat.mainFrame.consumePromptTxt2");
         PositionUtils.setPos(_sprite1,"kingStatue.consumeFrame.inputBgPos");
         PositionUtils.setPos(_inputText,"kingStatue.consumeFrame.inputTxtPos");
         PositionUtils.setPos(_maxBtn,"kingStatue.consumeFrame.maxBtnPos");
         PositionUtils.setPos(_sprite2,"kingStatue.consumeFrame.inputBg2Pos");
         PositionUtils.setPos(_inputText2,"kingStatue.consumeFrame.inputTxt2Pos");
         PositionUtils.setPos(_maxBtn2,"kingStatue.consumeFrame.maxBtn2Pos");
         PositionUtils.setPos(_bottomPromptTxt,"kingStatue.consumeFrame.tipsPos");
         switch(int(_type))
         {
            case 0:
               title = LanguageMgr.GetTranslation("ddt.dragonBoat.normalBuildTxt");
               _checkBtn1.text = LanguageMgr.GetTranslation("kingStatue.inputLowChip");
               _checkBtn2.text = LanguageMgr.GetTranslation("kingStatue.inputHighChip");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("kingStatue.normalBuildTips");
               break;
            case 1:
               title = LanguageMgr.GetTranslation("ddt.dragonBoat.normalDecorateTxt");
               _checkBtn1.text = LanguageMgr.GetTranslation("kingStatue.inputLowChip");
               _checkBtn2.text = LanguageMgr.GetTranslation("kingStatue.inputHighChip");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("kingStatue.normalBuildTips");
               break;
            case 2:
               title = LanguageMgr.GetTranslation("laurel.normalFerilizeTxt");
               _checkBtn1.text = LanguageMgr.GetTranslation("laurel.useFerilizer");
               _checkBtn2.text = LanguageMgr.GetTranslation("laurel.useHighFerilizer");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("laurel.normalFerilizeTips");
               break;
            case 3:
               title = LanguageMgr.GetTranslation("laurel.normalPrayTxt");
               _checkBtn1.text = LanguageMgr.GetTranslation("laurel.useFerilizer");
               _checkBtn2.text = LanguageMgr.GetTranslation("laurel.useHighFerilizer");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("laurel.normalFerilizeTips");
               break;
            case 4:
               title = LanguageMgr.GetTranslation("floatParade.normalPrayTxt");
               _checkBtn1.text = LanguageMgr.GetTranslation("floatParade.useFerilizer");
               _checkBtn2.text = LanguageMgr.GetTranslation("floatParade.useHighFerilizer");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("floatParade.normalFerilizeTips");
               break;
            default:
               title = LanguageMgr.GetTranslation("floatParade.normalPrayTxt");
               _checkBtn1.text = LanguageMgr.GetTranslation("floatParade.useFerilizer");
               _checkBtn2.text = LanguageMgr.GetTranslation("floatParade.useHighFerilizer");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("floatParade.normalFerilizeTips");
               break;
            case 6:
               title = LanguageMgr.GetTranslation("ddtking.normalFerilizeTxt.title");
               _checkBtn1.text = LanguageMgr.GetTranslation("ddtking.normalFerilizeTxt");
               _checkBtn2.text = LanguageMgr.GetTranslation("ddtking.highUseFerilizer");
               _bottomPromptTxt.text = LanguageMgr.GetTranslation("ddtking.normalFerilizeTips");
         }
         var _alertInfo:AlertInfo = new AlertInfo(title,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         _alertInfo.autoDispose = false;
         _alertInfo.sound = "008";
         info = _alertInfo;
         addToContent(_sprite1);
         addToContent(_inputText);
         addToContent(_maxBtn);
         addToContent(_sprite2);
         addToContent(_inputText2);
         addToContent(_maxBtn2);
         addToContent(_bottomPromptTxt);
      }
      
      private function initData() : void
      {
         switch(int(_type))
         {
            case 0:
            case 1:
               _item = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11771);
               _itemMax = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11771,false);
               _item2 = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11772);
               _itemMax2 = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11772,false);
               break;
            case 2:
            case 3:
               _item = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11855);
               _itemMax = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11855,false);
               _item2 = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11856);
               _itemMax2 = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11856,false);
               break;
            case 4:
               _item = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11868);
               _itemMax = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11868,false);
               _item2 = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11869);
               _itemMax2 = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11869,false);
               break;
            default:
               _item = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11868);
               _itemMax = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11868,false);
               _item2 = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(11869);
               _itemMax2 = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11869,false);
               break;
            case 6:
            case 7:
               _item = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(12523);
               _itemMax = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12523,false);
               _item2 = PlayerManager.Instance.Self.PropBag.getItemByTemplateId(12524);
               _itemMax2 = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(12524,false);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler,false,0,true);
         _inputText.addEventListener("change",inputTextChangeHandler,false,0,true);
         _inputText2.addEventListener("change",inputTextChangeHandler,false,0,true);
         _maxBtn.addEventListener("click",changeMaxHandler,false,0,true);
         _maxBtn2.addEventListener("click",changeMaxHandler,false,0,true);
         _selectedGroup.addEventListener("change",__groupChangeHandler);
      }
      
      private function __groupChangeHandler(event:Event) : void
      {
         SoundManager.instance.playButtonSound();
         switch(int(_selectedGroup.selectIndex))
         {
            case 0:
               _sprite1.filters = [];
               _inputText.filters = [];
               _inputText.mouseEnabled = true;
               _maxBtn.enable = true;
               _sprite2.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _inputText2.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _inputText2.mouseEnabled = false;
               _maxBtn2.enable = false;
               break;
            case 1:
               _sprite2.filters = [];
               _inputText2.filters = [];
               _inputText2.mouseEnabled = true;
               _maxBtn2.enable = true;
               _sprite1.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _inputText.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _inputText.mouseEnabled = false;
               _maxBtn.enable = false;
         }
      }
      
      private function inputTextChangeHandler(event:Event) : void
      {
         var input:FilterFrameText = event.currentTarget as FilterFrameText;
         var num:int = input.text;
         if(num < 0)
         {
            input.text = "0";
         }
         var _loc4_:* = event.currentTarget;
         if(_inputText !== _loc4_)
         {
            if(_inputText2 === _loc4_)
            {
               if(_item2)
               {
                  if(num > _itemMax2)
                  {
                     input.text = _itemMax2.toString();
                  }
               }
            }
         }
         else if(_item)
         {
            if(num > _itemMax)
            {
               input.text = _itemMax.toString();
            }
         }
      }
      
      private function changeMaxHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = event.currentTarget;
         if(_maxBtn !== _loc2_)
         {
            if(_maxBtn2 === _loc2_)
            {
               if(_item2)
               {
                  _inputText2.text = _itemMax2.toString();
               }
            }
         }
         else if(_item)
         {
            _inputText.text = _itemMax.toString();
         }
      }
      
      private function enterKeyHandler() : void
      {
         switch(int(_selectedGroup.selectIndex))
         {
            case 0:
               SocketManager.Instance.out.sendDragonBoatBuildOrDecorate(1,int(_inputText.text),false);
               break;
            case 1:
               SocketManager.Instance.out.sendDragonBoatBuildOrDecorate(1,int(_inputText2.text),true);
         }
         dispose();
      }
      
      private function responseHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
            case 3:
            case 4:
               enterKeyHandler();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _inputText.removeEventListener("change",inputTextChangeHandler);
         _inputText2.removeEventListener("change",inputTextChangeHandler);
         _maxBtn.removeEventListener("click",changeMaxHandler);
         _maxBtn2.removeEventListener("click",changeMaxHandler);
         _selectedGroup.removeEventListener("change",__groupChangeHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_maxBtn);
         _maxBtn = null;
         ObjectUtils.disposeObject(_inputBg2);
         _inputBg2 = null;
         ObjectUtils.disposeObject(_inputText2);
         _inputText2 = null;
         ObjectUtils.disposeObject(_maxBtn2);
         _maxBtn2 = null;
         ObjectUtils.disposeObject(_bottomPromptTxt);
         _bottomPromptTxt = null;
         super.dispose();
      }
   }
}
